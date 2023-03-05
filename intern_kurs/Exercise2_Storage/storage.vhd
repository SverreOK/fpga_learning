library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity storage is
    port (
        SYSCLK      : in std_logic;
        RST         : in std_logic;
        CLK         : in std_logic;
        ADR         : in std_logic_vector(2 downto 0);
        WRITEDATA   : in std_logic_vector(7 downto 0);
        READDATA    : out std_logic_vector(7 downto 0)
    );
end storage;

-- RTL meaning register-transfer level
architecture rtl of storage is
    -- Storage is an 4x8 array --> stores 4 bytes
    type t_STORAGE is array (0 to 3) of std_logic_vector(7 downto 0);
    --  Declare a signal of type t_STORAGE and initialize it to all zeros.
    signal STORAGE : t_STORAGE := (others => (others => '0'));
    signal prev_CLK : std_logic := '0';

    begin
        -- Sensitive to CLK and RST input
        p_READ_nWRITE : process(SYSCLK, RST) 
        begin 
            if RST = '0' then
                STORAGE <= (others => (others => '0'));
            end if;
            if rising_edge(SYSCLK) then
                prev_CLK <= CLK;
                if CLK = '1' and prev_CLK = '0' then
                if ADR(2) = '1' then
                    case ADR(1 downto 0) is
                        when "00" =>
                            READDATA <= STORAGE(0);
                        when "01" =>
                            READDATA <= STORAGE(1);
                        when "10" =>
                            READDATA <= STORAGE(2);
                        when "11" =>
                            READDATA <= STORAGE(3);
                        when others =>
                            null;
                    end case;
                end if;
                if ADR(2) = '0' then
                    case ADR(1 downto 0) is
                        when "00" =>
                            STORAGE(0) <= WRITEDATA;
                        when "01" =>
                            STORAGE(1) <= WRITEDATA;
                        when "10" =>
                            STORAGE(2) <= WRITEDATA;
                        when "11" =>
                            STORAGE(3) <= WRITEDATA;
                        when others =>
                            null;
                    end case;
                end if;
                end if;
            end if;
        end process p_READ_nWRITE;
    end architecture;