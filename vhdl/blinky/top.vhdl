library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top is
	port (
		clk50: in  std_logic;
		led0:  out std_logic
	);
end;

architecture Behavioral of top is
	signal counter: std_logic_vector(25 downto 0);
begin
	process(clk50)
	begin
		if rising_edge(clk50) then
			counter <= counter + 1;
			led0 <= counter(25);
		end if;
	end process;
end;