library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator_3 is
	port (
		x :		in std_logic_vector(2 downto 0);
		y :	in std_logic_vector(2 downto 0);
		z  :		out std_logic
	);
end comparator_3;

architecture structural of comparator is
	component or_gate is
		port (
			x :		in std_logic;
			y :		in std_logic;
			z  :		out std_logic
		);
	end component or_gate;
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
	signal xorout : std_logic_vector(2 downto 0);
	signal ormid: std_logic;
	signal orout: std_logic;
	
	xorop : xor_gate_n generic map (n=>3) port map (x=>x, y=>y, z=>xorout);
	ormid : or_gate port map(x=>xorout(2), y=>xorout(1), z=>ormid);
	orout : or_gate port map(x=>xorout(0), y=>ormid, z=>orout);
	flipit : not_gate port map(x=>orout, z=>z);



end structural