
## Clock: 100 MHz onboard oscillator
set_property -dict { PACKAGE_PIN R2 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.000 -waveform {0 5} [get_ports clk]

## Reset button (active low pushbutton)
set_property -dict { PACKAGE_PIN C18 IOSTANDARD LVCMOS33 } [get_ports rst_n]

## USB-UART interface (FTDI bridge)

## FPGA TX -> PC RX
set_property -dict { PACKAGE_PIN R12 IOSTANDARD LVCMOS33 } [get_ports uart_tx]

## FPGA RX <- PC TX
set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports uart_rx]

