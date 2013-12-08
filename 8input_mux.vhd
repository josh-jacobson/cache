library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity a8input_mux is
  port (
    a1       : in  std_logic_vector(31 downto 0);
    b1       : in  std_logic_vector(31 downto 0);
    a2       : in  std_logic_vector(31 downto 0);
    b2       : in  std_logic_vector(31 downto 0);
    a3       : in  std_logic_vector(31 downto 0);
    b3       : in  std_logic_vector(31 downto 0);
    a4       : in  std_logic_vector(31 downto 0);
    b4       : in  std_logic_vector(31 downto 0);
    sig      : in  std_logic_vector(2 downto 0);
    z        : out std_logic_vector(31 downto 0)
  );
end a8input_mux;

architecture structural of a8input_mux is

signal res1 : std_logic_vector(31 downto 0);
signal res2 : std_logic_vector(31 downto 0);
signal res3 : std_logic_vector(31 downto 0);
signal res4 : std_logic_vector(31 downto 0);

signal nt1 : std_logic_vector(31 downto 0);
signal nt2 : std_logic_vector(31 downto 0);

begin

  lt1 : mux_32 port map (sel => sig(0), src0 => a1, src1=> b1, z => res1); 
  lt2 : mux_32 port map (sel => sig(0), src0 => a2, src1=> b2, z => res2); 
  lt3 : mux_32 port map (sel => sig(0), src0 => a3, src1=> b3, z => res3); 
  lt4 : mux_32 port map (sel => sig(0), src0 => a4, src1=> b4, z => res4); 
    
  mt1 : mux_32 port map (sel => sig(1), src0 => res1, src1=> res2, z => nt1); 
  mt2 : mux_32 port map (sel => sig(1), src0 => res3, src1=> res4, z => nt2);
  
  ut : mux_32 port map (sel => sig(2), src0 => nt1, src1=> nt2, z => z);  
    
end architecture structural;

