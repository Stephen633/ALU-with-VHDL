
library IEEE;
use IEEE.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed;

entity MINUS is
port(
A: in std_logic_vector (15 downto 0);
B: in std_logic_vector (15 downto 0);
S: out std_logic_vector (15 downto 0)
);
end MINUS;

architecture Behavioral of MINUS is
signal S1 : signed (15 downto 0);
begin
S1 <= SIGNED(A) - SIGNED(B);
S <= std_logic_vector(S1);
end Behavioral;