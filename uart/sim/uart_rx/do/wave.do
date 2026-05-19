onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_uart_rx/clk
add wave -noupdate /tb_uart_rx/rst_async
add wave -noupdate /tb_uart_rx/rx_data
add wave -noupdate /tb_uart_rx/rx_data_valid
add wave -noupdate /tb_uart_rx/rx
add wave -noupdate /tb_uart_rx/tx_start
add wave -noupdate /tb_uart_rx/tx_active
add wave -noupdate /tb_uart_rx/tx_data
add wave -noupdate /tb_uart_rx/tx_baud_counter
add wave -noupdate /tb_uart_rx/tx_bit_counter
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/clk
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/rst_async
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/rx_in
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/rx_in_d
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/rx_data_out
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/rx_data_valid_out
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/baud_div_in
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/rx_ready_out
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/s_baud_counter
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/s_read
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/rx_falling_edge
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/s_bit_counter
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/rx_ready
add wave -noupdate -expand -group Dut /tb_uart_rx/dut/rx_reading
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16336612 ps} 0}
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
WaveRestoreZoom {0 ps} {104909942 ps}
