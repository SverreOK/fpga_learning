library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity baudgen is
    generic(
        g_clockspeed : integer := 50e6
    );
    port (
        CLK : in std_logic;
        RST : in std_logic;
        ENABLE : in std_logic;
        BAUDSELECT : in std_logic_vector(1 downto 0);
        BAUD_OUT : out std_logic := '0'
    );
end baudgen;

architecture rtl of baudgen is
-- Signals
type ROM is array (0 to 3) of integer range 0 to g_clockspeed;
    constant baudPeriod : ROM := (g_clockspeed/4800, g_clockspeed/9600,
    g_clockspeed/115_200, g_clockspeed/(g_clockspeed/2));

    signal s_counter            : integer range 0 to g_clockspeed/2;
    signal s_baudrate           : integer range 0 to g_clockspeed/2;
    signal s_output             : std_logic := '0';
    signal s_last_baudrate      : integer range 0 to g_clockspeed;
begin
-- Process
    process(CLK)
        begin
            if rising_edge(CLK) then
                    if RST = '0' then
                    -- test
                    else
                    -- put code
                    end if;
                end if;
        end process;
end architecture;
