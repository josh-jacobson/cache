library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

-- This is the top level entity for our memory hierarchy.

entity cache_control is
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
end cache_control;

architecture structural of cache_control is
    
    signal we : std_logic; -- Global write enable signal
    signal ready : std_logic; -- Signal used to indicate that memory operation is complete. (set to 1 when data is ready)
    signal address : std_logic_vector(31 downto 0); -- Global address bus
    signal write_data : std_logic_vector(31 downto 0); -- Data to be written for write operations
    
    signal data_word : std_logic_vector(31 downto 0); -- 4 byte bus handling the final step of a memory access
    signal data_64 : std_logic_vector(511 downto 0); -- 64 byte bus handling fetches from L2 to L1
    signal data_256 : std_logic_vector(2047 downto 0); -- 256 byte bus handling fetches from memory to L2
    
    
component cache_test is
  generic (
    addr_trace_file : string;
    data_trace_file : string
  );
  port (
    DataIn : in std_logic_vector(31 downto 0);
    clk : in std_logic;
    Ready : in std_logic;
    rst : in std_logic;
    Addr : out std_logic_vector(31 downto 0);
    Data : out Std_logic_vector(31 downto 0);
    WR : out std_logic;
    Err : out std_logic
  );
end component cache_test;

-- L1 and L2 cache components here

    
   
begin
    -- L1 and L2 Mappings here
    cache_test_map : cache_test generic map (addr_trace_file, data_trace_file) port map (data_word, clk, ready, reset, address, write_data, we, Err);
    
end structural;
