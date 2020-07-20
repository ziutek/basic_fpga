from migen import *

import lx16sdram

class Blinky(Module):
	def __init__(self, platform):
		led0 = platform.request("user_led", 0)
		led1 = platform.request("user_led", 1)
		counter = Signal(26)

		self.sync += counter.eq(counter + 1)
		self.comb += [
			led0.eq(counter[24]),
			led1.eq(counter[25]),
		]

if __name__ == "__main__":
	platform = lx16sdram.Platform()
	top = Blinky(platform)
	platform.build(top)