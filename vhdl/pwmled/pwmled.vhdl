-- https://vhdlwhiz.com/pwm-controller/

entity PWMLED is
	generic (
		pwmBits:   integer  := 8;
		cntBits:   integer  := 25;
		clkCntLen: positive := 47
	);
	port (
