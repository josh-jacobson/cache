library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity or_4 is
  port (
    x   : in  std_logic_vector(3 downto 0);
    z   : out std_logic
  );
end or_4;

architecture structural of or_8 is
signal xmid2 : std_logic_vector (2 downto 0);
begin
xop2 : or_gate_n generic map (n=>2) port map (x=>x(3 downto 2), y=>x(1 downto 0), z=>xmid2);
xop3 : or_gate port map (x=>xmid2(0), y=>xmid2(1), z=>z);
end structural;