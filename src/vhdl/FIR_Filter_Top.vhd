library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_Filter_Top is
  port (
    CLK      : in  std_logic;
    Reset_n  : in  std_logic;
    Enable   : in  std_logic;
    Valid_in : in  std_logic;
    Data_in  : in  std_logic_vector(15 downto 0);
    H_in     : in  std_logic_vector(15 downto 0);
    Valid_out: out std_logic;
    Y_out    : out std_logic_vector(33 downto 0)
  );
end entity;

architecture Behavioral of FIR_Filter_Top is
  signal X0, X1, X2, X3 : std_logic_vector(15 downto 0) := (others => '0');
  signal H0, H1, H2, H3 : std_logic_vector(15 downto 0) := (others => '0');
  signal P0, P1, P2, P3 : std_logic_vector(31 downto 0) := (others => '0');
  signal ACC            : std_logic_vector(33 downto 0) := (others => '0');
begin
  Data_In_Inst : entity work.Data_Input
    port map (
      CLK => CLK, Reset_n => Reset_n, Enable => Enable,
      D_in => Data_in, X0 => X0, X1 => X1, X2 => X2, X3 => X3
    );

  Coeff_Reg_Inst : entity work.Coeff_Shift_Register
    port map (
      CLK => CLK, Reset_n => Reset_n, Enable => Enable,
      H_in => H_in, H0 => H0, H1 => H1, H2 => H2, H3 => H3
    );

  MUL1_Inst : entity work.MUL1
    port map ( X0 => X0, X1 => X1, H0 => H0, H1 => H1, P0 => P0, P1 => P1 );

  MUL2_Inst : entity work.MUL2
    port map ( X2 => X2, X3 => X3, H2 => H2, H3 => H3, P2 => P2, P3 => P3 );

  Adder_Inst : entity work.ADD1
    port map ( P0 => P0, P1 => P1, P2 => P2, P3 => P3, ACC => ACC );

  Output_Inst : entity work.Data_Output
    port map (
      CLK => CLK, Reset_n => Reset_n, Enable => Enable,
      Valid_in => Valid_in, ACC => ACC, Valid_out => Valid_out, Y_out => Y_out
    );

  Synch_Inst : entity work.Synchro_Unit
    port map ( CLK => CLK, Reset_n => Reset_n, Enable => Enable );
end architecture;
