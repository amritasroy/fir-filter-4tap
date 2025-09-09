library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUL1 is
  port (
    X0, X1 : in  std_logic_vector(15 downto 0);
    H0, H1 : in  std_logic_vector(15 downto 0);
    P0, P1 : out std_logic_vector(31 downto 0)
  );
end entity;

architecture Behavioral of MUL1 is
begin
  P0 <= std_logic_vector(signed(X0) * signed(H0));
  P1 <= std_logic_vector(signed(X1) * signed(H1));
end architecture;
