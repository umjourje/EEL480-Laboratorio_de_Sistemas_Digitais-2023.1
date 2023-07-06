
LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY HA IS

    PORT (

        A      : IN  std_logic;
        B      : IN  std_logic;

        S      : OUT std_logic;
        Cout   : OUT std_logic
    
    );

END HA;


ARCHITECTURE Behavioral OF HA IS

BEGIN

    S <= A XOR B;
    Cout <= A AND B;

END Behavioral;
