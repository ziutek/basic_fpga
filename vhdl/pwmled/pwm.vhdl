library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

entity PWM is
	generic (
		pwmBits:   integer;
		clkCntLen: positive := 1
	);
	port (
		clk:       in  std_logic;
		dutyCycle: in  unsigned(pwmBits-1 downto 0);
		pwmOut:    out std_logic
	);
end entity;

architecture rtl of PWM is
	signal pwmCnt: unsigned(pwmBits-1 downto 0);
	signal clkCnt: integer range 0 to clkCntLen-1;
begin
	ClkCntProc:
	process(clk) begin if rising_edge(clk) then
		if clkCnt = clkCntLen-1 then
			clkCnt <= 0;
		else
			clkCnt <= clkCnt + 1;
		end if;
	end if; end process;

	PWMProc:
	process(clk) begin if rising_edge(clk) then
		if clkCntLen=1 or clkCnt=0 then
			pwmCnt <= pwmCnt + 1;
			pwmOut <= '0';
			if pwmCnt = unsigned(to_signed(-2, pwmCnt'length)) then
				pwmCnt <= unsigned(0);
			end if;
			if pwmCnt < dutyCycle then
				pwmOut <= '1';
			end if;
		end if;
	end if; end process;
end architecture;