library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity or_24 is
  port (
    x   : in  std_logic_vector(23 downto 0);
    z   : out std_logic
  );
end or_24;

architecture structural of or_24 is
signal xmid12 : std_logic_vector (11 downto 0);
signal xmid6 : std_logic_vector (5 downto 0);
signal xmid3 : std_logic_vector (2 downto 0);
signal xlast : std_logic;
begin
xop1 : or_gate_n generic map (n=>12) port map (x=>x(23 downto 12), y=>x(11) downto 0), z=>xmid12);
xop1 : or_gate_n generic map (n=>6) port map (x=>xmid12(11 downto 6), y=>x(5 downto 0), z=>xmid6);
xop1 : or_gate_n generic map (n=>3) port map (x=>xmid6(5 downto 3), y=>xmid6(2 downto 0), z=>xmid3);
xop2 : or_gate port map (x=>xmid3(2), y=>xmid3(1), z=>xlast);
xop3 : or_gate port map (x=>xmid3(0), y=>xlast, z=>z);
end structural;