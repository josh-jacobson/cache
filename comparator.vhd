library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
	port (
		x :		in std_logic_vector(22 downto 0);
		y :	in std_logic_vector(22 downto 0);
		z  :		out std_logic
	);
end comparator;

architecture structural of comparator is
--xor two vectors, if everything 0, then true
	component or_23 is
		port (
			x :		in std_logic_vector(22 downto 0);
			z  :		out std_logic
		);
	end component or_23;
	component xor_gate_n is
		generic (
			n   : integer
		);
		port (
			x   : in  std_logic_vector(n-1 downto 0);
			y   : in  std_logic_vector(n-1 downto 0);
			z   : out std_logic_vector(n-1 downto 0)
		);
	end component xor_gate_n;
	signal xorout : std_logic_vector(22 downto 0);
	signal orout : std_logic;
	xorop : xor_gate_n generic map (n=>23) port map (x=>x, y=>y, z=>xorout);
	--output 0 if all bits of xorout are 0
	orflags : or_23 port map(x=>xorout, z=>orout);
	flipit : not_gate port map(x=>orout, z=>z);



end structural