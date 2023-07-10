
LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY ULA IS

    PORT (
        
        -- Duas entradas principais de 4 bits para realizar as operações
        entrada1      : IN  std_logic_vector(3 DOWNTO 0);
        entrada2      : IN  std_logic_vector(3 DOWNTO 0);

        -- Entrada seletora pra escolher entre as 8 operações da ULA
        --seletor       : IN  std_logic_vector(2 DOWNTO 0);
        seletor       : IN  std_logic;

        -- Saída com o resultado da operação selecionada
        resultado     : OUT  std_logic_vector(3 DOWNTO 0);
        
        -- Flags
        zero          : OUT  std_logic;
        overFlow      : OUT  std_logic;
        negativo      : OUT  std_logic;
        cout          : OUT  std_logic

    );

END ULA;


ARCHITECTURE Behavioral OF ULA IS

    -- Sinais com os resultados de cada uma das operações
    SIGNAL  som  :   std_logic_vector(3 DOWNTO 0); -- sinal com o resultado da soma
    SIGNAL  sub  :   std_logic_vector(3 DOWNTO 0); -- sinal com o resultado da subtração
    SIGNAL  inc  :   std_logic_vector(3 DOWNTO 0); -- sinal com o resultado do incremento de 1
    SIGNAL  tds  :   std_logic_vector(3 DOWNTO 0); -- sinal com o resultado da troca de sinal

    -- Sinais intermediários para realizar cada uma das operações
    
    ---------------------------------------------SOMA-----------------------------------------------------
    
    -- Cin do primeiro Full Adder é igual a 0 para a soma
    SIGNAL  somaCIN   :   std_logic   := '0';

    -- Cout de cada um dos 4 Full Adder que compões o somador de 4 bits
    SIGNAL  somaCOUT  :   std_logic_vector(3 DOWNTO 0);

    ------------------------------------------ Subtração--------------------------------------------------

    -- Cin do primeiro Full Adder é igual a 1 para a subtração
    SIGNAL  subCIN   :   std_logic   := '1';

    -- Cout de cada um dos 4 Full Adder que compões o subtrator de 4 bits
    SIGNAL  subCOUT  :   std_logic_vector(3 DOWNTO 0);

    
    ---------------------------------------- Incremento de 1----------------------------------------------

    ---------------------------------------- Troca de sinal-----------------------------------------------

    BEGIN

        -- resultados e Cout da Soma 
        som(0) <= entrada1(0) XOR entrada2(0) XOR somaCIN;
        somaCOUT(0) <= (entrada1(0) AND entrada2(0)) OR (entrada1(0) AND somaCIN) OR (entrada2(0) AND somaCIN);

        som(1) <= entrada1(1) XOR entrada2(1) XOR somaCOUT(0);
        somaCOUT(1) <= (entrada1(1) AND entrada2(1)) OR (entrada1(1) AND somaCOUT(0)) OR (entrada2(1) AND somaCOUT(0));

        som(2) <= entrada1(2) XOR entrada2(2) XOR somaCOUT(1);
        somaCOUT(2) <= (entrada1(2) AND entrada2(2)) OR (entrada1(2) AND somaCOUT(1)) OR (entrada2(2) AND somaCOUT(1));

        som(3) <= entrada1(3) XOR entrada2(3) XOR somaCOUT(2);
        somaCOUT(3) <= (entrada1(3) AND entrada2(3)) OR (entrada1(3) AND somaCOUT(2)) OR (entrada2(3) AND somaCOUT(2));


        
        -- resultados e Cout da Subtração 
        sub(0) <= entrada1(0) XOR (NOT entrada2(0)) XOR subCIN;
        subCOUT(0) <= (entrada1(0) AND (NOT entrada2(0))) OR (entrada1(0) AND subCIN) OR ((NOT entrada2(0)) AND subCIN);

        sub(1) <= entrada1(1) XOR (NOT entrada2(1)) XOR subCOUT(0);
        subCOUT(1) <= (entrada1(1) AND (NOT entrada2(1))) OR (entrada1(1) AND subCOUT(0)) OR ((NOT entrada2(1)) AND subCOUT(0));

        sub(2) <= entrada1(2) XOR (NOT entrada2(2)) XOR subCOUT(1);
        subCOUT(2) <= (entrada1(2) AND (NOT entrada2(2))) OR (entrada1(2) AND subCOUT(1)) OR ((NOT entrada2(2)) AND subCOUT(1));

        sub(3) <= entrada1(3) XOR (NOT entrada2(3)) XOR subCOUT(2);
        subCOUT(3) <= (entrada1(3) AND (NOT entrada2(3))) OR (entrada1(3) AND subCOUT(2)) OR ((NOT entrada2(3)) AND subCOUT(2));


        resultado(0) <= som(0)  WHEN  seletor   = '0'   else
                        sub(0)  WHEN  seletor   = '1';

        resultado(1) <= som(1)  WHEN  seletor   = '0'   else
                        sub(1)  WHEN  seletor   = '1';

        resultado(2) <= som(2)  WHEN  seletor   = '0'   else
                        sub(2)  WHEN  seletor   = '1';

        resultado(3) <= som(3)  WHEN  seletor   = '0'   else
                        sub(3)  WHEN  seletor   = '1';


        cout <= somaCOUT(3)  WHEN  seletor   = '0'   else
                subCOUT(3)   WHEN  seletor   = '1';

END Behavioral;
