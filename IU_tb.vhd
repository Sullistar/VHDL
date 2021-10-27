library ieee;
use ieee.std_logic_1164.all;

entity IU_tb is
end entity;





architecture IU_tb_arc of IU_tb is


component IU is
       port (switch, restN, fanD_switch :in std_logic; 
		 mov : in std_logic_vector (1 downto 0);
		 itinerary : out std_logic_vector (1 downto 0);
		 fanD_out : out std_logic
		);
	    end component IU ;

signal   correct :  std_logic;
signal   correct1 :  std_logic;  --path
signal   correct2 :  std_logic;  --fan
signal   rst :  std_logic;
signal   fan_in :  std_logic;
signal   fan_out :  std_logic; 
signal   switch :  std_logic;
signal   path_in :  std_logic_vector (1 downto 0);
signal   path_out :  std_logic_vector (1 downto 0);

begin 
DUT : IU
     port map (switch      => switch ,
	           restN       => rst ,
			   fanD_switch => fan_in ,
			   fanD_out    => fan_out ,
			   mov         => path_in,
			   itinerary   => path_out );


SDU : process is               -- הכנסת reset / switch
     begin
	 
	 switch <= '0' ;
	 rst <= '0' ;
	 wait for 4000 ns ;
	 
	 switch <= '0' ;
	 rst <= '1' ;
	 wait for 4000 ns ;
	 
	 switch <= '1' ;
	 rst <= '0' ;
	 wait for 4000 ns ;
	 
	 switch <= '1' ;
	 rst <= '1' ;
	 wait for 4000 ns ;
	 
	 end process;
	 
	 process is                   ---- הכנסת המניפה
     begin
	 
	 fan_in <= '0' ;
	 wait for 500 ns ;
	 fan_in <= '1' ;
	 wait for 500 ns ;
	 
	 
	 end process;
	 
	 process is                   ---- הכנסת סוג מסלול
     begin
	 
	 path_in <= "00" ;
	 wait for 1000 ns ;
	 path_in <= "01" ;
	 wait for 1000 ns ;
	 path_in <= "10" ;
	 wait for 1000 ns ;
	 path_in <= "11" ;
	 wait for 1000 ns ;
	 
	 end process;
	 
---------------------------------------------------------------------------
-- CHK : process (rst , switch , fan_in , fan_out )               ---- בדיקת מניפה
      
      -- begin
	  -- correct1 <= '1' ;
	  -- if (rst = '0' OR switch = '0' ) AND fan_out /= '0' then
	    -- correct1 <= '0' ;
	  -- else
	    -- if fan_out /= fan_in then
		-- correct1 <= '0' ;
		-- end if ;
	  -- end if ;
	  
	  -- end process ;
	  
 -- process (rst , switch , path_in , path_out )               ---- בדיקת path
     
      -- begin
	   -- correct2 <= '1' ;
	  -- if (rst = '0' OR switch = '0' ) AND path_out /= "11" then
	    -- correct2 <= '0' ;
	  -- else
	    -- if path_out /= path_in then
		-- correct2 <= '0' ;
		-- end if ;
	  -- end if ;
	  
	  -- end process ;
	 
	 CHK : process is                          ------ בדיקת path
	 begin
	 correct1 <= '1' ;
	 wait for 10 ns;
	      for l in 1 to 1198 loop
	       if path_out /= "11" then
	        correct1 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			
			wait for 20 ns ;
			
			for l in 1 to 98 loop
	       if path_out /= "00" then
	        correct1 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			for l in 1 to 98 loop
	       if path_out /= "01" then
	        correct1 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			for l in 1 to 98 loop
	       if path_out /= "10" then
	        correct1 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			for l in 1 to 98 loop
	       if path_out /= "11" then
	        correct1 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			
			
	       end process ;
		   
	 process is
	 begin
	 correct2 <= '1' ;
	 wait for 10 ns;
	      for l in 1 to 1198 loop--
	       if fan_out /= '0' then
	        correct2 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			
			wait for 20 ns ;
			
			for l in 1 to 48 loop--
	       if fan_out /= '0' then
	        correct2 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			for l in 1 to 48 loop
	       if fan_out /= '1' then--
	        correct2 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			for l in 1 to 48 loop
	       if fan_out /= '0' then--
	        correct2 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			for l in 1 to 48 loop--
	       if fan_out /= '1' then
	        correct2 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			 for l in 1 to 48 loop
	       if fan_out /= '0' then--
	        correct2 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			
			wait for 20 ns ;
			
			for l in 1 to 48 loop
	       if fan_out /= '1' then
	        correct2 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			for l in 1 to 48 loop
	       if fan_out /= '0' then
	        correct2 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			for l in 1 to 48 loop
	       if fan_out /= '1' then
	        correct2 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			for l in 1 to 48 loop
	       if fan_out /= '0' then
	        correct2 <= '0' ;
			end if ;
			wait for 10 ns ;
			end loop ;
			wait for 20 ns ;
			
			
			
	       end process ;
	 
	  
	  
	  

correct <= correct1 AND correct2 ;
assert correct = '1' 
	  report "There is an ERROR..." severity ERROR;
end architecture ;