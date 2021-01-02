library ieee;
use ieee.numeric_bit.all;

entity PWM is
	generic (
		pwmBits : integer
	);
	port (
		clk    : in  bit;
		duty   : in  unsigned(pwmBits-1 downto 0);
		pwmOut : out bit
	);
end;

architecture rtl of PWM is
	signal cnt : unsigned(pwmBits-1 downto 0);
begin
	process begin wait until rising_edge(clk);
		cnt <= cnt + 1;
		if cnt < duty then
			pwmOut <= '1';
		else
			pwmOut <= '0';
		end if;
	end process;
end;