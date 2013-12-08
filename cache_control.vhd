library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

-- This is the top level entity for our memory hierarchy.

entity cache_control is
  port (
    clk : in std_logic;
    Addr : out std_logic_vector(31 downto 0);
    Data : out Std_logic_vector(31 downto 0);
    WR : out std_logic;
    Err : out std_logic
  );
end cache_control;

architecture structural of cache_control is
    
   
begin
end structural;
