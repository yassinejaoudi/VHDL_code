transcript off
quit -sim
cd {C:\intelFPGA_lite\16.1\Assignment_4}
vlib work
vmap work work
vcom comb_logic_df.vhd
vcom test_comb_logic_df.vhd 

vsim test_comb_logic_df
add wave sim:/test_comb_logic_df/dev_to_test/*
 
run 80 ns