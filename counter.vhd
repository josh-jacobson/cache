library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

-- This is a counter to be used as a hit or miss counter for L1 and L2 caches.

entity counter is
  port (
    x   : in  std_logic_vector(n-1 downto 0);
    y   : in  std_logic_vector(n-1 downto 0);
    z   : out std_logic_vector(n-1 downto 0)
  );
end and_gate_n;

architecture structural of and_gate_n is
begin;
end structural;
