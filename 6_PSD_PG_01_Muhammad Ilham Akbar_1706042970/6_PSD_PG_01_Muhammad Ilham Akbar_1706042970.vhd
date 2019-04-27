LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


ENTITY Memo_ram IS
PORT( 
		CLOCK 	 : IN STD_LOGIC;
		SELECTION : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		INP1 		 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		INP2 		 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		ENABLE   : IN STD_LOGIC;
		dump0,dump1,dump2,dump3,dump4,dump5,dump6,dump7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
END ENTITY;


ARCHITECTURE calculate OF Memo_ram IS
	SIGNAL CLK : STD_LOGIC;
	SIGNAL DATA : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ADDRESS : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal datain1 : std_logic_vector(3 downto 0);
	signal datain2 : std_logic_vector(3 downto 0);
	signal data_flow : std_logic_vector(4 downto 0);
	signal data_flow2 : std_logic_vector(4 downto 0);
	signal data_flow3 : std_logic_vector(7 downto 0);
	signal data_flow4 : std_logic_vector(4 downto 0);
	signal data_flow5 : std_logic_vector(7 downto 0);
	SIGNAL Q :  STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal COUNT : std_logic_vector(3 downto 0);
	SIGNAL COUNT1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL COUNT2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL COUNT4 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL EN :  STD_LOGIC;

    --komponen tambah1
    component tambah1 is
    port (  clock   : in std_logic;
				data1   : in std_logic_vector( 3 downto 0 );    
            data2   : in std_logic_vector( 3 downto 0 );   
				dataout : out std_logic_vector( 4 downto 0)
    );
	 end component;
	 
	 --komponen kurang1
    component kurang1 is
    port (  clock   : in std_logic;
				data1  : in std_logic_vector( 3 downto 0 );    
            data2  : in std_logic_vector( 3 downto 0 );
			   dataout : out std_logic_vector( 4 downto 0)
    );
	 end component;

    
    --komponen kali
    component kali1 is
    port (  clock   : in std_logic;
				data1   : in std_logic_vector( 3 downto 0 );    
            data2   : in std_logic_vector( 3 downto 0 );
			   dataout : out std_logic_vector( 7 downto 0 )
    );
	 end component;

    --komponen bagi
    component bagi1 is
    port (  clock   : in std_logic;
				data1  : in std_logic_vector( 3 downto 0 );    
            data2  : in std_logic_vector( 3 downto 0 );
			   dataout : out std_logic_vector( 4 downto 0)
    );
	 end component;

    --komponen faktorial
    component factorial1 is
    port (  clock    : in std_logic;
				data1    : in std_logic_vector( 3 downto 0 );    
			   dataout  : out std_logic_vector( 7 downto 0)
    );
	 end component;
    
    --komponen seven segment	 
    component seven_segment is
    port (  data1  		: in std_logic_vector( 3 downto 0 );
            output_disp : out std_logic_vector( 6 downto 0 )
    );
	 end component;

    BEGIN
	CLK <= CLOCK;
	DATAIN1 <= INP1;
	DATAIN2 <= INP2;
	EN <= ENABLE;
	ADDRESS <= selection;
	COUNT <= "000" & ADDRESS(4);
	COUNT1 <= "000" & DATA_flow;
	COUNT2 <= "000" & DATA_flow2;
	COUNT4 <= "000" & DATA_flow4;



	WITH SELECTION SELECT
			DATA  <= COUNT1 WHEN "00000",
						COUNT2 WHEN "00001",
						DATA_flow3 WHEN "00010",
						COUNT4 WHEN "00011",
						DATA_flow5 WHEN "00100",
						"00000000" WHEN OTHERS;
						
	Ram32x4_inst : ENTITY WORK.Ram32x8 PORT MAP (
		address	 => ADDRESS,
		clock	 => CLK,
		data	 => DATA,
		wren	 => EN,
		q	 => Q
	);
	
	--ARITMATIKA
	PENAMBAHAN_bil 	: tambah1 port map(clk,datain1,datain2,data_flow);
	PENGURANGAN_bil 	: kurang1 port map(clk,datain1,datain2,data_flow2);
	PERKALIAN_bil 		: kali1 port map(clk,datain1,datain2,data_flow3);
	PEMBAGIAN_bil 		: bagi1 port map(clk,datain1,datain2,data_flow4);
	faktorial_bil 		: factorial1 port map(clk,datain1,data_flow5);
	
	--TAMPILAN DI SEVEN SEGMEN
	SEVEN_SEG0 : seven_segment PORT MAP(ADDRESS(3 DOWNTO 0),dump0);
	SEVEN_SEG1 : seven_segment PORT MAP(COUNT,dump1);
	SEVEN_SEG2 : seven_segment PORT MAP(DATA(3 DOWNTO 0),dump2);
	SEVEN_SEG3 : seven_segment PORT MAP(DATA(7 DOWNTO 4),dump3); 
	SEVEN_SEG4 : seven_segment PORT MAP(Q(3 DOWNTO 0),dump4); 
	SEVEN_SEG5 : seven_segment PORT MAP(Q(7 DOWNTO 4),dump5);
	SEVEN_SEG6 : seven_segment PORT MAP("0000",dump6);
	SEVEN_SEG7 : seven_segment PORT MAP("0000",dump7);

END ARCHITECTURE;