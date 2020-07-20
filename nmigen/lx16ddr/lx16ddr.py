import os
import subprocess

from nmigen.build import *
from nmigen.vendor.xilinx_spartan_3_6 import *
from nmigen_boards.resources import *


__all__ = ["LX16DDRPlatform"]


class LX16DDRPlatform(XilinxSpartan6Platform):
    device      = "xc6slx16"
    package     = "ftg256"
    speed       = "2"
    default_clk = "clk50"
    resources   = [
        Resource("clk50", 0, Pins("A10", dir="i"), Clock(50e6), Attrs(IOSTANDARD="LVCMOS33")),

        Resource("user_led", 0, Pins("T9", dir="o"), Attrs(IOSTANDARD="LVCMOS33", DRIVE="24", SLEW="QUIETIO")),
        Resource("user_led", 1, Pins("R9", dir="o"), Attrs(IOSTANDARD="LVCMOS33", DRIVE="24", SLEW="QUIETIO")),

        UARTResource(0,
            rx="A14", tx="C13",
            attrs=Attrs(IOSTANDARD="LVCMOS33")
        ),

        *SPIFlashResources(0,
            cs="T3", clk="R11", mosi="T10", miso="P10",
            attrs=Attrs(IOSTANDARD="LVCMOS33", SLEW="FAST")
        ),

        Resource("ddr3", 0,
            Subsignal("rst", PinsN("E4", dir="o")),
            Subsignal("clk", DiffPairs("E2", "E1", dir="o"), Attrs(IOSTANDARD="DIFF_SSTL15")),
            Subsignal("clk_en", Pins("F4", dir="o")),
            Subsignal("cs", PinsN("L2", dir="o")),
            Subsignal("we", PinsN("C1", dir="o")),
            Subsignal("ras", PinsN("J6", dir="o")),
            Subsignal("cas", PinsN("H5", dir="o")),
            Subsignal("a", Pins("K5 K6 D1 L4 G5 H4 H3 D3 B2 A2 G6 E3 F3 F6 F5", dir="o")),
            Subsignal("ba", Pins("C3 C2 B1", dir="o")),
            Subsignal("dqs", DiffPairs("H2 N3", "H1 N1", dir="io"), Attrs(IOSTANDARD="DIFF_SSTL15")),
            Subsignal("dq", Pins("K2 K1 J3 J1 F2 F1 G3 G1 L3 L1 M2 M1 P2 P1 R2 R1", dir="io")),
            Subsignal("dm", Pins("J4 K3", dir="o")),
            Subsignal("odt", Pins("L5", dir="o")),
            Attrs(IOSTANDARD="SSTL15", SLEW="FAST")
        )
    ]

    connectors  = [
        Connector("gpio", 0, "E12 B15 C15 D14 E15 F15 G11 F14 G16 H15 G12 H13 J14 J11 K14 K15 L16 K11 M15 N14 M13 L12 P15 R15 R14 T13 T12"), # U7 1
        Connector("gpio", 1, "E13 B16 C16 D16 E16 F16 F12 F13 G14 H16 H11 H14 J16 J12 J13 K16 L14 K12 M16 N16 M14 L13 P16 R16 T15 T14 R12"), # U7 2
        Connector("gpio", 2, "A14 C13 B12 C11 B10 C9 B8 C7 B6 B5 E10 E11 F9 C8 E7 F7 D6 M7 N8 P9 T5 T6 N9 L8 L10 P12 R9"), # U8 1
        Connector("gpio", 3, "B14 A13 A12 A11 A9 A8 A7 A6 A5 A4 C10 F10 D9 D8 E6 C6 N6 P6 L7 T4 R5 T7 M9 M10 P11 M11 T9")  # U8 2
    ]

    def toolchain_program(self, products, name):
        xc3sprog = os.environ.get("XC3SPROG", "xc3sprog")
        with products.extract("{}.bit".format(name)) as bitstream_filename:
            subprocess.run([xc3sprog, "-c", "ft4232h", bitstream_filename], check=True)
