library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity a4input512_mux is
  port (
    a1       : in  std_logic_vector(511 downto 0);
    b1       : in  std_logic_vector(511 downto 0);
    a2       : in  std_logic_vector(511 downto 0);
    b2       : in  std_logic_vector(511 downto 0);
    sig      : in  std_logic_vector(1 downto 0);
    z        : out std_logic_vector(511 downto 0)
  );
end a4input512_mux;

architecture structural of a4input512_mux is
component mux_512 is
  port (
        sel   : in  std_logic;
        src0  : in  std_logic_vector(511 downto 0);
        src1  : in  std_logic_vector(511 downto 0);
        z            : out std_logic_vector(511 downto 0)
  );
end component mux_512;
signal res1 : std_logic_vector(511 downto 0);
signal res2 : std_logic_vector(511 downto 0);

begin

  lt1 : mux_512 port map (sel => sig(0), src0 => a1, src1=> b1, z => res1); 
  lt2 : mux_512 port map (sel => sig(0), src0 => a2, src1=> b2, z => res2); 
  mt1 : mux_512 port map (sel => sig(1), src0 => res1, src1=> res2, z => z); 
    
end architecture structural;