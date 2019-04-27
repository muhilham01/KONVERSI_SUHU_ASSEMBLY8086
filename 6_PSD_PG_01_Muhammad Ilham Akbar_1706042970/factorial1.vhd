library ieee;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity factorial1 is
    port (  clock    : in std_logic;
				data1    : in std_logic_vector( 3 downto 0 );    
			   dataout  : out std_logic_vector( 7 downto 0)
    );
end entity;


architecture behavior of factorial1 is
	 SIGNAL calc		: STD_LOGIC_VECTOR(3 DOWNTO 0):= "0010";
    SIGNAL dummy      : STD_LOGIC_VECTOR(7 DOWNTO 0):= "00000001";
    
    begin
        process
        begin
            wait until clock'event and clock = '1' ;
            if data1 < "0110" then
                if calc <= data1 then
                    dummy        <= dummy(4 downto 0) * calc(2 downto 0);
                    calc   <= calc + 1;
                end if;
                else dummy  <= "00000000";
            end if;
        dataout <= dummy; 	 
        end process;
end behavior;
        