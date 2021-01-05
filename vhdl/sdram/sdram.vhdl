-- Simple controller for 16-bit SDRAM

type Command is record
	WEn, CASn, RASn, CSn std_ulogic
end record;

entity Controller is
	port (
		-- Interface
		clock : in  bit;                     -- clock
		addr  : in  bit_vector(23 downto 0); -- address of 16-bit word
		din   : in  bit_vector(15 downto 0); -- data to write to SDRAM
		dout  : out bit_vector(15 downto 0); -- data to read from SDRAM
		rd    : in  bit;                     -- start read transaction
		wr    : in  bit;                     -- start write transaction
		busy  : out bit;                     -- busy signal

		-- SDRAM signals
		CLK : out   bit;                    -- clock
		CKE : out   bit;                    -- clock enable
		CMD : out   Command;                -- 4-bit command
		BA  : out   bit_vector(1 downto 0)  -- bank address
		A   : out   bit_vector(1 downto 0)  -- address
		D   : inout std_ulogic(15 downto 0) -- data
	)
end;

architecture default of Controller is
end;