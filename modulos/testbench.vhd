-- baseado nas testbenchs encontradas em: https://www.edaplayground.com/
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

  -- DUT component
  component ALU is
  port(
      x, y: in  std_logic_vector(3 downto 0);
      Cin:   in  std_logic;
      OP:    in  std_logic_vector(2 downto 0);
      Result: out std_logic_vector(3 downto 0);
      Zero:  out std_logic;
      Ovr:   out std_logic;
      Neg:   out std_logic;
      Cout:  out std_logic
  );
  end component;

  -- Declaração dos sinais utilizados na testbench
  signal x, y: std_logic_vector(3 downto 0);
  signal Cin: std_logic;
  signal OP: std_logic_vector(2 downto 0);
  signal Result: std_logic_vector(3 downto 0);
  signal Zero, Ovr, Neg, Cout: std_logic;

  -- Constantes utilizadas na testbench
  constant PERIOD: time := 10 ns;

begin

  -- Connect DUT
  DUT: ALU port map(
      x => x,
      y => y,
      Cin => Cin,
      OP => OP,
      Result => Result,
      Zero => Zero,
      Ovr => Ovr,
      Neg => Neg,
      Cout => Cout
    );

process
  begin
    -- Teste 1 - SOMA
    x <= "1011";
    y <= "0010";
    Cin <= '0';
    OP <= "000";
    wait for PERIOD;
    assert(Result="1101") report "Result Fail" severity error;
    assert(Neg='0') report "Neg Fail" severity error;
    assert(Cout='0') report "Cout Fail" severity error;
    assert(Zero='0') report "Zero Fail" severity error;
    assert(Ovr='0') report "Ovr Fail" severity error;

    -- Teste 2 - SUBTRACAO
    x <= "1011";
    y <= "0010";
    Cin <= '0';
    OP <= "000";
    wait for PERIOD;
    assert(Result="1001") report "Result Fail" severity error;
    assert(Neg='0') report "Neg Fail" severity error;
    assert(Cout='0') report "Cout Fail" severity error;
    assert(Zero='0') report "Zero Fail" severity error;
    assert(Ovr='0') report "Ovr Fail" severity error;

    -- Teste 3 - INCREMENTO DE 1
    x <= "1011";
    y <= "0010";
    Cin <= '0';
    OP <= "000";
    wait for PERIOD;
    assert(Result="1100") report "Result Fail" severity error;
    assert(Neg='0') report "Neg Fail" severity error;
    assert(Cout='0') report "Cout Fail" severity error;
    assert(Zero='0') report "Zero Fail" severity error;
    assert(Ovr='0') report "Ovr Fail" severity error;
    
    -- Teste 4 - TROCA DE SINAL
    x <= "1011";
    y <= "0010";
    Cin <= '0';
    OP <= "000";
    wait for PERIOD;
    assert(Result="0101") report "Result Fail" severity error;
    assert(Neg='1') report "Neg Fail" severity error;
    assert(Cout='0') report "Cout Fail" severity error;
    assert(Zero='0') report "Zero Fail" severity error;
    assert(Ovr='0') report "Ovr Fail" severity error;    

    -- Teste 5 - DECREMENTO de 1
    x <= "1011";
    y <= "0010";
    Cin <= '0';
    OP <= "000";
    wait for PERIOD;
    assert(Result="1010") report "Result Fail" severity error;
    assert(Neg='0') report "Neg Fail" severity error;
    assert(Cout='0') report "Cout Fail" severity error;
    assert(Zero='0') report "Zero Fail" severity error;
    assert(Ovr='0') report "Ovr Fail" severity error;    
    
    -- Teste 6 - MULTIPLICACAO POR 2
    x <= "1011";
    y <= "0010";
    Cin <= '0';
    OP <= "000";
    wait for PERIOD;
    assert(Result="0110") report "Result Fail" severity error;
    assert(Neg='0') report "Neg Fail" severity error;
    assert(Cout='1') report "Cout Fail" severity error;
    assert(Zero='0') report "Zero Fail" severity error;
    assert(Ovr='0') report "Ovr Fail" severity error;    
    
    -- Teste 7 - AND
    x <= "1011";
    y <= "0010";
    Cin <= '0';
    OP <= "000";
    wait for PERIOD;
    assert(Result="0010") report "Result Fail" severity error;
    assert(Neg='0') report "Neg Fail" severity error;
    assert(Cout='0') report "Cout Fail" severity error;
    assert(Zero='0') report "Zero Fail" severity error;
    assert(Ovr='0') report "Ovr Fail" severity error;    

    -- Teste 8 - XOR
    x <= "1011";
    y <= "0010";
    Cin <= '0';
    OP <= "000";
    wait for PERIOD;
    assert(Result="1101") report "Result Fail" severity error;
    assert(Neg='0') report "Neg Fail" severity error;
    assert(Cout='0') report "Cout Fail" severity error;
    assert(Zero='0') report "Zero Fail" severity error;
    assert(Ovr='0') report "Ovr Fail" severity error;    
    
    wait;
  end process;
end tb;