library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.NUMERIC_STD.ALL;

entity DIVIDE is
       generic (bits: integer := 8);
 port (
  a     :  in std_logic_vector(bits*2 - 1 downto 0);
  b     :  in std_logic_vector(bits-1 downto 0);
  result:  out std_logic_vector(bits*2 - 1 downto 0);
  remain:  out std_logic_vector(bits-1 downto 0)     
  );
end DIVIDE;

architecture Behavioral of DIVIDE is

signal  temp1:std_logic_vector(bits*2-1 downto 0);
signal  temp2:std_logic_vector(bits*2-1 downto 0);
signal  temp3:std_logic_vector(bits*2-1 downto 0);

begin process (a,b)
begin
temp1(bits * 2 - 1 downto bits) <= b(bits - 1 downto 0);
temp1(bits - 1 downto 0)  <= (others => '0');
temp2(bits * 2 - 1 downto 0) <= a(bits * 2 - 1 downto 0);

for i in bits * 2 - 1 downto 0 loop
    if (temp2 >= temp1) then
       temp2 <= temp2 - temp1;
       temp1 <= std_logic_vector(shift_right(signed(temp1), 1));
       temp3(i) <= '1';
    else      
       temp2 <= temp2;
       temp1 <= std_logic_vector(shift_right(signed(temp1), 1));
       temp3(i) <= '0';
     end if;
end loop;

result(bits*2 - 1 downto 0) <= temp3(bits*2 -1 downto 0);
remain(bits - 1 downto 0) <= temp1(bits - 1 downto 0);

END PROCESS;

end Behavioral;