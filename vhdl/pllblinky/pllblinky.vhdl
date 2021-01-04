library ieee;
use ieee.numeric_bit.all;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.PLL_BASE;
use unisim.vcomponents.BUFG;

entity PLLBlinky is
	port (
		clk50      : in  std_ulogic;
		led0, led1 : out bit
	);
end;

architecture default of PLLBlinky is
	signal fb, clk100, sysClk : std_ulogic;

	signal cnt : unsigned(26 downto 0);
begin
	pll : PLL_BASE
		generic map (
			CLKIN_PERIOD   => 20.0, --  50 MHz
			CLKFBOUT_MULT  => 8,    -- 400 MHz
			CLKOUT0_DIVIDE => 4     -- 100 MHz
		)
		port map (
			CLKIN    => clk50,
			CLKFBIN  => fb,
			CLKFBOUT => fb,
			CLKOUT0  => clk100,
			RST      => '0'
		);
	pllBuf : BUFG port map(I => clk100, O => sysClk);

	process begin wait until rising_edge(sysClk);
		cnt <= cnt + 1;
		led0 <= cnt(cnt'high - 1);
		led1 <= cnt(cnt'high);
	end process;
end;
