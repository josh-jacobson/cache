library ieee;
use ieee.std_logic_1164.all;

entity overall_testbench is
  port (
    Addr : out std_logic_vector(31 downto 0);
    Data : out Std_logic_vector(31 downto 0);
    Err : out std_logic
  );
end overall_testbench;

architecture structural of overall_testbench is

  signal clk, reset: std_logic;

  component cache_control is
  generic (
    addr_trace_file : string;
    data_trace_file : string
  );
  
  port (
    clk : in std_logic;
    reset : in std_logic;
    Addr : out std_logic_vector(31 downto 0);
    Data : out Std_logic_vector(31 downto 0);
    Err : out std_logic
  );
   end component cache_control;

begin

demo_map : cache_control generic map (addr_trace_file => "random_addr_trace", data_trace_file => "random_data_trace") port map (clk, reset, Addr, Data, Err);  
test_proc : process
  begin
    reset <= '1';
    wait for 400 ns;
    reset <= '0';
    clk <= '0';
    wait for 390 ns;
    wait;
    
  end process;
end architecture structural;



