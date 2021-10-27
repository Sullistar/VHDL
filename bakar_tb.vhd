library ieee;
use ieee.std_logic_1164.all;

entity bakar_tb is
end entity;

architecture bakar_arc of bakar_tb is

component bakar is
	port(   
	     CLK : in std_logic;
	     x   : in std_logic_vector  (1 downto 0);
	     fr  : out std_logic_vector (1 downto 0);
	     fl  : out std_logic_vector (1 downto 0);
	     br  : out std_logic_vector (1 downto 0);
	     bl  : out std_logic_vector (1 downto 0)
	     );
end component bakar;

    signal correct     : bit ;
    signal  x: std_logic_vector (1 downto 0);
    signal fr: std_logic_vector (1 downto 0);
    signal fl: std_logic_vector (1 downto 0);
    signal br: std_logic_vector (1 downto 0);
    signal bl: std_logic_vector (1 downto 0);
    signal clk : std_logic;
    constant t0 : time := 10 ns ;

begin

DUT : bakar
	
	 port map (
			  CLK    =>clk,
			  x       => x,
			  fr       => fr,
			  fl       => fl,
			  br       => br,
			  bl       => bl  );
SDU : process is 
	begin 
		clk <='0';
		wait for t0 ;
		clk<='1';
		wait for t0 ;
	end process ;

	process is 
		begin 
		x<="00";
		wait for 2 ns ;
		x<="01" ;
		wait for 2 ns ;
		x<="10";
		wait for 2 ns ;
		x<="11";
		wait for 2 ns ;
	end process ; 

CHK  : process is
  begin
	 correct <='1';
wait until falling_edge (clk) ;
		if To_x01(x) = "00" then
		
		    if ( br /= "10" )or( bl /= "10" )or( fr /= "10" )or( fl /= "10" ) then 
		         correct <= '0' ;
			end if; 
		     
		elsif To_x01(x) = "01" then   
		     
		    if ( br /= "01" )or( bl /= "01" )or( fr /= "01" )or( fl /= "01" ) then 
		         correct <= '0' ;
		    end if;

		elsif To_x01(x) = "10" then  
		   
		    if ( br /= "10" )or( bl /= "01" )or( fr /= "10" )or( fl /= "01" ) then 
		         correct <= '0' ;
		    end if;	
		else	    
		    if ( br /= "00" )or( bl /= "00" )or( fr /= "00" )or( fl /= "00" ) then 
		         correct <= '0' ;
			end if;			
	  end if;

end process;


end architecture bakar_arc;