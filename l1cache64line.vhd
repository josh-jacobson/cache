library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity l1cache64line is
  port (
    q       : out  std_logic_vector(63 downto 0);
    d       : in  std_logic_vector(63 downto 0);
    index	: in std_logic_vector(2 downto 0);
    enable  : in  std_logic;
    clk     : in  std_logic
  );
end l1cache64line;

architecture structural of l1cache64line is

begin

  csram_line_map : csram generic map (3, 64) port map ('1','1',enable,index,d,q);
  
end architecture structural;
