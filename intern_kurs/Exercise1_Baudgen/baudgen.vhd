-- Logic libraries
library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Definerer interface til modulen kallet "baudgen"
entity baudgen is

-- Generics definerer parameterene
    generic(
        g_clockspeed : integer := 50e6
    );

-- Deklarere inputer og outputtene til designet/blokken, som sett i figuren
    port (

        -- std_logic er en type
        CLK : in std_logic;
        RST : in std_logic;
        ENABLE : in std_logic;
        -- vector 00 eller 01 eller 11, telle til 3 :) velge 4
        BAUDSELECT : in std_logic_vector(1 downto 0);
        -- default value, starter fra '0' og ikke udef.
        BAUD_OUT : out std_logic := '0'
    );
end baudgen;

-- Logikken inne i blokken altså innmaten
architecture rtl of baudgen is
-- Signals
-- 
type ROM is array (0 to 3) of integer range 0 to g_clockspeed;
    constant baudPeriod : ROM := (g_clockspeed/4800, g_clockspeed/9600,
    g_clockspeed/115_200, g_clockspeed/(g_clockspeed/2));

    -- funny måte å definere variabler
    signal s_counter            : integer range 0 to g_clockspeed/2;
    signal s_baudrate           : integer range 0 to g_clockspeed/2;
    signal s_output             : std_logic := '0';
    signal s_last_baudrate      : integer range 0 to g_clockspeed;
begin
-- Her skjer prosessene parallellt
    process(CLK)
        begin
            if rising_edge(CLK) then
                if RST = '0' then
                    s_counter <= 0;
                    s_last_baudrate <= 0;
                    s_output <= '0';
                else
                    if ENABLE = '1' then
                        case BAUDSELECT is
                            when "00" =>
                                s_baudrate <= baudPeriod(0);
                            when "01" =>
                                s_baudrate <= baudPeriod(1);
                            when "10" =>
                                s_baudrate <= baudPeriod(2);
                            when "11" =>
                                s_baudrate <= baudPeriod(3);
                        end case;
                    end if;

                    if s_counter = s_baudrate - 1 then
                         s_output <= '1';
                    end if;
                end if;
            end if;
        end process;
end architecture;
