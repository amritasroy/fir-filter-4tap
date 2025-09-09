library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Synchro_Unit is
  port (
    CLK     : in  std_logic;
    Reset_n : in  std_logic;
    Enable  : in  std_logic
  );
end entity;

architecture Behavioral of Synchro_Unit is
begin
  -- Placeholder: synchronization logic if needed later
  -- Kept minimal to match the simplified top-level
end architecture;
