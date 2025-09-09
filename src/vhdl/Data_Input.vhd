library ieee;
use ieee.std_logic_1164.all;

entity Data_Input is
  port (
    CLK  : in  std_logic;
    Reset_n : in std_logic;
    Enable  : in std_logic;
    D_in : in  std_logic_vector(15 downto 0);
    X0, X1, X2, X3 : out std_logic_vector(15 downto 0)
  );
end entity;

architecture Behavioral of Data_Input is
  signal reg0, reg1, reg2, reg3 : std_logic_vector(15 downto 0) := (others => '0');
begin
  process(CLK, Reset_n)
  begin
    if Reset_n = '0' then
      reg0 <= (others => '0');
      reg1 <= (others => '0');
      reg2 <= (others => '0');
      reg3 <= (others => '0');
    elsif rising_edge(CLK) then
      if Enable = '1' then
        reg3 <= reg2;
        reg2 <= reg1;
        reg1 <= reg0;
        reg0 <= D_in;
      end if;
    end if;
  end process;

  X0 <= reg0; X1 <= reg1; X2 <= reg2; X3 <= reg3;
end architecture;
