onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /storage_tb/clk
add wave -noupdate /storage_tb/rst
add wave -noupdate /storage_tb/storage_clk
add wave -noupdate /storage_tb/address
add wave -noupdate /storage_tb/writedata
add wave -noupdate /storage_tb/readdata
add wave -noupdate /storage_tb/clk_hz
add wave -noupdate /storage_tb/clk_period
add wave -noupdate /storage_tb/DUT/SYSCLK
add wave -noupdate /storage_tb/DUT/RST
add wave -noupdate /storage_tb/DUT/CLK
add wave -noupdate /storage_tb/DUT/ADR
add wave -noupdate /storage_tb/DUT/WRITEDATA
add wave -noupdate /storage_tb/DUT/READDATA
add wave -noupdate -childformat {{/storage_tb/DUT/STORAGE(0) -radix hexadecimal} {/storage_tb/DUT/STORAGE(1) -radix hexadecimal} {/storage_tb/DUT/STORAGE(2) -radix hexadecimal} {/storage_tb/DUT/STORAGE(3) -radix hexadecimal}} -expand -subitemconfig {/storage_tb/DUT/STORAGE(0) {-radix hexadecimal} /storage_tb/DUT/STORAGE(1) {-radix hexadecimal} /storage_tb/DUT/STORAGE(2) {-radix hexadecimal} /storage_tb/DUT/STORAGE(3) {-radix hexadecimal}} /storage_tb/DUT/STORAGE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {688050 ps} 0}
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
WaveRestoreZoom {0 ps} {2274966 ps}
