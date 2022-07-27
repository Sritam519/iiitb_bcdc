# iiitb_bcdc - 8 bit bcd counter
steps for functional-simulation:-
1.To clone the respository and download the netlist files for simulation, enter the following commands in your terminal
 $ sudo apt install -y git
 $ git clone https://github.com/Sritam519/iiitb_bcdc.git
 $ cd iiitb_bcdc
2.To run the simulation use the following commands:- 
 $ iverilog iiit_bcdc.v iiit_bcdc_tb.v
 $ gtkwave iiit_bcdc.vsd
 
 

