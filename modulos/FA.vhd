
LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY FA IS

    PORT (

        a      : IN  std_logic;
        b      : IN  std_logic;
        cin      : IN  std_logic;


        s      : OUT std_logic;
        cout   : OUT std_logic
    
    );

END FA;


ARCHITECTURE Structural OF FA IS

    COMPONENT HA 

        PORT (

            A      : IN  std_logic;
            B      : IN  std_logic;

            S      : OUT std_logic;
            Cout   : OUT std_logic

        );

    END COMPONENT;

    SIGNAL somaHA1, coutHA1, coutHA2: std_logic;

    BEGIN

        HA1: HA PORT MAP (

            a,
            b,
            somaHA1,
            coutHA1
        );
        
        HA2: HA PORT MAP (

            somaHA1,
            cin,
            s,
            coutHA2
        );

        cout <= coutHA1 OR coutHA2;

END Structural;
