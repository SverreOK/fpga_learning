library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity storage_tb is

end storage_tb;

-------------------------------------------------------------------------------

architecture sim of storage_tb is

  -- Component ports
  signal clk          : std_logic := '1';
  signal rst          : std_logic := '1';
  signal storage_clk  : std_logic := '0';
  signal address      : std_logic_vector(2 downto 0) := (others => '0');
  signal writedata    : std_logic_vector(7 downto 0) := (others => '0');
  signal readdata     : std_logic_vector(7 downto 0) := (others => '0');

  -- Constants and signals
  constant clk_hz : integer := 12e6;
  constant clk_period : time := 1 sec / clk_hz;


begin

  -- Clock generation
  clk <= not clk after clk_period / 2;

  -- Map component
  DUT : entity work.storage
  port map (
    SYSCLK      => clk,
    RST         => rst,
    clk         => storage_clk,
    ADR         => address,
    WRITEDATA   => writedata,
    READDATA    => readdata
  );

  -- Testbench
  MAIN : process
  ---------------------------- Procedure for testing DUT -----------------------------------
  procedure p_write(
    constant addr : in std_logic_vector(1 downto 0);
    constant data : in std_logic_vector(7 downto 0)) is
  begin
    wait until rising_edge(clk);
    address     <= '0' & addr; -- Write
    writedata   <= data;
    storage_clk <= '1';
    wait until rising_edge(clk);
    address     <= (others => '0');
    writedata   <= (others => '0');
    storage_clk <= '0';
  end procedure p_write;


  procedure p_read(
    constant addr     : in std_logic_vector(1 downto 0);
    constant expected : in std_logic_vector(7 downto 0)) is
  begin
    wait until rising_edge(clk);
    address     <= '1' & addr; -- Read
    storage_clk <= '1';
    wait until rising_edge(clk);
    address     <= (others => '0');
    storage_clk <= '0';
    wait until rising_edge(clk);


    -- Report result
    if readdata = expected then
      report "Read data is correct: data = " & to_hstring(readdata) & " , expected = " & to_hstring(expected) severity note;
    else
      report "Read data is not correct: data = " & to_hstring(readdata) & " , expected = " & to_hstring(expected) severity error;
    end if;
  end procedure p_read;

  begin
  --------------------------------------------START SIMULATION-------------------------------------------
  -- Sequential code

      wait for clk_period * 2;

      rst <= '0';
      wait for clk_period * 2;
      rst <= '1';

      p_write("00", X"AA");
      p_write("01", X"BB");
      p_write("10", X"CC");
      p_write("11", X"DD");
      p_read("00", X"AA");
      p_read("01", X"BB");
      p_read("10", X"CC");
      p_read("11", X"DD");
      

      wait for clk_period * 2;
      std.env.stop(0);

  end process MAIN;
end architecture;