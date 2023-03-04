quit -sim

vcom storage.vhd
vcom exercise2_tb.vhd

vsim storage_tb
do wave.do
run -all
wave zoom full