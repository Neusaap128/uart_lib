onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_uart_tx/clk
add wave -noupdate /tb_uart_tx/rst_async
add wave -noupdate /tb_uart_tx/tx_data
add wave -noupdate /tb_uart_tx/tx_data_valid
add wave -noupdate /tb_uart_tx/tx
add wave -noupdate /tb_uart_tx/tx_d
add wave -noupdate /tb_uart_tx/rx_data
add wave -noupdate /tb_uart_tx/rx_bit_counter
add wave -noupdate /tb_uart_tx/rx_baud_counter
add wave -noupdate /tb_uart_tx/rx_active
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/clk
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/rst_async
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/tx_out
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/tx_data_in
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/tx_data_valid_in
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/baud_div_in
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/tx_ready_out
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/s_baud_counter
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/s_transfer
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/s_bit_counter
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/tx_ready
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/tx_transmitting
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/tx_transmitting_stop_bit
add wave -noupdate -expand -group Dut /tb_uart_tx/dut/tx_data_buff
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {109853275 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {115578750 ps}
