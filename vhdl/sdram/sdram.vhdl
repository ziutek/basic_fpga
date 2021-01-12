library ieee;
use ieee.std_logic_1164.all;

-- Simple controller for 16-bit SDRAM

entity SDRAMC is
	generic (
		addrBits : positive;
		bankBits : positive;
		dataBits : positive
	);
	port (
		-- Interface
		clock : in  bit;                             -- clock
		addr  : in  bit_vector(addrBits-1 downto 0); -- address of 16-bit word
		din   : in  bit_vector(dataBits-1 downto 0); -- data to write to SDRAM
		dout  : out bit_vector(dataBits-1 downto 0); -- data to read from SDRAM
		rd    : in  bit;                             -- start read transaction
		wr    : in  bit;                             -- start write transaction
		busy  : out bit;                             -- busy signal

		-- SDRAM signals
		CLK  : out   std_ulogic;                             -- clock
		CKE  : out   std_ulogic;                             -- clock enable
		CMD  : out   work.sdram.Command;                     -- 4-bit command
		BA   : out   std_ulogic_vector(bankBits-1 downto 0); -- bank address
		A    : out   std_ulogic_vector(addrBits-1 downto 0); -- address
		D    : inout std_ulogic_vector(dataBits-1 downto 0)  -- data
	);
end;

architecture default of SDRAMC is
begin


end;