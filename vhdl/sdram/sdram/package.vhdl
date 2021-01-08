library ieee;
use ieee.std_logic_1164.all;

package sdram is
	type Command is record
		WEn, CASn, RASn, CSn : std_ulogic;
	end record;
end package;