library ieee;
use ieee.std_logic_1164.all;

entity Data_Output is
  port (
    CLK    : in  std_logic;
    Reset_n: in  std_logic;
    Enable : in  std_logic;
    Valid_in : in std_logic;
    ACC    : in  std_logic_vector(33 downto 0);
    Valid_out : out std_logic;
    Y_out  : out std_logic_vector(33 downto 0)
  );
end entity;

architecture Behavioral of Data_Output is
  signal regY : std_logic_vector(33 downto 0) := (others => '0');
  signal v1, v2 : std_logic := '0';
begin
  process(CLK, Reset_n)
  begin
    if Reset_n = '0' then
      regY <= (others => '0');
      v1   <= '0';
      v2   <= '0';
    elsif rising_edge(CLK) then
      v1 <= Valid_in;
      v2 <= v1;
      if Enable = '1' then
        regY <= ACC;
      end if;
    end if;
  end process;

  Valid_out <= v2;
  Y_out <= regY;
end architecture;
