library ieee;
use ieee.std_logic_1164.all;


entity seven_segment is
    port (  data1  		: in std_logic_vector( 3 downto 0 );
            output_disp : out std_logic_vector( 6 downto 0 )
    );
end entity;

architecture behavior of seven_segment is
    begin
        process (data1)
        begin
            case (data1) is
            when "0000" => output_disp  <= "1111110"; --0  
            when "0001" => output_disp  <= "1111110"; --1  
            when "0010" => output_disp  <= "1101101"; --2    
            when "0011" => output_disp  <= "1111001"; --3  
            when "0100" => output_disp  <= "0110011"; --4  
            when "0101" => output_disp  <= "1011011"; --5  
            when "0110" => output_disp  <= "1011111"; --6  
            when "0111" => output_disp  <= "1110000"; --7 
            when "1000" => output_disp  <= "1111111"; --8
				WHEN "1001" => output_disp  <= "1111011"; --9
            WHEN "1010" => output_disp  <= "1110111"; --A  
		      WHEN "1011" => output_disp  <= "1111111"; --B  
	      	WHEN "1100" => output_disp  <= "1001110"; --C 
		      WHEN "1101" => output_disp  <= "1111110"; --D  
		      WHEN "1110" => output_disp  <= "1001111"; --E  
		      WHEN "1111" => output_disp  <= "1000111"; --F  
            when others => output_disp  <= "0000000"; --Others  
            end case;
        end process;
end behavior;

