library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity l1cache is
  port (
    q       : out  std_logic_vector(31 downto 0);
    d       : in  std_logic_vector(31 downto 0); -- for store instructions
    addr	: in  std_logic_vector(31 downto 0); -- last two are byte offset, next 3 are index
	hit		: out std_logic -- 1 if hit
  );
end l1cache;

architecture structural of l1cache is

	component l1cache64line is
	  port (
		q       : out  std_logic_vector(63 downto 0);
		d       : in  std_logic_vector(31 downto 0);
		tag     : in  std_logic_vector(22 downto 0);
		index	: in std_logic_vector(6 downto 0);
		we		: in  std_logic;
		re		: in  std_logic -- d is ignored if are is enabled
	  );
	end component l1cache64line;

	signal we_vec : std_logic_vector(15 downto 0);
	signal d		: std_logic_vector(31 downto 0);
	signal cache_out : std_logic_vector(63 downto 0);
	begin

	 -- TODO:
	 -- 16 entry mux for write enable
	 
	  line_gen: 
	   for I in 0 to 15 generate
		  line_map : l1cache64line port map
			(cache_out, d, addr(31 downto 10), addr(9 downto 3), we_vec(I), re);
	   end generate line_gen;
	   
	   -- hit/miss logic
	   -- valid checking
	   -- write buffer for overwritten data
	  
	end architecture structural;
