onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_uart/clk
add wave -noupdate /tb_uart/rst_async
add wave -noupdate /tb_uart/tx_data
add wave -noupdate /tb_uart/tx_data_valid
add wave -noupdate /tb_uart/rx_data
add wave -noupdate /tb_uart/rx_data_valid
add wave -noupdate /tb_uart/txrx
add wave -noupdate -group Dut /tb_uart/dut/clk
add wave -noupdate -group Dut /tb_uart/dut/rst_async
add wave -noupdate -group Dut /tb_uart/dut/tx_out
add wave -noupdate -group Dut /tb_uart/dut/rx_in
add wave -noupdate -group Dut /tb_uart/dut/tx_data_in
add wave -noupdate -group Dut /tb_uart/dut/tx_data_valid_in
add wave -noupdate -group Dut /tb_uart/dut/rx_data_out
add wave -noupdate -group Dut /tb_uart/dut/rx_data_valid_out
add wave -noupdate -group Dut /tb_uart/dut/baud_div_in
add wave -noupdate -group Dut /tb_uart/dut/tx_ready_out
add wave -noupdate -group Dut /tb_uart/dut/rx_ready_out
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/clk
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/rst_async
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/tx_out
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/tx_data_in
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/tx_data_valid_in
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/baud_div_in
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/tx_ready_out
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/s_baud_counter
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/s_transfer
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/s_bit_counter
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/tx_ready
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/tx_transmitting
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/tx_transmitting_stop_bit
add wave -noupdate -group tx /tb_uart/dut/uart_tx_i/tx_data_buff
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/clk
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/rst_async
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/rx_in
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/rx_data_out
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/rx_data_valid_out
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/baud_div_in
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/rx_ready_out
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/s_baud_counter
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/s_read
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/rx_in_d
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/rx_falling_edge
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/s_bit_counter
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/rx_ready
add wave -noupdate -group rx /tb_uart/dut/uart_rx_i/rx_reading
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
WaveRestoreZoom {1610315188 ps} {1725893938 ps}
