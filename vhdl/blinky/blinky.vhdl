library ieee;
use ieee.numeric_bit.all;

entity Blinky is
	port (
		clk50      : in  bit;
		led0, led1 : out bit
	);
end;

architecture default of Blinky is
	signal cnt : unsigned(25 downto 0);
begin
	process begin wait until rising_edge(clk50);
		cnt <= cnt + 1;
		led0 <= cnt(cnt'high-1);
		led1 <= cnt(cnt'high);
	end process;
end;
