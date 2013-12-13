library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.eecs361_gates.all;
use work.eecs361.all;
entity l2 is
	port (
		we        :	in std_logic_vector(7 downto 0);
		valid     : in std_logic;
		address :	in std_logic_vector(31 downto 0);
		offset : 		in std_logic_vector(1 downto 0);
		din	:	in std_logic_vector(2047 downto 0);
		dout  :		out std_logic_vector(511 downto 0)
	);
end l2;

architecture structural of l2 is
begin
end structural;
