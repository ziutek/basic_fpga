library ieee;
use ieee.numeric_bit.all;

package subadd is
	type Input is record
		a, b : unsigned(7 downto 0);
	end record;

	type Output is record
		d, s : unsigned(7 downto 0);
	end record;

	component C is
		port (
			clk : in  bit;
			i   : in  subadd.Input;
			o   : out subadd.Output
		);
	end component;
end package;

library ieee;
use ieee.numeric_bit.all;
use work.subadd;

entity subaddEntity is
	port (
		clk : in  bit;
		i   : in  subadd.Input;
		o   : out subadd.Output
	);
end;

architecture default of subaddEntity is
begin
	process begin wait until rising_edge(clk);
		o.d <= i.a - i.b;
		o.s <= i.a + i.b;
	end process;
end;
