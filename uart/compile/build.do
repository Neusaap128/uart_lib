

set ROOT [file normalize [pwd]/../../../..]
puts "ROOT = $ROOT"

set LIB_DIR $ROOT/build/

set PROJECT [file normalize [pwd]/../../..]
puts "project= $PROJECT"


# Recreate library cleanly
if {[file exists $LIB_DIR]} {
    file delete -force $LIB_DIR
}


vlib $LIB_DIR
vmap uart_lib $LIB_DIR


vcom -93 -work uart_lib $PROJECT/rtl/uart_tx.vhd
vcom -93 -work uart_lib $PROJECT/rtl/uart_rx.vhd
vcom -93 -work uart_lib $PROJECT/rtl/uart.vhd



