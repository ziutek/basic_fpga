library ieee;
use ieee.numeric_bit.all;
use work.subadd;

entity SubAddSim is
end;

architecture default of SubAddSim is
	signal clk        : bit;
	signal a, b, d, s : unsigned(7 downto 0);
begin
	process	begin
		for i in 1 to 30 loop
			clk <= '0';
			wait for 1 ns;
			clk <= '1';
			wait for 1 ns;
		end loop;
		wait;
	end process;

	dut : subadd.C
		port map (
			clk => clk,
			i.a   => a,
			i.b   => b,
			o.d   => d,
			o.s   => s
		);

	process begin wait until rising_edge(clk);
		a <= a + 1;
		b <= b + 2;
	end process;
end;

configuration cfg1 of all is
	for sim
		for all : subadd.C
			use entity work.subaddEntity(default);
		end for;
	end for;
end;