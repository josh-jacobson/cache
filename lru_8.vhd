library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity lru_8 is
	port (
		used        :	in std_logic; --reporting a usage?
		clk         : in std_logic;
		slot_used :	in std_logic_vector(2 downto 0); -- number from 0 to 7, to say which of the 8 way assoc pages was used
		slot_list    :	in std_logic_vector(23 downto 0); -- default list input
		lru_slot :	out std_logic_vector(2 downto 0) -- number from 0 to 7, to say which of the 8 way assoc pages is lru
	);
end lru_8;

architecture structural of lru_8 is
	component comparator_3 is
		port (
			x :		in std_logic_vector(2 downto 0);
			y :	in  std_logic_vector(2 downto 0);
			z  :		out std_logic
		);
	end component comparator_3;
		component a24bitreg is
  port (
    q       : out  std_logic_vector(23 downto 0);
    d       : in  std_logic_vector(23 downto 0);
    arst    : in  std_logic;
    aload   : in  std_logic;
    adata   : in  std_logic_vector(23 downto 0);
    enable  : in  std_logic;
    clk     : in  std_logic
  );
end component a24bitreg;
	--8 3 bit values from 23 to 0
	signal slotlist0 : std_logic_vector (23 downto 0);
	signal final_list : std_logic_vector (23 downto 0);
	signal cmpchecks : std_logic_vector (7 downto 0);
	signal shiftflags : std_logic_vector (7 downto 0);
	subtype slotnums is std_logic_vector(2 downto 0);
	type chosenval_array is array (1 to 8) of slotnums;
	signal chosenvals : chosenval_array;
	signal oredvals : chosenval_array;
   begin
	reg0_map : a24bitreg port map
        		(q => slotlist0, d => "000001010011100101110111", arst=> '1', clk => clk,aload=>'1', adata => "000001010011100101110111", enable => '0');
	cmpchecks_gen: 
	for I in 0 to 7 generate
		cmpchecksI_map : comparator_3
		port map(x => slotlist0(2+(3*I) downto 3*I), y => slot_used, z=> cmpchecks(I));
	end generate cmpchecks_gen;
	
	muxI_map : mux_n generic map (n=>3) port map
		(sel => cmpchecks(0), src0 => "000", src1=>slotlist0(2 downto 0), z=>chosenvals(1));
	oredvals_map : or_gate_n generic map (n=>3) port map
		(x=>chosenvals(1),y=>"000",z=>oredvals(1));
	pick_val: 
		for I in 1 to 7 generate
			muxI_map : mux_n generic map (n=>3) port map
			(sel => cmpchecks(I), src0 => "000", src1=>slotlist0(2+(3*I) downto 3*I), z=>chosenvals(I+1));
			oredvals_map : or_gate_n generic map (n=>3) port map
			(x=>chosenvals(I+1),y=>oredvals(I),z=>oredvals(I+1));	
	end generate pick_val;
	shiftJ_map : or_gate port map
		(x =>cmpchecks(7),y=>'1', z => shiftflags(6));
	muxJ_map : mux_n generic map (n=>3) port map
		(sel => shiftflags(6), src0 => slotlist0(23 downto 21), src1=>slotlist0(20 downto 18), z=>final_list(23 downto 21));
	shift_val: 
		for J in 0 to 5 generate
			shiftJ_map : or_gate port map
			(x =>cmpchecks(6-J),y=> cmpchecks(7-J), z => shiftflags(5-J));
			muxJ_map : mux_n generic map (n=>3) port map
			(sel => shiftflags(5-J), src0 => slotlist0(2+(3*(6-J)) downto 3*(6-J)), src1=>slotlist0(2+(3*(5-J)) downto 3*(5-J)), z=>final_list(2+(3*(6-J)) downto 3*(6-J)));
	end generate shift_val;
	final_list(2 downto 0) <= oredvals(8);
	--put final list back into reg, output lru
	lru_slot<= final_list(23 downto 21);

end structural;