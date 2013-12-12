library ieee;
use ieee.std_logic_1164.all;

entity mux16 is
  port (
    z       : out std_logic_vector(511 downto 0)
  );
end mux16;

architecture structural of mux16 is
component a16input_mux is
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
  end component a16input_mux;
signal xin : std_logic_vector(511 downto 0);
signal zero : std_logic_vector(31 downto 0);
signal cin : std_logic_vector(3 downto 0);
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
begin
  mux_map : a16input_mux port map (lo1,lo2,lo3,lo4,lo5,lo6,lo7,lo8,lo9,lo10,lo11,lo12,lo13,lo14,lo15,lo16,cin,z);
  xin <= x"12345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678";

  test_proc : process
  
  begin
    zero <= xin(511 downto 480); 
	lo2(479 downto 448) <= xin(479 downto 448); 
	lo3(447 downto 416) <= xin(447 downto 416); 
	lo4(415 downto 384) <= xin(415 downto 384); 
	lo5(383 downto 352) <= xin(383 downto 352); 
	lo6(351 downto 320) <= xin(351 downto 320); 
	lo7(319 downto 288) <= xin(319 downto 288); 
	lo8(287 downto 256) <= xin(287 downto 256); 
	lo9(255 downto 224) <= xin(255 downto 224); 
	lo10(223 downto 192) <= xin(223 downto 192); 
	lo11(191 downto 160) <= xin(191 downto 160); 
	lo12(159 downto 128) <= xin(159 downto 128); 
	lo13(127 downto 96) <= xin(127 downto 96); 
	lo14(95 downto 64) <= xin(95 downto 64); 
	lo15(63 downto 32) <= xin(63 downto 32); 
	lo16(31 downto 0) <= xin(31 downto 0);

	cin <= "0000";
    wait for 5 ns;
    cin <= "0010";
    wait for 5 ns;
    cin <= "0100";
    wait for 5 ns;
    cin <= "0011";
    wait for 5 ns;
    cin <= "1000";
    wait for 5 ns;
    cin <= "1010";
    wait for 5 ns;
    cin <= "1100";
    wait for 5 ns;
    cin <= "1110";
    wait for 5 ns;
    wait;
  end process;
end architecture structural;


