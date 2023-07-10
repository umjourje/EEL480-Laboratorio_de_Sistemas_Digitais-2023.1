library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity somador is
	port(
      x: in  BIT_VECTOR(3 DOWNTO 0);
      y: in  BIT_VECTOR(3 DOWNTO 0);
      cin: in  BIT;
      cout: buffer  BIT;
      overflow: out  BIT;
      zero: out  BIT;
      z: buffer  BIT_VECTOR(3 DOWNTO 0);
      c1, c2, c3 : buffer BIT
    );
end somador;

architecture Behavioral of somador is

begin
  z(0) <= x(3) XOR y(3) XOR cin;
  c1 <= (x(3) OR y(3)) AND ((x(3) XOR y(3)) OR cin);

  z(1) <= x(2) XOR y(2) XOR c1;
  c2 <= (x(2) OR y(2)) AND ((x(2) XOR y(2)) OR c1);

  z(2) <= x(1) XOR y(1) XOR c2;
  c3 <= (x(1) OR y(1)) AND ((x(1) XOR y(1)) OR c2);

  z(3) <= x(0) XOR y(0) XOR c3;
  cout <= (x(0) OR y(0)) AND ((x(0) XOR y(0)) OR c3);

  zero <= cout OR z(0) OR z(1) OR z(2) OR z(3);
  overflow <= cout AND z(0) AND z(1) AND z(2) AND z(3);

end Behavioral;