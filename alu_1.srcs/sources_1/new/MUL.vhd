library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.NUMERIC_STD.ALL;

entity MUL is
        generic (bits: integer := 16);
 port (
  a     :  in std_logic_vector(bits-1 downto 0);
  b     :  in std_logic_vector(bits-1 downto 0);
  result:  out std_logic_vector(bits*2-1 downto 0)     
  );
end MUL; 

architecture Behavioral of MUL is

signal  temp1:std_logic_vector(bits*2-1 downto 0);
signal  temp2:std_logic_vector(bits*2-1 downto 0);
begin process (a,b)
begin
temp1(bits - 1 downto 0) <= a(bits-1 downto 0);
temp1(bits*2 - 1 downto bits)  <= (others => '0');

for i in 0 to bits - 1 loop
    if (b(i) = '1') then
       temp1 <= std_logic_vector(shift_left(signed(temp1), 1));
       temp2 <= temp1 + temp2;
    else
       temp1 <= std_logic_vector(shift_left(signed(temp1), 1));
       temp2 <= temp2;
     end if;
end loop;
END PROCESS;
end Behavioral;