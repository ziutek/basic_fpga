library ieee;
use ieee.numeric_bit.all;

entity Counter is
	port(
		clock : in  bit;
		reset : in  bit;
		count : out natural
	);
end;

architecture default of Counter is
	signal cnt : natural;
begin
	process begin wait until rising_edge(clock);
		if reset = '1' then
			cnt <= 0;
		else
			cnt <= cnt + 1;
		end if;
	end process;

	count <= cnt;
end;