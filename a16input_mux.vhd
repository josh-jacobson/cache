library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity a16input_mux is
  port (
    o1       : in std_logic_vector(511 downto 0);
    o2       : in std_logic_vector(511 downto 0);
    o3       : in std_logic_vector(511 downto 0);
    o4       : in std_logic_vector(511 downto 0);
    o5       : in std_logic_vector(511 downto 0);
    o6       : in std_logic_vector(511 downto 0);
    o7       : in std_logic_vector(511 downto 0);
    o8       : in std_logic_vector(511 downto 0);
    o9       : in std_logic_vector(511 downto 0);
    o10       : in std_logic_vector(511 downto 0);
    o11       : in std_logic_vector(511 downto 0);
    o12       : in std_logic_vector(511 downto 0);
    o13       : in std_logic_vector(511 downto 0);
    o14       : in std_logic_vector(511 downto 0);
    o15       : in std_logic_vector(511 downto 0);
    o16       : in std_logic_vector(511 downto 0);
    sig      : in  std_logic_vector(3 downto 0);
    z        : out std_logic_vector(511 downto 0)
  );
end a16input_mux;

architecture structural of a16input_mux is




signal    a1       :  std_logic_vector(511 downto 0);
signal    b1       :  std_logic_vector(511 downto 0);
signal    a2       :  std_logic_vector(511 downto 0);
signal    b2       :  std_logic_vector(511 downto 0);
signal    a3       :  std_logic_vector(511 downto 0);
signal    b3       :  std_logic_vector(511 downto 0);
signal    a4       :  std_logic_vector(511 downto 0);
signal    b4       :  std_logic_vector(511 downto 0);    

signal res1 : std_logic_vector(511 downto 0);
signal res2 : std_logic_vector(511 downto 0);
signal res3 : std_logic_vector(511 downto 0);
signal res4 : std_logic_vector(511 downto 0);

signal nt1 : std_logic_vector(511 downto 0);
signal nt2 : std_logic_vector(511 downto 0);

begin
  

  nnt1 : mux_n generic map (512) port map (sel => sig(0), src0 => o1, src1=> o9, z => a1); 
  nnt2 : mux_n generic map (512) port map (sel => sig(0), src0 => o2, src1=> o10, z => a2); 
  nnt3 : mux_n generic map (512) port map (sel => sig(0), src0 => o3, src1=> o11, z => a3); 
  nnt4 : mux_n generic map (512) port map (sel => sig(0), src0 => o4, src1=> o12, z => a4); 
  nnt5 : mux_n generic map (512) port map (sel => sig(0), src0 => o5, src1=> o13, z => b1); 
  nnt6 : mux_n generic map (512) port map (sel => sig(0), src0 => o6, src1=> o14, z => b2); 
  nnt7 : mux_n generic map (512) port map (sel => sig(0), src0 => o7, src1=> o15, z => b3); 
  nnt8 : mux_n generic map (512) port map (sel => sig(0), src0 => o8, src1=> o16, z => b4); 
  
  lt1 : mux_n generic map (512) port map (sel => sig(1), src0 => a1, src1=> b1, z => res1); 
  lt2 : mux_n generic map (512) port map (sel => sig(1), src0 => a2, src1=> b2, z => res2); 
  lt3 : mux_n generic map (512) port map (sel => sig(1), src0 => a3, src1=> b3, z => res3); 
  lt4 : mux_n generic map (512) port map (sel => sig(1), src0 => a4, src1=> b4, z => res4); 
    
  mt1 : mux_n generic map (512) port map (sel => sig(2), src0 => res1, src1=> res2, z => nt1); 
  mt2 : mux_n generic map (512) port map (sel => sig(2), src0 => res3, src1=> res4, z => nt2);
  
  ut : mux_n generic map (512) port map (sel => sig(3), src0 => nt1, src1=> nt2, z => z);  
    
end architecture structural;

