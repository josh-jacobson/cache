library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity l1cache64line is
  port (
	q       : out  std_logic_vector(255 downto 0);
	d       : in  std_logic_vector(31 downto 0);
	tag     : in  std_logic_vector(26 downto 0);
	index	: in std_logic_vector(9 downto 6);
	offset  : in std_logic_vector(5 downto 2);
	we		: in  std_logic;
	re		: in  std_logic 
  );
end l1cache64line;

architecture structural of l1cache64line is

signal index_offset : std_logic_vector (9 downto 2);

begin
	-- TODO signal splicing
	-- signals have to be spliced, can't do multiple accesses
	
	-- manually wrote out words mapped to each
	csram_line_map : csram generic map (4, 256) port map ('1','1',enable,index,d,q);
  
end architecture structural;
