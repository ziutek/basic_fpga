library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

entity PWMLED is
	generic (
		pwmBits:   integer  := 9;
		cntBits:   integer  := 26;
		clkCntLen: positive := 100
	);
	port (
		clk50:      in  std_logic;
		led0, led1: out std_logic
	);
end entity;

architecture str of PWMLED is
	signal cnt:    unsigned(cntBits - 1 downto 0);
	signal pwmOut: std_logic;

	alias dutyCycle is cnt(cnt'high downto cnt'length - pwmBits);
begin
	led0 <= pwmOut;
	led1 <= '1';

	PWM: entity work.PWM(rtl)
	generic map (
		pwmBits   => pwmBits,
		clkCntLen => clkCntLen
	)
	port map (
		clk       => clk50,
		dutyCycle => dutyCycle,
		pwmOut    => pwmOut
	);

	Modulate:
	process (clk50) begin if rising_edge(clk50) then
			cnt <= cnt + 1;
	end if; end process;
end architecture;
