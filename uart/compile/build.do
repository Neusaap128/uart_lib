

vlib uart_lib
vmap uart_lib uart_lib

set ROOT [file normalize [pwd]/../../..]

puts "ROOT = $ROOT"


vcom -93 -work uart_lib ../../rtl/uart.vhd



