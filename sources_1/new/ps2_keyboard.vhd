
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ps2_keyboard is
   Port (
      Clock : in std_logic;
      Reset : in std_logic;
      Enable : in std_logic;
      Ps2clock : in std_logic;
      Ps2data : in std_logic;
      Output : out std_logic_vector(7 downto 0);
      Ready: out std_logic;
      Error: out std_logic
   );
end ps2_keyboard;

architecture Behavioral of ps2_keyboard is
signal  filtered_clock, filtered_data: std_logic;
type TIP_STARE is (Init, Waait, Read, GetData, DataReady, Done);
signal Stare : TIP_STARE;

begin
filter_comp : entity work.filter 
   port map(
	Clock => Clock,
	Reset => Reset,
	Enable => Enable,
	Ps2clock => Ps2clock,
	Ps2data  => Ps2data,
	Ps2clock_filtered => filtered_clock,
	Ps2data_filtered  => filtered_data
   );
	
process(Clock)
variable counter:integer:=0;
variable parityCounter:integer:=0;
variable buf:std_logic_vector(8 downto 0):="000000000";
begin
if rising_edge(Clock) then
    if(Reset='1') then
        Stare<=Init;
    elsif(Enable='1') then
        case Stare is
            when Init=>
                counter:=0;
                parityCounter:=0;
                buf:="000000000";
                if(filtered_clock='0' and filtered_data='0') then
                    Stare<=Waait;
                end if;
            when Waait=>
                if(filtered_clock='1') then
                    Stare<=Read;
                end if;
            when Read=>
                if(filtered_clock='0') then
                    counter:=counter+1;
                    Stare<=GetData;
                end if;
            when GetData=>
                if(filtered_data='1')then
                    parityCounter:=parityCounter+1;
                end if;
                buf:=filtered_data & buf(8 downto 1);
                if(counter<9) then
                    Stare<=Waait;
                else
                    Stare<=DataReady;
                end if;
            when DataReady=>
                if((parityCounter mod 2)=0) then
                    Error<='1';
                else
                    Error<='0';
                end if;
                if(filtered_clock='1' and filtered_data='1') then
                    Output<=buf(7 downto 0);
                    Stare<=Done;
                end if;
            when Done => 
                Stare<=Init;
        end case;
    end if;
end if;
end process;

Ready<='1' when Stare=Done else '0';
end Behavioral;
