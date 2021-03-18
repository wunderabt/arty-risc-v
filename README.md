# Risc-V experiments on Arty A7

## links

### Tools

- [chisel bootcamp](https://riscv.org/wp-content/uploads/2015/01/riscv-chisel-tutorial-bootcamp-jan2015.pdf)
- [chisel homepage](https://www.chisel-lang.org/)

### Arty A7 Tutorials

- [DigiKey](https://www.digikey.com/eewiki/display/LOGIC/Digilent+Arty+A7+with+Xilinx+Artix-7+Implementing+SiFive+FE310+RISC-V)
- [Digilent](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/arty_a7_100_risc_v/start)
- [SiFive](https://static.dev.sifive.com/SiFive-E310-arty-gettingstarted-v1.0.6.pdf)

## Hints

### identify USB devices

get mapping information via

```bash
$ ls -l /dev/serial/by-id
total 0
lrwxrwxrwx 1 root root 13 Feb 13 20:17 usb-15ba_Olimex_OpenOCD_JTAG_ARM-USB-TINY-H_OL9533D9-if01-port0 -> ../../ttyUSB2
lrwxrwxrwx 1 root root 13 Feb 13 20:17 usb-Digilent_Digilent_USB_Device_210319AFEE0C-if01-port0 -> ../../ttyUSB1
```

## Level 0 - FPGA test

To check basic function of the Toolset and the FPGA board ..

.. build the Xilinx docker image

```bash
$ cd docker/xilinx
$ <download Vivado webpack installer>
$ ./Xilinx_Unified_2020.2_1118_1232_Lin64.bin -- --batch AuthTokenGen
$ cp ~/.Xilinx/wi_authentication_key .
$ ./build.sh
```

.. start an interactive docker session and build the `vivado_getting_started` project in Vivado

```bash
$ docker/xilinx/run.sh
$ vivado
```

## Level 1 - run "Hello World" on synthesized E310 core

build the docker image with the SiFive toolchain

```bash
$ cd docker/risc-v
$ ./build.sh
```

build verilog and synthesize design

```bash
$
$ # set Arty Board type
```