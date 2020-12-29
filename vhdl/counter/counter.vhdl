entity Counter is
	port(
		clock: in  bit;
		reset: in  bit;
		count: out natural
	);
end entity;

architecture sync of Counter is
	signal cnt: natural;
begin
	process(clock) begin if rising_edge(clock) then
		if reset then
			count <= 0;
		else
			count <= count + 1;
		end if;
	end if; end process;
end architecture;