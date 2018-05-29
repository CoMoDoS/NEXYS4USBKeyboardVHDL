
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_reception is
   Port (
   Clock : in std_logic;
   Reset : in std_logic;
   Enable : in std_logic;
   Ps2clock : in std_logic;
   Ps2data : in std_logic;
   An : out std_logic_vector(7 downto 0);
   Seg : out std_logic_vector(7 downto 0);
   Error: out std_logic
);
end top_reception;

architecture Behavioral of top_reception is
signal sOutput,dataReg: std_logic_vector(7 downto 0):=(others=>'0');
signal sReady: std_logic:='0';
signal Afis: std_logic_vector(7 downto 0):=(others=>'0');
begin

display: entity work.display7seg
    port map(
    Clk=>Clock,
    Rst=>Reset,
    Data=>Afis,
    An=>An,
    Seg=>Seg
    );

reception: entity work.ps2_keyboard
    port map(
    Clock=>Clock,
    Reset=>Reset,
    Enable=>Enable,
    Ps2clock=>Ps2clock,
    Ps2data=>Ps2data,
    Output=>sOutput,
    Ready=>sReady,
    Error=>Error
    );
process(Clock)
begin
    if rising_edge(Clock) then
        if(Reset='1') then
            dataReg<=(others=>'0');
        elsif(Enable='1') then
            if(sReady='1') then
                dataReg<=sOutput;
            else 
                dataReg<=dataReg;
            end if;
        end if;
    end if;
end process;
Afis<=dataReg;
end Behavioral;
