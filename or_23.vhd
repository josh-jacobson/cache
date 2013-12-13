library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity or_23 is
  port (
    x   : in  std_logic_vector(22 downto 0);
    z   : out std_logic
  );
end or_23;

architecture structural of or_23 is
signal xmid11 : std_logic_vector (10 downto 0);
signal xmid5 : std_logic_vector (5 downto 0);
signal xmid2 : std_logic_vector (2 downto 0);
signal x1123 : std_logic;
signal xmid1 : std_logic;
signal xlast : std_logic;
begin
xop1 : or_gate_n generic map (n=>11) port map (x=>x(21 downto 11), y=>x(10 downto 0), z=>xmid11);
xop12 : or_gate port map (x=>xmid11(10), y=>x(22), z=>x1123);
xop3 : or_gate_n generic map (n=>5) port map (x=>xmid11(9 downto 5), y=>x(4 downto 0), z=>xmid5);
xop2 : or_gate port map (x=>xmid5(4), y=>x1123, z=>xlast);
xop4 : or_gate_n generic map (n=>2) port map (x=>xmid5(3 downto 2), y=>xmid5(1 downto 0), z=>xmid2);
xop5 : or_gate port map (x=>xmid2(1), y=>xmid2(0), z=>xmid1);
xop6 : or_gate port map (x=>xmid1, y=>xlast, z=>z);
end structural;