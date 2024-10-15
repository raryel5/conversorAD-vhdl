library ieee;
use ieee.std_logic_1164.all;

entity conversor is

	port
	(
		CS, SCLK, Dout : out std_logic;
		Din : in std_logic;
		clk		 : in	std_logic;
		reset	 : in	std_logic;
		output	 : out	std_logic_vector(0 to 11)
	);

end conversor;

architecture logic of conversor is

	type state_type is (start, s_d, d2, d1, d0, bn1, bn2, b11, b10, b09, b08, b07, b06, b05, b04, b03, b02, b01, b00, saida);
	signal state : state_type;
	signal leds : std_logic_vector (0 to 11) ;
	signal clk2 : std_logic;
begin

	
	
	process (clk)
	variable cnt :integer :=0;
	begin
	if (rising_edge(clk)) then
	cnt := cnt + 1;

	
	if(cnt = 24) then
	clk2 <= '0';
	
	elsif(cnt = 49) then
	clk2 <= '1';
	cnt := 0;
	end if;	
	end if;
	
	end process;
	
	sclK <= clk2;
	
	process (clk2, reset)
	begin

		if reset = '1' then
			state <= start;

		elsif (falling_edge(clk2)) then
			case state is 
				when start=>
					Dout <= '1';
					cs <= '0';
					state <= s_d;
					
				when s_d=>
					cs <= '0';
					Dout <= '1';
					state <= d2;
				when d2=>
					cs <= '0';
					Dout <= '0';
					state <= d1;
				when d1=>
					cs <= '0';
					Dout <= '0';
					state <= d0;
					
				when d0=>
					cs <= '0';
					Dout <= '0';
					state <= bn1;
					
				when bn1=>
					cs <= '0';
					state <= bn2;
					
				when bn2=>
					cs <= '0';
					state <= b11;
					
				when b11=>
					cs <= '0';
					leds(11)<= din;
					state <= b10;
				
				when b10=>
					cs <= '0';
					leds(10)<= din;
					state <= b09;
					
				when b09=>
					cs <= '0';
					leds(9)<= din;
					state <= b08;
					
				when b08=>
					cs <= '0';
					leds(8)<= din;
					state <= b07;
					
				when b07=>
					cs <= '0';
					leds(7)<= din;
					state <= b06;
					
				when b06=>
					cs <= '0';
					leds(6)<= din;
					state <= b05;
					
				when b05=>
					cs <= '0';
					leds(5)<= din;
					state <= b04;
					
				when b04=>
					cs <= '0';
					leds(4)<= din;
					state <= b03;
					
				when b03=>
					cs <= '0';
					leds(3)<= din;
					state <= b02;
					
				when b02=>
					cs <= '0';
					leds(2)<= din;
					state <= b01;
					
				when b01=>
					cs <= '0';
					leds(1)<= din;
					state <= b00;
					
				when b00=>
					cs <= '0';
					leds(0)<= din;
					state <= saida;
					
				when saida =>
					cs <= '1';
					output <= leds;
					state <= start;
					
			end case;

		end if;
	end process;

end logic;