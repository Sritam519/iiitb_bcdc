# read design

read_verilog iiitb_bcdc.v

# generic synthesis
synth -top iiitb_bcdc

# mapping to mycells.lib
dfflibmap -liberty /home/sritam/Desktop/iiitb_bcdc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/sritam/Desktop/iiitb_bcdc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
# write synthesized design
write_verilog -noattr synth_iiitb_bcdc.v
