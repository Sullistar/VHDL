library ieee;
use ieee.std_logic_1164.all;

entity cont_tb is
end entity;


architecture cont_tb_arc of cont_tb is
       
		component sa is
       port (  clk, rst: in  std_logic;
		      clk_divided : out std_logic;
		      red : out std_logic_vector(15 downto 0);
	        green : out std_logic_vector(7 downto 0);
	        RL :in std_logic_vector(1 downto 0));
	    end component sa ;
	
	signal   correct :  std_logic ;   -- checking sounds
	signal   correct2 :  std_logic ;  -- checking lights
	signal   correct3 :  std_logic;  -- checking all 
	signal   RL :  std_logic_vector(1 downto 0);
	signal   LR :  std_logic_vector(1 downto 0);
	signal   red : std_logic_vector(15 downto 0);
	signal   green :  std_logic_vector(7 downto 0);
	signal   clk :  std_logic;
	signal   rst :  std_logic;
    signal   div :  std_logic;
    constant t0 : time := 10 ns;     -- half round time
	constant t : time := 20 ns;    -- round time
	
		
begin
DUT : sa
	 port map (clk         => clk ,
               rst         => rst  ,
			   clk_divided => div ,
			   RL          => RL ,
			   green       => green ,
			   red         => red );
	
	
SDU :process is              ----external clock
	begin
	clk <= '0';
	  	  wait for t0 ;
		  clk <= '1';
		  wait for t0 ;
	end process ;
	
-------------------------------------------------------	
	process is             
	begin
	rst <= '0' ;
	wait for 1600000*t ;
	rst <= '1' ;
	wait ;
	end process ;
	
	process is 
	begin
	RL <= "00" ;
	wait for 400000*t ;
	RL <= "01" ;
	wait for 400000*t ;
	RL <= "10" ;
	wait for 400000*t ;
	RL <= "11" ;
	wait for 400000*t ;
	end process ;
	
----------------------------------------------------	
	
CHK :process is                              -- checking sounds
		variable cnt : integer;
	begin
	correct <= '1' ;
	
	wait for t ;

    
	  -- while rst = '0' loop
	  for l in 1 to 1600000 loop     
			if div /= '0' then 
			 correct <= '0' ;
			end if ;
		    wait for t ;
			correct <= '1';
	  end loop ;
	  
	   cnt := 0;
	   while RL ="00" loop
		wait until rising_edge(div);
			cnt := cnt +1;
		wait until falling_edge(div);
		end loop;
		if cnt /= 5 then
			 correct <= '0' ;
			 wait for 5 ps;
			 correct <= '1' ;
		end if;
		
			
	   -- for l in 1 to 5 loop     
			-- for k in 1 to 40000 loop     
			-- if div /= '0' then 
			 -- correct <= '0' ;
			-- end if ;
		    -- wait for t ;
			-- correct <= '1';
	        -- end loop ;
			
			-- for k in 1 to 40000 loop     
			-- if div /= '1' then 
		    -- correct <= '0' ;
			-- end if ;
		    -- wait for t ;
			-- correct <= '1';
	        -- end loop ;
			
				
	  -- end loop ;
		
   cnt := 0;
	   while RL ="01" loop
		wait until rising_edge(div);
			cnt := cnt +1;
		wait until falling_edge(div);
		end loop;
		if cnt /= 10 then
			 correct <= '0' ;
			 wait for 5 ps;
			 correct <= '1' ;
		end if;		
			
	   -- for l in 1 to 10 loop     
				              
			-- for k in 1 to 20 loop     
			-- if div /= '0' then 
			 -- correct <= '0' ;
			-- end if ;
		    -- wait for t ;
			-- correct <= '1';
	        -- end loop ;
			
			-- for k in 1 to 20 loop     
			-- if div /= '1' then 
		    -- correct <= '0' ;
			-- end if ;
		    -- wait for t ;
			-- correct <= '1';
	        -- end loop ;
			
				
	  -- end loop ;

		   cnt := 0;
	   while RL ="10" loop
		wait until rising_edge(div);
			cnt := cnt +1;
		wait until falling_edge(div);
		end loop;
		if cnt /= 20 then
			 correct <= '0' ;
			 wait for 5 ps;
			 correct <= '1' ;
		end if;
	  
	   -- for l in 1 to 20 loop     
				              
			-- for k in 1 to 10 loop     
			-- if div /= '0' then 
			 -- correct <= '0' ;
			-- end if ;
		    -- wait for t ;
			-- correct <= '1';
	        -- end loop ;
			
			-- for k in 1 to 10 loop     
			-- if div /= '1' then 
		    -- correct <= '0' ;
			-- end if ;
		    -- wait for t ;
			-- correct <= '1';
	        -- end loop ;
			
				
	  -- end loop ;
	  
	  
	   while RL ="11" loop
	   
		wait until falling_edge(clk);
		if div /= '0' then
			 correct <= '0' ;
			 wait for 5 ps;
			 correct <= '1' ;
		end if;
		end loop;
	  
	end process;
	--------------------------------------
	
	process is              
	begin
	wait for 5ps;
	LR <= RL ;
	wait ;
	end process ;
	
	
	process (clk , rst , RL) is     --- checking lights
	begin
	
	
	if falling_edge(clk) then
	correct2 <= '1' ;
	if LR = RL then
	
	  if (rst = '0') then
		  if  ((red /= "0000000000000000") OR (green /= "00000000")) then
		    	correct2 <= '0' ;
		   end if;
	  else
	  
	  
	    if (RL ="01") AND ((red /= "1110011100111001") OR (green /= "11001110")) then
	    correct2 <= '0' ;
	  
	    elsif (RL ="10") AND ((red /= "1111000011110000") OR (green /= "11110000")) then
	    correct2 <= '0' ;
	  
	    elsif (RL ="00") AND ((red /= "1111111111111111") OR (green /= "11111111")) then
	    correct2 <= '0' ;
	  
	    elsif (RL ="11") AND ((red /= "0000000000000000") OR (green /= "00000000")) then
	    correct2 <= '0' ;
	    end if ;
	  end if;
	end if;
	end if ;
	  LR <= RL ;
	  
	end process;
	
	
	correct3 <= (correct AND correct2) ;
	
	
	assert correct3 = '1' 
	  report "There is an ERROR..." severity ERROR;
	
	end architecture ;
	
	
		