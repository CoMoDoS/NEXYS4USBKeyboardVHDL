

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity top_reception_tb is
--  Port ( );
end top_reception_tb;

architecture Behavioral of top_reception_tb is
component top_reception is
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
end component;

signal Clock, Reset, Enable, Ps2data, Ps2clock, Error: std_logic:='0';
signal An, Seg: std_logic_vector(7 downto 0);
begin

rec: top_reception
    port map(
    Clock=>Clock,
    Reset=>Reset,
    Enable=>Enable,
    Ps2clock=>Ps2clock,
    Ps2data=>Ps2data,
    An=>An,
    Seg=>Seg,
    Error=>Error);


	-- 50MHz Clock
gen_clk:	process
	begin
		Clock <= '0';
		wait for 5 ns;
		Clock <= '1';
		wait for 5 ns;
	end process;
	
	process
        begin
            Reset <= '1';
            Enable <= '0';
            Ps2clock <= '1';
            Ps2data <= '1';
            wait for 100ns;
    
            Reset <= '1';
            Enable <= '1';
            Ps2clock <= '1';
            Ps2data <= '1';
            wait for 100ns;
            
            Reset <= '0';
            Enable <= '1';
            wait for 100ns;
            
            -- Simulate pressing the spacebar (Scancode: 0x29) "00101001"
-- Start bit
                    report "Sending Start Bit" severity warning;
                    Ps2data <= '0';
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    -- Send 0x29 LSB first
                    report "Sending Data" severity warning;
                    Ps2clock <= '1';
                    Ps2data <= '1';        -- bit 7
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    Ps2clock <= '1';
                    Ps2data <= '0';        -- bit 6
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    Ps2clock <= '1';
                    Ps2data <= '0';        -- bit 5
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    Ps2clock <= '1';
                    Ps2data <= '1';        -- bit 4
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    Ps2clock <= '1';
                    Ps2data <= '0';        -- bit 3
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    Ps2clock <= '1';
                    Ps2data <= '1';        -- bit 2
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    Ps2clock <= '1';
                    Ps2data <= '0';        -- bit 1
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    Ps2clock <= '1';
                    Ps2data <= '0';        -- bit 0
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    report "Sending Parity Bit" severity warning;
                    Ps2clock <= '1';
                    Ps2data <= '0';        -- parity bit
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    -- Send stop bit
                    Ps2clock <= '1';
                    Ps2data <= '1';
                    wait for 100ns;
                    Ps2clock <= '0';
                    wait for 100ns;
                    
                    Ps2clock <= '1';
                    Ps2data <= '1';
                    
                    wait for 100ns;
                    
                    report "Test sequence completed." 
                    severity note;
                    wait;
      
                end process;    
            
end Behavioral;
