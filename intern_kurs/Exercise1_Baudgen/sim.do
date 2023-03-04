quit -sim

vcom baudgen.vhd
vcom exercise1_tb.vhd

vsim baudgen_tb
do wave.do
run -all
wave zoom full