library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity l1cache64line is
  port (
	qin       : out  std_logic_vector(511 downto 0);
	din       : in  std_logic_vector(31 downto 0);
	tag     : in  std_logic_vector(31 downto 10);
	index	: in std_logic_vector(9 downto 6);
	offset  : in std_logic_vector(5 downto 2);
	we		: in  std_logic;
	hit		: out std_logic;
	re		: in  std_logic 
  );
end l1cache64line;

architecture structural of l1cache64line is

component a16input_mux_padded is
  port (
	d		 : in  std_logic_vector(31 downto 0);
	xin		 : in  std_logic_vector(511 downto 0);
    sig      : in  std_logic_vector(3 downto 0);
    z        : out std_logic_vector(511 downto 0)
  );
end component a16input_mux_padded;

component or_23 is
  port (
    x   : in  std_logic_vector(22 downto 0);
    z   : out std_logic
  );
end component or_23;

signal q	: std_logic_vector (511 downto 0);
signal tag_map_out : std_logic_vector (23 downto 0);
signal parsed_q : std_logic_vector (511 downto 0);
signal valid_bit : std_logic;
signal dirty_bit : std_logic;
signal hit_out	: std_logic_vector (22 downto 0);
signal full_tag : std_logic_vector (23 downto 0);
signal valid_tag : std_logic_vector (22 downto 0);
begin
	full_tag <= tag&dirty_bit&valid_bit;
	valid_tag <= tag&'0';
	data_processor : a16input_mux_padded port map (din, q, offset, parsed_q); -- encodes a 32-bit value given to a 256-bit signal ready to bed to the line_map
	csram_tag_map : csram generic map (4, 24) port map ('1',re,we,index,full_tag,tag_map_out); -- tag line - stores the tag, dirty bit, and valid bit
	csram_line_map : csram generic map (4, 256) port map ('1',re,we,index,parsed_q,q); -- data line
    valid_check_map : or_gate_n generic map (23) port map (tag_map_out(23 downto 1), valid_tag, hit_out);
	valid_bit_set	: or_23 port map (hit_out,hit);
	qin <= parsed_q;
end architecture structural;
