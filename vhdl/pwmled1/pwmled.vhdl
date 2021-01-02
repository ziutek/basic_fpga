library ieee;
use ieee.numeric_bit.all;

entity PWMLED is
	generic (
		pwmBits : integer := 16;
		cntBits : integer := 12
	);
	port (
		clk50      : in  bit;
		led0, led1 : out bit
	);
end;

architecture rtl of PWMLED is
	signal cnt : unsigned(cntBits+pwmBits-1 downto 0);
begin
	pwm : entity work.PWM(rtl)
		generic map (pwmBits)
		port map (clk50, cnt(cnt'high downto cntBits), led0);

	process begin wait until rising_edge(clk50);
		cnt <= cnt + 1;
		led1 <= cnt(26);
	end process;
end;
