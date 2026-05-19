onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_uart/clk
add wave -noupdate /tb_uart/rst_async
add wave -noupdate /tb_uart/tx_data
add wave -noupdate /tb_uart/tx_data_valid
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
add wave -noupdate -group Dut /tb_uart/dut/s_baud_counter
add wave -noupdate -group Dut /tb_uart/dut/s_transfer
add wave -noupdate -group Dut /tb_uart/dut/s_bit_counter
add wave -noupdate -group Dut /tb_uart/dut/tx_ready
add wave -noupdate -group Dut /tb_uart/dut/tx_transmitting
add wave -noupdate -group Dut /tb_uart/dut/tx_transmitting_stop_bit
add wave -noupdate -group Dut /tb_uart/dut/tx_data_buff
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {259533 ps} 0}
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
WaveRestoreZoom {852444 ps} {1086714 ps}
