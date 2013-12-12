library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

-- This entity serves as a FSM lookup table, and can be readily used in control units for all levels of the memory heirarchy given different initializations.

entity fsm is
    generic (
        fsm_init : string -- File used to initialize the FSM lookup table in SRAM
    );
    port (
        current_state : in std_logic_vector(2 downto 0);
        wr : in std_logic;
        next_state : out std_logic_vector(2 downto 0)
    );
end fsm;


architecture structural of fsm is
    signal next_state_32 : std_logic_vector(31 downto 0);
    signal address : std_logic_vector (31 downto 0);
    
begin
    address <= "00000000000000000000000000000000";
    address(0) <= current_state(0);
    address(1) <= current_state(1);
    address(2) <= current_state(2);
    
    -- Assign control signals to additional address bits here
    
    sram_map: sram generic map (mem_file => fsm_init) port map (cs => '1', oe => '1', we => '1', addr => address, din => "00000000000000000000000000000000", dout => next_state_32); 
    
    next_state <= next_state_32(2 downto 0);

end structural;    
