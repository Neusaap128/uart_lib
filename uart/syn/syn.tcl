
set_msg_config -quiet
set_msg_config -id "Synth 8-*" -limit 10

read_xdc constraints/constraints.xdc

read_vhdl -library uart_lib ../rtl/uart_tx.vhd
read_vhdl -library uart_lib ../rtl/uart_rx.vhd
read_vhdl -library uart_lib ../rtl/uart.vhd
read_vhdl -library uart_lib ./uart_hweval.vhd

synth_design -top uart_hweval -part xc7s25csga225-1

report_utilization -hierarchical  > reports/utilization.rpt
report_timing_summary             > reports/timing_summary.rpt
report_timing                     > reports/timing.rpt
report_power                      > reports/power.rpt

write_checkpoint -force post_synth.dcp

