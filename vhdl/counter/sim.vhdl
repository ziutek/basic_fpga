library ieee;
use ieee.numeric_bit.all;

entity CounterSim is
end entity;

architecture sim of CounterSim is
	signal clk:  bit;
	signal rst:  bit;
	signal data: natural;
	signal eos:  boolean;
begin
	-- Instantiation of the DUT
	dut: entity work.Counter(default)
		port map(
			clock => clk,
			reset => rst,
			count => data
		);

	-- A clock generating process with a 2ns clock period.
	-- Infinite loop, the clock will never stop toggling.
	process	begin
		for i in 1 to 30 loop
			clk <= '0';
			wait for 1 ns;
			clk <= '1';
			wait for 1 ns;
		end loop;
		wait;
	end process;

	-- The process that handles the reset: active
	-- until the 5th rising edge of the clock.
	process begin
		rst  <= '1';
		for i in 1 to 5 loop
 			wait until rising_edge(clk);
		end loop;
		rst  <= '0';
		loop
			wait until rising_edge(clk);
		end loop;
	end process;
end architecture;