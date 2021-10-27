library ieee;
use ieee.std_logic_1164.all;

entity final is
	port (clk, rest, switch, fan_di : in  std_logic;
	      movement : in  std_logic_vector (1 downto 0);
		  green_led : out std_logic_vector (7 downto 0);
		  red_led : out std_logic_vector (15 downto 0);
		  clk_divided : out std_logic;
		  -- speaker : out std_logic;
		   fan : out std_logic_vector (1 downto 0);
		   fr  : out std_logic_vector (1 downto 0);
	      fl  : out std_logic_vector (1 downto 0);
	      br  : out std_logic_vector (1 downto 0);
	      bl  : out std_logic_vector (1 downto 0)
		  );
end entity final;

architecture final_arch of final is 

signal fan_sig :  std_logic;
signal path, mov_sig    :  std_logic_vector (1 downto 0);


component IU 
port   (switch, restN, fanD_switch :in std_logic; 
		 mov : in std_logic_vector (1 downto 0);
		 itinerary : out std_logic_vector (1 downto 0);
		 fanD_out : out std_logic
		);
		end component;
		
		component OG 
	port ( IU : in std_logic_vector (1 downto 0);
		 clk : in std_logic;
		 motion : out std_logic_vector (1 downto 0)
		);
		end component;
		
		component bakar 
port(CLK : in std_logic;
	     x   : in std_logic_vector (1 downto 0);
	     fr  : out std_logic_vector (1 downto 0);
	     fl  : out std_logic_vector (1 downto 0);
	     br  : out std_logic_vector (1 downto 0);
	     bl  : out std_logic_vector (1 downto 0));
		end component;
		
		component sa
	port (    clk, rst: in  std_logic;
		      clk_divided : out std_logic;
		      red : out std_logic_vector(15 downto 0);
	          green : out std_logic_vector(7 downto 0);
	          RL :in std_logic_vector(1 downto 0));
		end component;
		
		
		component fan_engine 
port (clk, rst, rl : in    std_logic;
      onoff        : in    std_logic_vector (1 downto 0);
      fan_vel      : out std_logic_vector (1 downto 0)
);
		end component;
		
begin

u1 :  IU port map (switch => switch, restN => rest , mov => movement,  fanD_switch => fan_di, itinerary => path , fanD_out => fan_sig);
u2 : OG port map (clk => clk, IU => path, motion => mov_sig);
u3 : bakar port map (clk => clk, x => mov_sig, fr => fr, fl => fl, br => br, bl => bl);
u4 : sa port map (clk => clk, RL => path, rst => rest, clk_divided => clk_divided, red => red_led , green => green_led  );
u5 : fan_engine port map (clk => clk , rl => fan_sig, rst => rest, onoff => path ,  fan_vel => fan);

end;