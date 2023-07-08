library ieee;
use ieee.std_logic_1164.all;

ENTITY ULA IS
    PORT (
    
        a, b            :       in std_logic_vector(3 DOWNTO 0);
        seletor         :       in std_logic_vector(1 DOWNTO 0);
        --seletor       :       in std_logic_vector(2 DOWNTO 0);

        resultado       :       out std_logic_vector(3 DOWNTO 0);

        ovf             :       out std_logic;
        zero            :       out std_logic;
        Neg             :       out std_logic;
        cout            :       out std_logic
  
    );
END ULA;

ARCHiTECTURE Behavioral OF ULA IS
  
    FUNCTION HA(a, b: std_logic) RETURN std_logic_vector IS 
    
        VARIABLE sum, cout: std_logic;
  
        BEGIN
    
            sum := a XOR b;
            cout := a AND b;
            return (sum, cout);
  
    END FUNCTION;

    FUNCTION FA(a, b, c: std_logic) RETURN std_logic_vector IS 
    
        VARIABLE sum, cout                  :       std_logic;
        VARIABLE sumHA1,coutHA1,coutHA2     :       std_logic;

        BEGIN

            (sumHA1,coutHA1)    :=   HA(a,b);
            (sum,coutHA2)       :=   HA(sumHA1,c);
            cout                :=   coutHA1 OR coutHA2;

            RETURN (sum, cout);
    
    END FUNCTION;

    FUNCTION somador4Bits(a,b : std_logic_vector) RETURN std_logic_vector IS

        VARIABLE sum, cout                  :      std_logic_vector(3 DOWNTO 0);

        BEGIN

            (sum(0), cout(0)) := FA(a(0), b(0), '0');
            (sum(1), cout(1)) := FA(a(1), b(1), cout(0));
            (sum(2), cout(2)) := FA(a(2), b(2), cout(1));
            (sum(3), cout(3)) := FA(a(3), b(3), cout(2));

            RETURN (sum(3),sum(2),sum(1),sum(0),cout(3),cout(2),cout(1),cout(0));

    END FUNCTION;

    FUNCTION subtrator4Bits(a,b : std_logic_vector) RETURN std_logic_vector IS

        VARIABLE sum, cout                  :      std_logic_vector(3 DOWNTO 0);

        BEGIN

            (sum(0), cout(0)) := FA(a(0), (NOT b(0)), '1');
            (sum(1), cout(1)) := FA(a(1), (NOT b(1)), cout(0));
            (sum(2), cout(2)) := FA(a(2), (NOT b(2)), cout(1));
            (sum(3), cout(3)) := FA(a(3), (NOT b(3)), cout(2));

            RETURN (sum(3),sum(2),sum(1),sum(0),cout(3),cout(2),cout(1),cout(0));

    END FUNCTION;

    FUNCTION trocaDeSinal(a,b : std_logic_vector) RETURN std_logic_vector IS

        VARIABLE sum, cout                  :      std_logic_vector(3 DOWNTO 0);

        BEGIN

            (sum(0), cout(0)) := FA('0', (NOT b(0)), '1');
            (sum(1), cout(1)) := FA('0', (NOT b(1)), cout(0));
            (sum(2), cout(2)) := FA('0', (NOT b(2)), cout(1));
            (sum(3), cout(3)) := FA('0', (NOT b(3)), cout(2));

            RETURN (sum(3),sum(2),sum(1),sum(0),cout(3),cout(2),cout(1),cout(0));

    END FUNCTION;

    FUNCTION incrementoDe1(a,b : std_logic_vector) RETURN std_logic_vector IS

        VARIABLE sum, cout                  :      std_logic_vector(3 DOWNTO 0);

        BEGIN

            (sum(0), cout(0)) := FA(a(0), '1', '0');
            (sum(1), cout(1)) := FA(a(1), '0', cout(0));
            (sum(2), cout(2)) := FA(a(2), '0', cout(1));
            (sum(3), cout(3)) := FA(a(3), '0', cout(2));

            RETURN (sum(3),sum(2),sum(1),sum(0),cout(3),cout(2),cout(1),cout(0));

    END FUNCTION;

    -- SOMA
    SIGNAL soma, carryoutSOMA : std_logic_vector(3 DOWNTO 0);

    -- SUBTRAÇÃO
    SIGNAL sub, carryoutSUB : std_logic_vector(3 DOWNTO 0);

    -- INCREMENTO DE 1
    SIGNAL inc, carryoutINC : std_logic_vector(3 DOWNTO 0);

    -- TROCA DE SINAL
    SIGNAL tds, carryoutTDS : std_logic_vector(3 DOWNTO 0);



    BEGIN

    (soma(3),soma(2),soma(1),soma(0),carryoutSOMA(3),carryoutSOMA(2),carryoutSOMA(1),carryoutSOMA(0)) <= somador4Bits(a,b);
    (sub(3),sub(2),sub(1),sub(0),carryoutSUB(3),carryoutSUB(2),carryoutSUB(1),carryoutSUB(0)) <= subtrator4Bits(a,b);
    (inc(3),inc(2),inc(1),inc(0),carryoutINC(3),carryoutINC(2),carryoutINC(1),carryoutINC(0)) <= incrementoDe1(a,b);
    (tds(3),tds(2),tds(1),tds(0),carryoutTDS(3),carryoutTDS(2),carryoutTDS(1),carryoutTDS(0)) <= trocaDeSinal(a,b);


    resultado   <=  soma    WHEN    seletor <= "00"  ELSE
                    sub     WHEN    seletor <= "01"  ELSE
                    inc     WHEN    seletor <= "10"  ELSE
                    tds     WHEN    seletor <= "11";

    cout        <=  carryoutSOMA(3)    WHEN    seletor <= "00"  ELSE
                    carryoutSUB(3)     WHEN    seletor <= "01"  ELSE
                    carryoutINC(3)     WHEN    seletor <= "10"  ELSE
                    carryoutTDS(3)     WHEN    seletor <= "11";

END Behavioral;
