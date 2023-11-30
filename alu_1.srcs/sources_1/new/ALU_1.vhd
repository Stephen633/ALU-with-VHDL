
library IEEE;
use IEEE.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ALU_1 is
port(
 A: in std_logic_vector (15 downto 0);
 B: in std_logic_vector (15 downto 0);
 S: out std_logic_vector (31 downto 0);
 C: out std_logic_vector (15 downto 0);
 sel: in std_logic_vector (1 downto 0)
);
end ALU_1;

architecture Behavioral of ALU_1 is

COMPONENT ADD IS
port (A, B: in std_logic_vector (15 downto 0);
      S: out std_logic_vector (15 downto 0));
end component ADD;

component MINUS IS
port (A, B: in std_logic_vector (15 downto 0);
      S: out std_logic_vector (15 downto 0));
end component MINUS;

component MUL is
        generic (bits: integer := 16);
 port (
  a     :  in std_logic_vector(bits-1 downto 0);
  b     :  in std_logic_vector(bits-1 downto 0);
  result:  out std_logic_vector(bits*2-1 downto 0)     
  );
end component MUL; 

component DIVIDE is
       generic (bits: integer := 8);
 port (
  a     :  in std_logic_vector(bits*2 - 1 downto 0);
  b     :  in std_logic_vector(bits-1 downto 0);
  result:  out std_logic_vector(bits*2 - 1 downto 0);
  remain:  out std_logic_vector(bits-1 downto 0)     
  );
end component DIVIDE;

signal  S1: std_logic_vector (15 downto 0);
signal  S2: std_logic_vector (15 downto 0);
signal  S3: std_logic_vector (31 downto 0);
signal  S4: std_logic_vector (15 downto 0);
signal  C4: std_logic_vector (7 downto 0);

begin
    u1: ADD port map (A => A, B => B, S => S1);
    u2: MINUS port map (A => A, B => B, S => S2);
    u3: MUL port map (a => A, b => B, result => S3);
    u4: DIVIDE port map (a => A, b => B (7 downto 0), result => S4, remain => C4);
    
    P1: process (A, B, sel)
    begin
    if (sel = "00") then
        S (15 downto 0) <= S1;
        S (31 downto 16) <= "0000000000000000";
    elsif (sel = "01") then
        S (15 downto 0) <= S2;
        S (31 downto 16) <= "0000000000000000";
    elsif (sel = "10") then
        S <= S3;
    elsif (sel = "11") then
        S (15 downto 0) <= S4;
        S (31 downto 16) <= "0000000000000000";
        C (7 downto 0) <= C4;
        C (15 downto 8) <= "00000000";
    end if;
    end process P1;
end Behavioral;
