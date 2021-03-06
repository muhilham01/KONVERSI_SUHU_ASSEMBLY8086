library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Entity for Decimal_Divider Programming Component
entity bagi1 is
    port (  clock   : in std_logic;
				data1  : in std_logic_vector( 3 downto 0 );    
            data2  : in std_logic_vector( 3 downto 0 );
			   dataout : out std_logic_vector( 4 downto 0)
    );
end entity;

--Behavior Model of Decimal_Dividers Component
architecture behavior of bagi1 is
    begin
        process(clock)
        begin
            if rising_edge(clock) then
                if data1 > data2 then
                    dataout <= std_logic_vector(to_unsigned(to_integer(unsigned(data1)/unsigned(data2)),5)); 	 
                elsif data2 > data1 then
                    dataout <= std_logic_vector(to_unsigned(to_integer(unsigned(data2)/unsigned(data1)),5)); 	 
                end if; 	 
            end if;
        end process;
end behavior;
        