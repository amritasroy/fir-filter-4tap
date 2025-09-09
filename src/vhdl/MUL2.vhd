library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUL2 is
  port (
    X2, X3 : in  std_logic_vector(15 downto 0);
    H2, H3 : in  std_logic_vector(15 downto 0);
    P2, P3 : out std_logic_vector(31 downto 0)
  );
end entity;

architecture Behavioral of MUL2 is
begin
  P2 <= std_logic_vector(signed(X2) * signed(H2));
  P3 <= std_logic_vector(signed(X3) * signed(H3));
end architecture;
