-- bibliotecas necessárias
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- declaração dos valores de entrada e saída da ALU
entity ALU is
  Port (
      x, y: in  std_logic_vector(3 downto 0);  -- inputs x e y
      Cin:   in  std_logic;                    -- carry-in
      OP:    in  std_logic_vector(2 downto 0);  -- seleciona a operação
      Result: out std_logic_vector(3 downto 0); -- resultado
      Zero:  out std_logic;                    -- flag que indica se o resultado é zero
      Ovr:   out std_logic;                    -- flag que indica se houve overflow
      Neg:   out std_logic;                    -- flag que indica se o resultado é negativo
      Cout:  out std_logic                     -- flag que indica o carry-out
  );
end ALU;

-- signals são os sinais intermediarios usados na operacao
-- c1, c2, c3, c4 sao os carry intermediarios do carry look-ahead
-- s_cin, s_y e s_x sao os valores de entrada do carry look-ahead, que sao alterados dependendo da operacao
-- s_r e s_cout é o valor de saida do carry look-ahead
architecture Behavioral of ALU is
  signal s_cin, s_cout, c1, c2, c3, c4: std_logic;
  signal s_y, s_x, s_r: std_logic_vector(3 downto 0);
begin

  -- CODIGO - OPERACAO
  -- 000 - SOMA
  -- 001 - SUBTRACAO
  -- 010 - INCREMENTO DE 1
  -- 011 - TROCA DE SINAL 
  -- 100 - DECREMENTO de 1
  -- 101 - MULTIPLICACAO POR 2
  -- 110 - AND
  -- 111 - XOR

  -- caso a operação seja soma, deve ser preservado o cin de entrada
  -- caso a operação seja subtração, incremento de 1 ou decremento de 1
  -- o valor de cin deve ser 1
  -- nos demais casos, o valor de cin deve ser 0 ou não é utilizado na operação
  s_cin <= Cin WHEN OP = "000" ELSE
    '1' WHEN (OP = "001" OR OP = "010" OR OP = "011" OR OP = "100") ELSE
    '0';

  -- x é o operando principal, e y o operando secundário
  -- o valor de entrada de y deve ser preservado quando a operação for soma, AND ou XOR
  -- caso seja subtração, o valor de y deve ser invertido, o que equivale ao complemento de 1 de y
  -- caso seja decremento de 1, y deve ser o complemento de 1 do valor "0001", ou seja, "1110"
  -- caso a operação seja multiplicaçao, y deve se igualar a x
  -- por fim, nos demais casos o valor de y deve ser "0000" ou não é utilizado na operação
  s_y <= y WHEN (OP = "000" OR OP = "110" OR OP = "111") ELSE
    NOT(y) WHEN (OP = "001") ELSE
    "1110" WHEN (OP = "100") ELSE
    x WHEN (OP = "101") ELSE
    "0000";

  -- o valor de x deve ser invertido, o que equivale ao complemento de 1 de x
  s_x <= NOT(x) WHEN (OP = "011") ELSE
  x;

  s_r(0) <= s_x(3) XOR s_y(3) XOR s_cin;
  
  s_r(1) <= s_x(2) XOR s_y(2) XOR c1;
  c2 <= (s_x(2) OR s_y(2)) AND ((s_x(2) XOR s_y(2)) OR c1);

  s_r(2) <= s_x(1) XOR s_y(1) XOR c2;
  c3 <= (s_x(1) OR s_y(1)) AND ((s_x(1) XOR s_y(1)) OR c2);

  s_r(3) <= s_x(0) XOR s_y(0) XOR c3;
  s_cout <= (s_x(0) OR s_y(0)) AND ((s_x(0) XOR s_y(0)) OR c3);

  Zero <= '1' WHEN (Cout = '0' AND Result = "0000") ELSE
  '0';
  Ovr <= '1' WHEN (Cout = '1' AND Result = "1111") ELSE
  '0';

  Result <= (x AND y) WHEN (OP = "110") ELSE
    (x XOR y) WHEN (OP = "111") ELSE
    s_r;

  Cout <= '0' WHEN (OP = "110" OR OP = "111") ELSE
    s_cout;

end Behavioral;
