library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

-- This is a counter to be used as a hit or miss counter for L1 and L2 caches.

entity counter is
  port (
    clk   : in  std_logic;
    increment_enable   : in  std_logic;
    old_value   : in std_logic_vector(31 downto 0);
    new_value   : out std_logic_vector(31 downto 0)
  );
end counter;

architecture structural of counter is
    
    component rippleadder32 is
       port (
          x       : in  std_logic_vector(31 downto 0);
          y       : in  std_logic_vector(31 downto 0);
          c       : in  std_logic;
          z       : out std_logic_vector(31 downto 0);
          cout    : out std_logic
       );
    end component rippleadder32;
    
    signal incremented_value : std_logic_vector(31 downto 0);
    signal carry : std_logic;
begin
    adder_map : rippleadder32 port map (old_value, "00000000000000000000000000000001", '0', incremented_value, carry);
    mux_map: mux_32 port map (increment_enable, old_value, incremented_value, new_value);
end structural;
