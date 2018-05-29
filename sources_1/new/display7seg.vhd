

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity display7seg is
    Port ( Clk  : in  STD_LOGIC;
           Rst  : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (7 downto 0);   -- datele pentru 8 cifre (cifra 1 din stanga: biti 31..28)
           An   : out STD_LOGIC_VECTOR (7 downto 0);    -- selectia anodului activ
           Seg  : out STD_LOGIC_VECTOR (7 downto 0));   -- selectia catozilor (segmentelor) cifrei active
end display7seg;

architecture Behavioral of display7seg is
begin
    An<="11111110";
decoder: entity work.scancodeTochar
    port map(scancode=>Data,char=>Seg);
end Behavioral;
