

set ROOT [file normalize [pwd]/../../..]

puts "ROOT = $ROOT"

vlib $ROOT/build
vmap uart_lib ../../../build



vcom -93 -work uart_lib ../../rtl/uart.vhd



