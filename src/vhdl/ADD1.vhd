library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADD1 is
  port (
    P0, P1, P2, P3 : in  std_logic_vector(31 downto 0);
    ACC           : out std_logic_vector(33 downto 0)
  );
end entity;

architecture Behavioral of ADD1 is
begin
  -- Sum 4 products with resize to 34 bits
  ACC <= std_logic_vector(
            resize(signed(P0), 34) +
            resize(signed(P1), 34) +
            resize(signed(P2), 34) +
            resize(signed(P3), 34)
         );
end architecture;
