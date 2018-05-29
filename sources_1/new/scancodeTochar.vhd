


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity scancodeTochar is
  Port (scancode: in std_logic_vector(7 downto 0);
        char: out std_logic_vector(7 downto 0) );
end scancodeTochar;

architecture Behavioral of scancodeTochar is

begin
 char <=  "11000000" when scancode = "01000101" else            -- 0
          "11111001" when scancode = "00010110" else            -- 1
          "10100100" when scancode = "00011110" else            -- 2
          "10110000" when scancode = "00100110" else            -- 3
          "10011001" when scancode = "00100101" else            -- 4
          "10010010" when scancode = "00101110" else            -- 5
          "10000010" when scancode = "00110110" else            -- 6
          "11111000" when scancode = "00111101" else            -- 7
          "10000000" when scancode = "00111110" else            -- 8
          "10010000" when scancode = "01000110" else            -- 9
          "10001000" when scancode = "00011100" else            -- A
          "10000011" when scancode = "00110010" else            -- b
          "11000110" when scancode = "00100001" else            -- C
          "10100001" when scancode = "00100011" else            -- d
          "10000110" when scancode = "00100100" else            -- E
          "10001110" when scancode = "00101011" else            -- F
          "10000010" when scancode = "00110100" else            -- G
          "10001001" when scancode = "00110011" else            -- H
          "11001111" when scancode = "01000011" else            -- I
          "11000111" when scancode = "01001011" else            -- L
          "10101011" when scancode = "00110001" else            -- n
          "10100011" when scancode = "01000100" else            -- o
          "10001100" when scancode = "01001101" else            -- P
          "00100011" when scancode = "00010101" else            -- q
          "10001111" when scancode = "00101100" else            -- T
          "11000001" when scancode = "00111100" else            -- U
          "11110111" when scancode = "00101001" else            -- space
          "11111111";
end Behavioral;
