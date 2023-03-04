library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity baudgen_tb is

end baudgen_tb;

-------------------------------------------------------------------------------

architecture sim of baudgen_tb is

    -- Component ports
    signal clk : std_logic := '1';
    signal rst : std_logic := '1';
    signal enable     : std_logic := '0';
    signal baudselect : std_logic_vector(1 downto 0) := "00";
    signal baud_out   : std_logic := '0';

    -- Constants and signals
    constant clk_hz : integer := 12e6;
    constant clk_period : time := 1 sec / clk_hz;

    signal clkcount : integer range 0 to clk_hz/2 -1 := 0;
    signal reset_clkcount : std_logic := '1';

    type ROM is array (0 to 3) of integer range 0 to clk_hz;
    constant baudPeriod : ROM := (clk_hz/4800, clk_hz/9600, clk_hz/115_200, clk_hz/(clk_hz/2));
    --                                              4800, 9600, 115200, and half of system clock

begin

    -- Clock generation
    clk <= not clk after clk_period / 2;

    -- Map component
    DUT : entity work.baudgen
    generic map(
        g_clockspeed => clk_hz
    )
    port map (
        CLK         => clk,
        RST         => rst,
        ENABLE      => enable,
        BAUDSELECT  => baudselect,
        BAUD_OUT    => baud_out
    );

    -- Clock counter
    ClockCounter : process(clk)
    begin
        if rising_edge(clk) then
            if reset_clkcount = '1' then
                clkcount <= 0;
            else
                clkcount <= clkcount + 1;
            end if;
        end if;
    end process ClockCounter;

    -- Testbench
    MAIN : process
    ---------------------------- Procedure for testing baudrates -----------------------------------
    procedure p_test_baudrate is
    begin
        wait until rising_edge(baud_out);
        reset_clkcount <= '0';
        wait until rising_edge(baud_out);
        reset_clkcount <= '1';

        if clkcount = baudPeriod(to_integer(unsigned(baudselect))) then
            report "####       Baudrate test passed!     ####" severity note;
        else
            report "####       Baudrate test failed!     ####" severity error;
        end if;
    end procedure p_test_baudrate;

    begin
    --------------------------------------------START SIMULATION-------------------------------------------
    -- Sequential code

        wait for clk_period * 2;

        rst <= '0';
        wait for clk_period * 2;
        rst <= '1';

        enable      <= '1';

        for i in 0 to 3 loop
            baudselect <= std_logic_vector(to_unsigned(i, 2));
            p_test_baudrate;
        end loop;
        

        wait for clk_period * 2;
        std.env.stop(0);

    end process MAIN;
end architecture;