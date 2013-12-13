library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity l1cache is
  port (
    q       : out  std_logic_vector(31 downto 0);
    d       : in  std_logic_vector(31 downto 0); -- for store instructions
    addr	: in  std_logic_vector(31 downto 0); -- last two are byte offset, next 4 offset, next 4 are index
	hit		: out std_logic;  -- 1 if hit
	miss	: out std_logic;  -- 1 if miss
	write	: in std_logic
  );
end l1cache;

architecture structural of l1cache is

	component l1cache64line is
	  port (
		q       : out  std_logic_vector(255 downto 0);
		d       : in  std_logic_vector(31 downto 0);
		tag     : in  std_logic_vector(26 downto 0);
		index	: in std_logic_vector(8 downto 6);
		offset  : in std_logic_vector(5 downto 2);
		we		: in  std_logic;
		re		: in  std_logic -- d is ignored if re is enabled
	  );
	end component l1cache64line;

	signal we_vec : std_logic_vector(15 downto 0);
	signal d		: std_logic_vector(31 downto 0);
	signal cache_out : std_logic_vector(255 downto 0);
	begin

	  line_gen: 
	   for I in 0 to 15 generate
		  line_map : l1cache64line port map
			(cache_out, d, addr(31 downto 10), addr(9 downto 6), addr(5 downto 2), write, hit, re);
	   end generate line_gen;
	   
	   miss_map : not port map (hit, miss);
	  
	end architecture structural;
