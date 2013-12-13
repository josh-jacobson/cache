library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity a16input_mux_padded is
  port (
	d		 : in  std_logic_vector(31 downto 0);
	xin		 : in  std_logic_vector(511 downto 0);
    sig      : in  std_logic_vector(3 downto 0);
    z        : out std_logic_vector(511 downto 0)
  );
end a16input_mux_padded;

architecture structural of a16input_mux_padded is

   signal lo1       :   std_logic_vector(511 downto 0);
   signal lo2       :   std_logic_vector(511 downto 0);
   signal lo3       :   std_logic_vector(511 downto 0);
   signal lo4       :   std_logic_vector(511 downto 0);
   signal lo5       :   std_logic_vector(511 downto 0);
   signal lo6       :   std_logic_vector(511 downto 0);
   signal lo7       :   std_logic_vector(511 downto 0);
   signal lo8       :   std_logic_vector(511 downto 0);
   signal lo9       :   std_logic_vector(511 downto 0);
   signal lo10       :   std_logic_vector(511 downto 0);
   signal lo11       :   std_logic_vector(511 downto 0);
   signal lo12       :   std_logic_vector(511 downto 0);
   signal lo13       :   std_logic_vector(511 downto 0);
   signal lo14       :   std_logic_vector(511 downto 0);
   signal lo15       :   std_logic_vector(511 downto 0);
   signal lo16       :   std_logic_vector(511 downto 0);

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
  
    lo2(511 downto 480) <= xin(511 downto 480); --reverse these, should be set to xin
	lo3(511 downto 448) <= xin(511 downto 448);
	lo4(511 downto 416) <= xin(511 downto 416);
	lo5(511 downto 384) <= xin(511 downto 384);
	lo6(511 downto 352) <= xin(511 downto 352);
	lo7(511 downto 320) <= xin(511 downto 320);
	lo8(511 downto 288) <= xin(511 downto 288);
	lo9(511 downto 256) <= xin(511 downto 256);
	lo10(511 downto 224) <= xin(511 downto 224);
	lo11(511 downto 192) <= xin(511 downto 192);
	lo12(511 downto 160) <= xin(511 downto 160);
	lo13(511 downto 128) <= xin(511 downto 128);
	lo14(511 downto 96) <= xin(511 downto 96);
	lo15(511 downto 64) <= xin(511 downto 64);
	lo16(511 downto 32) <= xin(511 downto 32);
	lo1(511 downto 480) <= d;
	lo2(479 downto 448) <= d; 
	lo3(447 downto 416) <= d; 
	lo4(415 downto 384) <= d; 
	lo5(383 downto 352) <= d; 
	lo6(351 downto 320) <= d; 
	lo7(319 downto 288) <= d; 
	lo8(287 downto 256) <= d; 
	lo9(255 downto 224) <= d; 
	lo10(223 downto 192) <= d; 
	lo11(191 downto 160) <= d; 
	lo12(159 downto 128) <= d; 
	lo13(127 downto 96) <= d; 
	lo14(95 downto 64) <= d;
	lo15(63 downto 32) <= d;
	lo16(31 downto 0) <= d;	
	lo1(479 downto 0) <= xin(479 downto 0);
	lo2(447 downto 0) <= xin(447 downto 0);
	lo3(415 downto 0) <= xin(415 downto 0);
	lo4(383 downto 0) <= xin(383 downto 0);
	lo5(351 downto 0) <= xin(351 downto 0);
	lo6(319 downto 0) <= xin(319 downto 0);
	lo7(287 downto 0) <= xin(287 downto 0);
	lo8(255 downto 0) <= xin(255 downto 0);
	lo9(223 downto 0) <= xin(223 downto 0);
	lo10(191 downto 0) <= xin(191 downto 0);
	lo11(159 downto 0) <= xin(159 downto 0);
	lo12(127 downto 0) <= xin(127 downto 0);
	lo13(95 downto 0) <= xin(95 downto 0);
	lo14(63 downto 0) <= xin(63 downto 0);
	lo15(31 downto 0) <= xin(31 downto 0);

  nnt1 : mux_n generic map (512) port map (sel => sig(0), src0 => lo1, src1=> lo9, z => a1); 
  nnt2 : mux_n generic map (512) port map (sel => sig(0), src0 => lo2, src1=> lo10, z => a2); 
  nnt3 : mux_n generic map (512) port map (sel => sig(0), src0 => lo3, src1=> lo11, z => a3); 
  nnt4 : mux_n generic map (512) port map (sel => sig(0), src0 => lo4, src1=> lo12, z => a4); 
  nnt5 : mux_n generic map (512) port map (sel => sig(0), src0 => lo5, src1=> lo13, z => b1); 
  nnt6 : mux_n generic map (512) port map (sel => sig(0), src0 => lo6, src1=> lo14, z => b2); 
  nnt7 : mux_n generic map (512) port map (sel => sig(0), src0 => lo7, src1=> lo15, z => b3); 
  nnt8 : mux_n generic map (512) port map (sel => sig(0), src0 => lo8, src1=> lo16, z => b4); 
  
  lt1 : mux_n generic map (512) port map (sel => sig(1), src0 => a1, src1=> b1, z => res1); 
  lt2 : mux_n generic map (512) port map (sel => sig(1), src0 => a2, src1=> b2, z => res2); 
  lt3 : mux_n generic map (512) port map (sel => sig(1), src0 => a3, src1=> b3, z => res3); 
  lt4 : mux_n generic map (512) port map (sel => sig(1), src0 => a4, src1=> b4, z => res4); 
    
  mt1 : mux_n generic map (512) port map (sel => sig(2), src0 => res1, src1=> res2, z => nt1); 
  mt2 : mux_n generic map (512) port map (sel => sig(2), src0 => res3, src1=> res4, z => nt2);
  
  ut : mux_n generic map (512) port map (sel => sig(3), src0 => nt1, src1=> nt2, z => z);  
    
end architecture structural;

