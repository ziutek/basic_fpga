from nmigen import *
from lx16sdram import LX16SDRAMPlatform


class Blinky(Elaboratable):
	def elaborate(self, platform):
		m = Module()

		counter = Signal(26)
		m.d.sync += counter.eq(counter + 1)

		led0 = platform.request("user_led", 0)
		led1 = platform.request("user_led", 1)

		m.d.comb += led0.o.eq(counter[24])
		m.d.comb += led1.o.eq(counter[25])

		return m


if __name__ == "__main__":
	platform = LX16SDRAMPlatform()
	platform.build(Blinky(), do_program=True)
