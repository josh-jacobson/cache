library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity rippleadder32 is
  port (
    x       : in  std_logic_vector(31 downto 0);
    y       : in  std_logic_vector(31 downto 0);
    c       : in  std_logic;
    z       : out std_logic_vector(31 downto 0);
    cout    : out std_logic
  );
end rippleadder32;

architecture structural of rippleadder32 is
  	component fulladder is
	  port (
		x       : in  std_logic;
		y       : in  std_logic;
		c       : in  std_logic;
		z       : out std_logic;
		cout    : out std_logic
	  );
	end component fulladder;

signal cinter : std_logic_vector(31 downto 0);

begin

  adder0_map : fulladder port map (x => x(0), y => y(0), c=> c, z => z(0), cout => cinter(0));
  ADD_GEN: 
   for I in 1 to 30 generate
      adderint_map : fulladder port map
        (x => x(I), y => y(I), c=> cinter(I-1), z => z(I), cout => cinter(I));
   end generate ADD_GEN;
  adder3_map : fulladder port map (x => x(31), y => y(31), c=> cinter(30), z => z(31), cout => cout);  
  
end architecture structural;
