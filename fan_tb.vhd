library IEEE;
use IEEE.std_logic_1164.all;

entity fan_tb is
end entity ;

architecture fan_arc of fan_tb is
component fan_engine is 
port (clk, rst, rl : in    std_logic;
      onoff        : in    std_logic_vector(1 downto 0);
      fan_vel      : inout std_logic_vector (1 downto 0)
);
end component fan_engine ;
signal clk : std_logic;
signal rst : std_logic;
signal rl : std_logic ;
signal onoff : std_logic_vector (1 downto 0);
signal fan_vel : std_logic_vector (1 downto 0);
constant t : time := 20 ns ;
constant t0 : time := 10 ns ;
type state is (v1,v2);
signal st : state ;
signal   correct :  std_logic;
begin 
DUT : fan_engine 
	port map (
			clk=> clk ,
			rst => rst ,
			rl=> rl,
			onoff=>onoff,
			fan_vel=>fan_vel );

SDU : process is --------external clock
begin 
	clk <='0';
	wait for t0 ;
	clk<='1';
	wait for t0 ;
	end process ;

process is 
begin 
	onoff<="11";
	wait for t;
	rst<='0';
	wait for t;
	onoff<="10";
	onoff<="00";
	onoff<="01";
	rst<='1';
	wait ;
end process ;
process is 
begin 
rl<='1';
wait for 50000*t0;
rl<='0';
wait for 50000*t0;
end process ;

CHK : process is 
variable count1 : integer ; ----------counting ones 
variable count2 : integer ; ----------counting zeroes
variable count01 : integer ; ----------counting ones
variable count02 : integer ; ----------counting zeroes
variable count3 : integer ; ----------counting till 0.5 second
variable ans1 : integer ;
variable ans2 : integer ;
	begin
 correct<='1';
wait for t ;
count1 := 0;
count2 := 0;
count01 := 0;
count02 := 0;
count3 :=0;
ans1:=0;
ans2:= 0;
st<=v1;
--------------------------------------------------
  while rl ='1'  loop
	wait until falling_edge (clk) ;
	case st is 
		when v1 =>
		--	wait until falling_edge (clk) ;
			count3 := count3+1;
			if fan_vel(0) <='1' and count3/=25e6 then 
				count1:=count1+1;
			elsif fan_vel (0)<='0' and count3/=25e6 then
				count2:=count2+1;
			end if ;

		--	if count3=25e6  then
		--		st <= v2 ;
		--		count3:=0;
		--------------------------
		--	end if ;

		when v2 =>
		--	wait until falling_edge (clk) ;
			count3 := count3+1;
			if fan_vel(0) <='1' and count3/=25e6 then 
				count01:=count01+1;
			elsif fan_vel (0)<='0' and count3/=25e6 then
				count02:=count02+1;
			end if ;
	end case ;

		if fan_vel(1)<='0' then
			correct <='1';
		else 
			correct<='0';
		end if;


			if count3=25e6  then
			  if st = v1 then
				st <= v2 ;
				count3:=0;
			  else
				ans1:=count1/count2;
				ans2:=count02/count01;
				if ans1/=9 or ans2/=9 then 
					correct <='0';
					wait for 5 ps ;
					correct <='1';
				end if ;
				count1:= 0;
				count2:= 0;
				count01:= 0;
				count02:= 0;
				count3:=0;
				ans1:=0;
				ans2:= 0;
				st <= v1;
				count3 := 0;
			end if ;
			end if ;
  end loop ;
-----------------------------------------------------
while rl ='0'  loop
	wait until falling_edge (clk) ;
	case st is 
		when v1 =>
			--wait until falling_edge (clk) ;
			count3 := count3+1;
			if fan_vel(1) <='1' and count3/=25e6 then 
				count1:=count1+1;
			elsif fan_vel (1)<='0' and count3/=25e6 then
				count2:=count2+1;
			end if ;
			--if count3=25e6  then
			--st <= v2 ;
			--count3:=0;
			--end if ;
		when v2 =>
			--wait until falling_edge (clk) ;
			count3 := count3+1;
			if fan_vel(1) <='1' and count3/=25e6 then 
				count01:=count01+1;
			elsif fan_vel (1)<='0' and count3/=25e6 then
				count02:=count02+1;
			end if ;
	end case ;
		if fan_vel(0)<='0' then
			correct <='1';
		else 
			correct<='0';
		end if ;
	if count3=25e6  then
		if st = v1 then
			st<=v2;
			count3:=0;
		else
			ans1:=count1/count2;
			ans2:=count02/count01;
			if ans1/=9 or ans2/=9 then 
				correct <='0';
				wait for 5 ps ;
				correct <='1';
			end if ;
			count1:= 0;                              
			count2:= 0;
			count01:= 0;
			count02:= 0;
			count3:=0;
			ans1:=0;
			ans2:= 0;
			st<=v1;
		end if ;
	 end if ;
end loop ;
end process ;
end architecture fan_arc ;
