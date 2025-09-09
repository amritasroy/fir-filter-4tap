library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_Top_TB is
end entity;

architecture sim of FIR_Top_TB is
  signal CLK       : std_logic := '0';
  signal Reset_n   : std_logic := '0';
  signal Enable    : std_logic := '0';
  signal Valid_in  : std_logic := '0';
  signal Valid_out : std_logic;
  signal Data_in   : std_logic_vector(15 downto 0) := (others => '0');
  signal H_in      : std_logic_vector(15 downto 0) := (others => '0');
  signal Y_out     : std_logic_vector(33 downto 0);

  constant CLK_PERIOD : time := 10 ns; -- 100 MHz
begin
  DUT: entity work.FIR_Filter_Top
    port map (
      CLK => CLK, Reset_n => Reset_n, Enable => Enable,
      Valid_in => Valid_in, Data_in => Data_in, H_in => H_in,
      Valid_out => Valid_out, Y_out => Y_out
    );

  -- Clock
  CLK_process : process
  begin
    while true loop
      CLK <= '0'; wait for CLK_PERIOD/2;
      CLK <= '1'; wait for CLK_PERIOD/2;
    end loop;
  end process;

  -- Stimulus
  stim_proc : process
  begin
    -- Reset
    Reset_n <= '0';
    wait for 2*CLK_PERIOD;
    Reset_n <= '1';
    Enable  <= '1';

    -- Drive coefficients and samples
    wait for CLK_PERIOD;
    H_in <= x"0001"; Data_in <= x"000A"; Valid_in <= '1'; wait for CLK_PERIOD;
    H_in <= x"0002"; Data_in <= x"000B"; wait for CLK_PERIOD;
    H_in <= x"0003"; Data_in <= x"000C"; wait for CLK_PERIOD;
    H_in <= x"0004"; Data_in <= x"000D"; wait for CLK_PERIOD;
    Valid_in <= '0';

    -- Observe pipeline for a while
    wait for 40*CLK_PERIOD;

    assert false report "End of simulation" severity failure;
  end process;
end architecture;
