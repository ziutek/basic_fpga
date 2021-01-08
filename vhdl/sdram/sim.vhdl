entity SDRAMSim is
	generic (
		addrBits : positive := 24;
		bankBits : positive := 2;
		dataBits : positive := 16
	);
begin
	assert addrBits >= dataBits;
end entity;

architecture sim of SDRAMSim is
	signal clock, rd, wr, busy  : bit;
	signal addr                 : bit_vector(addrBits-1 downto 0);
	signal din                  : bit_vector(dataBits-1 downto 0);
	signal dout                 : bit_vector(dataBits-1 downto 0);
begin
	ctrl : entity work.SDRAMC
		generic map (
			addrBits => addrBits,
			bankBits => bankBits,
			dataBits => dataBits
		) port map (
			clock => clock,
			addr  => addr,
			din   => din,
			dout  => dout,
			rd    => rd,
			wr    => wr,
			busy  => busy
		);

	process	begin
		for i in 1 to 30 loop
			clock <= '0';
			wait for 1 ns;
			clock <= '1';
			wait for 1 ns;
		end loop;
		wait;
	end process;

end;