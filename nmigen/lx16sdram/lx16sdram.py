import os
import subprocess

from nmigen.build import *
from nmigen.vendor.xilinx_spartan_3_6 import *
from nmigen_boards.resources import *


__all__ = ["LX16SDRAMPlatform"]


class LX16SDRAMPlatform(XilinxSpartan6Platform):
	device      = "xc6slx16"
	package     = "ftg256"
	speed       = "2"
	default_clk = "clk50"
	resources   = [
		Resource("clk50", 0, Pins("A10", dir="i"), Clock(50e6), Attrs(IOSTANDARD="LVCMOS33")),

		Resource("user_led", 0, Pins("T9", dir="o"), Attrs(IOSTANDARD="LVCMOS33", DRIVE="24", SLEW="QUIETIO")), # D1
		Resource("user_led", 1, Pins("R9", dir="o"), Attrs(IOSTANDARD="LVCMOS33", DRIVE="24", SLEW="QUIETIO")), # D3

		Resource("user_btn", 0, Pins("T8", dir="i"), Attrs(IOSTANDARD="LVCMOS33")), # SW2
		Resource("user_btn", 1, Pins("R7", dir="i"), Attrs(IOSTANDARD="LVCMOS33")), # SW3

		UARTResource(0,
			rx="A14", tx="C13",
			attrs=Attrs(IOSTANDARD="LVCMOS33")
		),
		UARTResource(1,
			rx="B14", tx="A13",
			attrs=Attrs(IOSTANDARD="LVCMOS33")
		),

		*SPIFlashResources(0,
			cs="T3", clk="R11", mosi="T10", miso="P10",
			attrs=Attrs(IOSTANDARD="LVCMOS33", SLEW="FAST")
		),

		Resource("sdram", 0,
			Subsignal("clk", Pins("H1", dir="i")),
			Subsignal("a",   Pins("L4 M3 M4 N3 R2 R1 P2 P1 N1 M1 L3 L1 K1", dir="o")),
			Subsignal("ba",  Pins("K3 K2", dir="o")),
			Subsignal("cs",  PinsN("J3", dir="o")),
			Subsignal("cke", Pins("J1", dir="o")),
			Subsignal("ras", PinsN("J4", dir="o")),
			Subsignal("cas", PinsN("H3", dir="o")),
			Subsignal("we",  PinsN("G3", dir="o")),
			Subsignal("dq",  Pins("A3 A2 B3 B2 C3 C2 D3 E3 G1 F1 F2 E1 E2 D1 C1 B1", dir="io")),
			Subsignal("dm",  Pins("F3 H2", dir="o")),
			Attrs(IOSTANDARD="LVCMOS33", SLEW="FAST")
		)
	]

	connectors  = [
		Connector("gpio", 0, "E12 B15 C15 D14 E15 F15 G11 F14 G16 H15 G12 H13 J14 J11 K14 K15 L16 K11 M15 N14 M13 L12 P15 R15 R14 T13 T12"), # U7 1
		Connector("gpio", 1, "E13 B16 C16 D16 E16 F16 F12 F13 G14 H16 H11 H14 J16 J12 J13 K16 L14 K12 M16 N16 M14 L13 P16 R16 T15 T14 R12"), # U7 2
		Connector("gpio", 2, "A14 C13 B12 C11 B10 C9 B8 C7 B6 B5 E10 E11 F9 C8 E7 F7 D6 P4 P5 M7 N8 P9 T5 T6 N9 M10 P12"), # U8 1
		Connector("gpio", 3, "B14 A13 A12 A11 A9 A8 A7 A6 A5 A4 C10 F10 D9 D8 E6 C6 M6 N5 N6 P6 L7 T4 R5 T7 M9 P11 M11")  # U8 2
	]

	def toolchain_program(self, products, name):
		xc3sprog = os.environ.get("XC3SPROG", "xc3sprog")
		with products.extract("{}.bit".format(name)) as bitstream_filename:
			subprocess.run([xc3sprog, "-c", "bbv2_2", bitstream_filename], check=True)
