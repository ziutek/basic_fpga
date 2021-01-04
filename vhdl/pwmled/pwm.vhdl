library ieee;
use ieee.numeric_bit.all;

entity PWM is
	port (
		clk    : in  bit;
		duty   : in  unsigned;
		pwmOut : out bit
	);
end;

architecture default of PWM is
	signal cnt : unsigned(duty'left downto duty'right);
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

architecture closed of PWM is
	signal cnt : unsigned(duty'left downto duty'right);
begin
	process begin wait until rising_edge(clk);
		if cnt = unsigned(to_signed(-2, cnt'length)) then
			cnt <= (others => '0');
		else
			cnt <= cnt + 1;
		end if;
		if cnt < duty then
			pwmOut <= '1';
		else
			pwmOut <= '0';
		end if;
		--pwmOut <= bit'val(boolean'pos(cnt < duty));
	end process;
end;