from nmigen import *
from lx16ddr import LX16DDRPlatform


class Blinky(Elaboratable):
    def elaborate(self, platform):
        m = Module()

        counter = Signal(25)
        m.d.sync += counter.eq(counter + 1)

        led = platform.request("user_led", 0)
        m.d.comb += led.o.eq(counter[24])

        return m


if __name__ == "__main__":
    platform = LX16DDRPlatform()
    platform.build(Blinky(), do_program=False)
