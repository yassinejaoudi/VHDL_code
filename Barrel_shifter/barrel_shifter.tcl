transcript off
quit -sim
cd {C:\ECE501\Assignment_8}
vlib work
vmap work work
vcom barrel_shifter.vhd
vcom barrel_shifter_test.vhd 

vsim barrel_shifter_test
add wave sim:/barrel_shifter_test/dev_to_test/*
 
run 240 ns
