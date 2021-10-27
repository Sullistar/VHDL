library ieee;
use ieee.std_logic_1164.all;

entity route_tb is
end entity;





architecture route_tb_arc of route_tb is
       
		component OG is
        port (IU : in std_logic_vector (1 downto 0);
		      clk  : in std_logic;
			  motion : out std_logic_vector (1 downto 0)	);
			  
	    end component OG ;



	   signal   correct :  std_logic;
		signal   clk0 :  std_logic;
		signal   dir :  std_logic_vector (1 downto 0); -- הכיוון המחולל מוציא
		signal   rot :  std_logic_vector (1 downto 0); -- סוג המסלול שהמחולל מקבל
		constant t : time := 10 ns;     -- חצי זמן מחזור חיצוני
		constant t0 : time := 20 ns;    -- זמן מחזור מהיר
	    
		-- constant n : natural := 2000000 ;
		constant n : integer  := 1;
		
		
    	-- constant tfb : time := 2400 ms;   -- forward/backwards time
     	-- constant numf : natural := 20*n ;    -- מספר מחזורים בהתקדמות
		-- constant nums : natural := 10*n ;    -- מספר מחזורים בעצירה
		-- constant numb : natural := 20*n ;   -- מספר מחזורים בחזרה
		
		-- constant tsq : time := 9600 ms;   -- sqaure time
		-- constant nf : natural := 20*n ;      -- מספר מחזורים בהתקדמות
		-- constant nl : natural := 40*n ;       -- מספר מחזורי פנייה שמאלה
		
		-- constant tc : time := 3200 ms;    -- circle time 
		-- constant nc : natural := 80*n ;
		
		-- constant ts : time := 800 ms;    -- stop time 
		-- constant ns : natural := 20*n ;
		
		
		constant tfb : time := 1200 ns;   -- forward/backwards time
     	constant numf : natural := 20*n ;    -- מספר מחזורים בהתקדמות
		constant nums : natural := 10*n ;    -- מספר מחזורים בעצירה
		constant numb : natural := 20*n ;   -- מספר מחזורים בחזרה
		
		constant tsq : time := 4800 ns;   -- sqaure time
		constant nf : natural := 20*n ;      -- מספר מחזורים בהתקדמות
		constant nl : natural := 40*n ;       -- מספר מחזורי פנייה שמאלה
		
		constant tc : time := 1600 ns;    -- circle time 
		constant nc : natural := 80*n ;
		
		constant ts : time := 400 ns;    -- stop time 
		constant ns : natural := 20*n ;
		
		
		
	
		






begin
DUT : OG 
     port map (
               clk      => clk0 ,
               IU       => rot  ,
			   motion   => dir   );







SDU  : process is
                 --הגדרת שעון כניסה
	    begin
	  	  clk0 <= '0';
	  	  wait for t ;
		  clk0 <= '1';
		  wait for t ;
	end process ;
	
		
	process is
        begin
			--  wait for t0;             
			  -- for k in 0 to 3 loop
			    -- case k is
					-- when 0 =>
						rot <= "00";	--forward/backwards	
					    wait for 2*(tfb+t0) ; 
					--when 1 =>
						rot <= "01";	--sqaure	
					    wait for 2*(tsq+t0) ;
					--when 2 =>
						rot <= "10";	--circle	
					    wait for tc ;
					--when 3 =>
						rot <= "11";	--stop	
			            wait for ts ;
			--end case;
          --  end loop ;   
	end process ;
	
	

	
    
	
CHK : process is
        begin
		
		Correct <= '1';
		wait for t0 ; 
		--case rot is
					
				for k in 1 to 2 loop
					--when "00" =>		----------------------------forward/backwards
					
					if rot="00" then
      					for l in 1 to numf loop     -- foward
						  if dir /= "00" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ; 
						  correct <= '1' ;
						end loop ;

						
						
						for l in 1 to nums loop     --stop
						  if dir /= "11" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ;
						  correct <= '1' ;
						end loop ;
						
           
						
					    for l in 1 to numb loop     -- backwards
						  if dir /= "01" then     
						     correct <= '0' ;
						  end if ;
						  wait for t0 ; 
						  correct <= '1' ;
						end loop ;
						
					
						for l in 1 to nums loop  -- stop   
						  if dir /= "11" then 
						     correct <= '0' ;
						  end if ;
						  
						  
						  wait for t0 ;
						  correct <= '1' ;
						end loop ;
						
						wait for t0 ;
				    end if ;	
				end loop ;	  
					
						
-----------------------------------------------------------------------------------------------						  
					
					for k in 1 to 2 loop
					
					--when "01"  =>    ----------------------------------------- sqaure
					  if rot="01" then
					
					   
					    for l in 1 to nf loop     -- foward
						  if dir /= "00" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ; 
						  Correct <= '1';
						end loop ;
					
					     for l in 1 to nl loop     -- turn left
						  if dir /= "10" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ;
                          Correct <= '1';
						end loop ;
						
						 for l in 1 to nf loop     -- foward
						  if dir /= "00" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ; 
						  Correct <= '1';
						end loop ;
					
					     for l in 1 to nl loop     -- turn left
						  if dir /= "10" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ;
                          Correct <= '1';
						end loop ;
						
					
					
					
					 for l in 1 to nf loop     -- foward
						  if dir /= "00" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ; 
						  Correct <= '1';
						end loop ;
					
					     for l in 1 to nl loop     -- turn left
						  if dir /= "10" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ;
                          Correct <= '1';
						end loop ;
						
						 for l in 1 to nf loop     -- foward
						  if dir /= "00" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ; 
						  Correct <= '1';
						end loop ;
					
					     for l in 1 to nl loop     -- turn left
						  if dir /= "10" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ;
                          Correct <= '1';
						end loop ;
						
					
					end if ;
					wait for t0 ;
					end loop ;
					
					
------------------------------------------------------------------------------------------------------
				--	when "10" => ------------------------------------------------------circle
					if rot="10" then
					   for l in 1 to nc loop     -- turn left
						  if dir /= "10" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ;
                          Correct <= '1';						  
						end loop ;
						
					end if ;	
						


------------------------------------------------------------------------------------------------------------
				--when "11" =>  ------------------------------------------------------ --stop
					   
					if rot="11" then
					 Correct <= '1';
						for l in 1 to ns loop     --stop
						  if dir /= "11" then 
						     correct <= '0' ;
						  end if ;
						  wait for t0 ;        
						end loop ;
				--	end case ;   
				 end if ;
end process CHK;



assert Correct = '1' 
	  report "There is an ERROR..." severity ERROR;

end architecture route_tb_arc;