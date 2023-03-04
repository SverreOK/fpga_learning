onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /baudgen_tb/clk
add wave -noupdate /baudgen_tb/rst
add wave -noupdate /baudgen_tb/enable
add wave -noupdate /baudgen_tb/baudselect
add wave -noupdate /baudgen_tb/baud_out
add wave -noupdate /baudgen_tb/clkcount
add wave -noupdate /baudgen_tb/reset_clkcount
add wave -noupdate /baudgen_tb/clk_hz
add wave -noupdate /baudgen_tb/clk_period
add wave -noupdate /baudgen_tb/baudPeriod
add wave -noupdate /baudgen_tb/DUT/g_clockspeed
add wave -noupdate /baudgen_tb/DUT/CLK
add wave -noupdate /baudgen_tb/DUT/RST
add wave -noupdate /baudgen_tb/DUT/ENABLE
add wave -noupdate /baudgen_tb/DUT/BAUDSELECT
add wave -noupdate /baudgen_tb/DUT/BAUD_OUT
add wave -noupdate /baudgen_tb/DUT/s_counter
add wave -noupdate /baudgen_tb/DUT/s_baudrate
add wave -noupdate /baudgen_tb/DUT/s_output
add wave -noupdate /baudgen_tb/DUT/s_last_baudrate
add wave -noupdate /baudgen_tb/DUT/baudPeriod
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {195921 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {395249 ps}
