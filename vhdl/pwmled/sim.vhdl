library ieee;
use ieee.numeric_bit.all;

entity PWMLEDSim is
end;

architecture sim of PWMLEDSim is
	constant pwmBits : positive := 2;
	constant cntBits : positive := 4;

	signal clk, led0, led1 : bit;
begin
	dut : entity work.PWMLED(default)
		generic map (pwmBits => pwmBits, cntBits => cntBits)
		port map (clk50 => clk, led0 => led0, led1 => led1);

	process begin
		for i in 1 to 2 * 2**(pwmBits + cntBits) loop
			clk <= '0';
			wait for 1 ms;
			clk <= '1';
			wait for 1 ms;
		end loop;
		wait;
	end process;
end;