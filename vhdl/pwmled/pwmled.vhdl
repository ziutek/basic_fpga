library ieee;
use ieee.numeric_bit.all;

entity PWMLED is
	generic (
		pwmBits : positive := 12;
		cntBits : positive := 17
	);
	port (
		clk50      : in  bit;
		led0, led1 : out bit
	);
end;

architecture default of PWMLED is
	signal cnt : unsigned(cntBits+pwmBits-1 downto 0);
begin
	assert cntBits >= pwmBits;

	pwm : entity work.PWM(closed)
		port map (clk50, cnt(cnt'high downto cntBits), led0);

	process begin wait until rising_edge(clk50);
		cnt <= cnt + 1;
		led1 <= cnt(cnt'high-1);
	end process;
end;
