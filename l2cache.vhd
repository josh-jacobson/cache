library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity l2cache is
	port (
		we        :	in std_logic;
		pc	:	in std_logic_vector(31 downto 0);
		address :	in std_logic_vector(31 downto 0);
		offset : 		in std_logic_vector(1 downto 0);
		din	:	in std_logic_vector(511 downto 0);
		dout  :		out std_logic_vector(511 downto 0)
	);
end l2cache;

architecture structural of l2cache is
	component csram is
		generic (
			INDEX_WIDTH : integer;
			BIT_WIDTH : integer
		);
		port (
			cs          :	in        std_logic;
			oe          :	in        std_logic;
			we          :	in        std_logic;
			index :		in std_logic_vector(INDEX_WIDTH-1 downto 0);
			din	:	in        std_logic_vector(BIT_WIDTH-1 downto 0);
			dout  :		out std_logic_vector(BIT_WIDTH-1 downto 0) 
		);
	end component csram;
	component comparator is
		port (
			x :		in std_logic_vector(22 downto 0);
			y	:	in  std_logic_vector(22 downto 0);
			z  :		out std_logic
		);
	end component comparator;
	component or_8 is
		port (
			x :		in std_logic_vector(7 downto 0);
			y :	in  std_logic_vector(7 downto 0);
			z  :		out std_logic
		);
	end component or_8;
	component or_4 is
		port (
			x :		in std_logic_vector(7 downto 0);
			y :	in  std_logic_vector(7 downto 0);
			z  :		out std_logic
		);
	end component or_4;
	component and_gate is
		port (
			x :		in std_logic;
			y :		in  std_logic;
			z :		out std_logic
		);
	end component and_gate;
	--line size of 2073 (2048 data for 256 bytes and 23 bit tag, 1 bit index, and 1 valid bit)
	signal tagin : std_logic_vector(23 downto 0);
	signal tag_checks : std_logic_vector(7 downto 0);
	signal hit_checks : std_logic_vector(7 downto 0);
	signal hit_flag : std_logic;
	signal data_mux_sel : std_logic_vector(2 downto 0);
	signal mux_sel1_checks : std_logic_vector(3 downto 0);
	signal mux_sel2_checks : std_logic_vector(3 downto 0);
	signal mux_sel3_checks : std_logic_vector(3 downto 0);
	signal tagin : std_logic_vector(23 downto 0);
	subtype cacheline is std_logic_vector(2072 downto 0);
	type line_array is array (1 to 8) of cacheline;
	signal cachelines : line_array;
	subtype linetag is std_logic_vector(22 downto 0);
	type tag_array is array (1 to 8) of linetag;
	signal tags : tag_array;
	subtype linedata is std_logic_vector(511 downto 0);
	type data_array is array (1 to 8) of linedata;
	signal datas : data_array;

	--9th bit is index? 2 bits for byte, then 6 bits for offset
	csram_gets: 
		for I in 1 to 8 generate
			csramI_get : csram 
			generic map (INDEX_WIDTH=>1, BIT_WIDTH=>2073)
			port map (cs => '1', oe=>'1', we=>we_input, index=>address(8), din => din, dout => cachelines(I));
	end generate csram_gets;

	--offset is 6 bits because 256 bytes needs 6 bits to offset by word. only top 2 of these needed 
	--since we are returning 64 byte subblocks
	data_gets: 
		for I in 1 to 8 generate
			data_offset_map1 : a4input512_mux
			portmap(a1=>cachelines(I)(511 downto 0), b1=>cachelines(I)(1023 downto 512), 
			a2=>cachelines(I)(1535 downto 1024), b2=>cachelines(I)(2047 downto 1536), sig=>address(7 downto 6), z=>datas(I));
	end generate data_gets;


	tag_checks_gen: 
		for I in 1 to 8 generate
			comparator_set1 : comparator
			port map(x => cachelines(I)(2071 downto 2049), y => tagin, z=> tag_checks(I-1));
	end generate tag_checks_gen;

	--valid bit set, and tag matched means hit!
	hit_checks_gen: 
		for I in 1 to 8 generate
			hit_set1 : and_gate
			port map(x => cachelines(I)(2072), y => tag_checks(I-1), z=>hit_checks(I-1));
	end generate hit_checks_gen;

	hit_flag_map : or_8
	port map(x=>hit_checks, z=>hit_flag);
	mux_sel1_checks <= hit_checks(1) & hit_checks(3) & hit_checks(5) & hit_checks(7);
	mux_sel2_checks <= hit_checks(2) & hit_checks(3) & hit_checks(6) & hit_checks(7);
	mux_sel3_checks <= hit_checks(4) & hit_checks(5) & hit_checks(6) & hit_checks(7);
	mux_sel_map1 : or_4
	port map(x=>mux_sel1_checks, z=>data_mux_sel(0));
	mux_sel_map2 : or_4
	port map(x=>mux_sel2_checks, z=>data_mux_sel(1));
	mux_sel_map3 : or_4
	port map(x=>mux_sel3_checks, z=>data_mux_sel(2));

	data_mux_map : a8input_mux
	port map(a1=>data1,  a2=>data2, a3=>data3, a4=>data4, b1=>data5, b2=>data6, b3=>data7, b4=>data8, 
		sig=>data_mux_sel,z=>dout);



end structural