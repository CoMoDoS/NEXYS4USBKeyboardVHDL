
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity filter is
   Port ( 
      Enable: in std_logic;
      Reset : in  std_logic;
      Clock : in  std_logic;
      Ps2clock : in  std_logic;
      Ps2data : in  std_logic;
      Ps2clock_filtered	: out std_logic;
      Ps2data_filtered	: out std_logic
   );
end filter;

architecture Behavioral of filter is

begin

process (Clock, Reset, Enable)
   variable ps2clock_buff: STD_LOGIC_VECTOR(7 downto 0) := (others => '1');
   variable ps2data_buff: STD_LOGIC_VECTOR(7 downto 0) := (others => '1');
begin
   if rising_edge(Clock) then
         if Reset='1' then
            ps2clock_buff := (others => '1');
            ps2data_buff := (others => '1');
         elsif(Enable='1') then
            ps2clock_buff := Ps2clock & ps2clock_buff(7 downto 1);
            ps2data_buff := Ps2data & ps2data_buff(7 downto 1);
            
            if (ps2clock_buff = "00000000") then
               Ps2clock_filtered <= '0';
            elsif (ps2clock_buff = "11111111") then
               Ps2clock_filtered <= '1';
            end if;

            if (ps2data_buff = "00000000") then
               Ps2data_filtered <= '0';
            elsif (ps2data_buff = "11111111") then
               Ps2data_filtered <= '1';
            end if;
         end if;
     end if;
end process;

end Behavioral;
