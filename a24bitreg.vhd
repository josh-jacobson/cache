library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity a24bitreg is
  port (
    q       : out  std_logic_vector(23 downto 0);
    d       : in  std_logic_vector(23 downto 0);
    arst    : in  std_logic;
    aload   : in  std_logic;
    adata   : in  std_logic_vector(23 downto 0);
    enable  : in  std_logic;
    clk     : in  std_logic
  );
end a24bitreg;

architecture structural of a24bitreg is

begin

  FF_GEN: 
   for I in 0 to 23 generate
      dffint_map : dffr_a port map
        (d => d(I), arst => arst, aload  => aload, enable => enable, adata => adata(I), q => q(I), clk=> clk);
   end generate FF_GEN;
  
end architecture structural;