library ieee;
use ieee.std_logic_1164.all;

ENTITY FourBitAdder IS
  PORT (
    a, b    :   in std_logic_vector(3 DOWNTO 0);
    sum     :   out std_logic_vector(3 DOWNTO 0); 
    cout    :   out std_logic
  );
END FourBitAdder;

ARCHiTECTURE Behavioral OF FourBitAdder IS
  
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

    SIGNAL carryout : std_logic_vector(3 DOWNTO 0);

    BEGIN

    (sum(3),sum(2),sum(1),sum(0),carryout(3),carryout(2),carryout(1),carryout(0)) <= somador4Bits(a,b);
    cout <= carryout(3);

END Behavioral;
