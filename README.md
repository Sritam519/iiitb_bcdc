# iiitb_bcdc - 8 bit bcd counter
## Introduction <br />
The 8 bit Binary Coded Decimal (BCD) Counter is a counter that counts 100 digits starting from 0 to 99.BCD is an encoding where each digit in a decimal number is represented in the form of bits(usually 4 bits). For example the number 89 can be represented as 10001001 in BCD as 1000 is the BCD representation of 8 and 1001 is the BCD representation of 9.BCD code is also known as 8421 BCD code. This also makes it a weighted code which implies that each bit in the four bit groups representing each decimal digit has a specific weight. As compared to prevalent binary positioning system it’s easy to convert it into human readable representation with the drawback of slight increase in complexity of the circuits.<br />
<br />
## Application <br />
The BCD Counter finds application in clock production, clock division, used in minimal power cmos circuit, implemented in frequency counting circuits.<br />
<br />
## Reference circuit details <br />
The 8 bit BCD counter counts from 00000000(0) to 10011001(99). After that it resets to initial value 0 and the process is repeated again. The Verilog code contains 8 bit output and clock, reset & enable as input. The 8 bit BCD counter block diagram is shown in Fig1 and the port list are given in Table1.In Fig2 output waveform for few clock cycles is displayed.<br />
<br />
## Fig1 <br />
<p align="center">
  <img width="350" height="200" src="/images/blockdiagram.png">
</p><br>
<br />

## Table1 <br />
<p align="center">
  <img width="350" height="200" src="/images/Table1.png">
</p><br>
<br />

## Functional simulation <br />

## Fig2 <br />
<p align="center">
  <img width="800" height="200" src="/images/waveform.png">
</p><br>
<br />

steps for functional-simulation:-<br />
1.To clone the respository and download the netlist files for simulation, enter the following commands in your terminal<br />
``` 
 $ sudo apt install -y git
 $ git clone https://github.com/Sritam519/iiitb_bcdc.git
```
 
2.To run the simulation use the following commands:- <br />
``` 
 $ cd iiitb_bcdc
 $ iverilog iiitb_bcdc.v iiitb_bcdc_tb.v
 $ gtkwave iiitb_bcdc.vsd
 ```
 # Statistics 
 <p align="center">
  <img width="350" height="400" src="/images/stats0.png">
</p><br>
<br />
 
 ## GLS <br />
 ```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 verilog_model/primitives.v verilog_model/sky130_fd_sc_hd.v iiitb_bcdc_net.v iiitb_bcdc_tb.v
./a.out --> For Generating the vcd file.
gtkwave iiitb_bcdc.vcd
```
 <p align="center">
  <img width="800" height="200" src="/images/post synthesis simulation.png">
</p><br>
<br />

## Physical Design
#### Openlane
OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

more at https://github.com/The-OpenROAD-Project/OpenLane
#### Installation instructions 
```
$   apt install -y build-essential python3 python3-venv python3-pip
```
Docker installation process: https://docs.docker.com/engine/install/ubuntu/

goto home directory->
```
$   git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$   cd OpenLane/
$   sudo make
```
To test the open lane
```
$ sudo make test
```
It takes approximate time of 5min to complete. After 43 steps, if it ended with saying **Basic test passed** then open lane installed succesfully.

#### Magic
Magic is a venerable VLSI layout tool, written in the 1980's at Berkeley by John Ousterhout, now famous primarily for writing the scripting interpreter language Tcl. Due largely in part to its liberal Berkeley open-source license, magic has remained popular with universities and small companies. The open-source license has allowed VLSI engineers with a bent toward programming to implement clever ideas and help magic stay abreast of fabrication technology. However, it is the well thought-out core algorithms which lend to magic the greatest part of its popularity. Magic is widely cited as being the easiest tool to use for circuit layout, even for people who ultimately rely on commercial tools for their product design flow.

More about magic at http://opencircuitdesign.com/magic/index.html

Run following commands one by one to fulfill the system requirement.

```
$   sudo apt-get install m4
$   sudo apt-get install tcsh
$   sudo apt-get install csh
$   sudo apt-get install libx11-dev
$   sudo apt-get install tcl-dev tk-dev
$   sudo apt-get install libcairo2-dev
$   sudo apt-get install mesa-common-dev libglu1-mesa-dev
$   sudo apt-get install libncurses-dev
```
**To install magic**
goto home directory

```
$   git clone https://github.com/RTimothyEdwards/magic
$   cd magic/
$   ./configure
$   sudo make
$   sudo make install
```
## Running OpenLane 
 
Download the config.json file and place it in the `OpenLane/designs/iiitb_bcdc` folder. The `config.json` file is given below as well.
```
{    
    "DESIGN_NAME": "iiitb_bcdc",
    "VERILOG_FILES": "dir::src/iiitb_bcdc.v",
    "CLOCK_PORT": "clk",
    "CLOCK_NET": "clk",
    "GLB_RESIZER_TIMING_OPTIMIZATIONS": true,
    "CLOCK_PERIOD": 12,
    "PL_RANDOM_GLB_PLACEMENT":1,
    "pdk::sky130*": {
        "SYNTH_MAX_FANOUT": 6,
        "FP_CORE_UTIL": 35,
        "scl::sky130_fd_sc_hd": {
            "FP_CORE_UTIL": 30
           
        }
    },
   "LIB_SYNTH": "dir::src/sky130_fd_sc_hd__typical.lib",
   "LIB_FASTEST": "dir::src/sky130_fd_sc_hd__fast.lib",
   "LIB_SLOWEST": "dir::src/sky130_fd_sc_hd__slow.lib",
   "LIB_TYPICAL": "dir::src/sky130_fd_sc_hd__typical.lib",
   "TEST_EXTERNAL_GLOB": "dir::../iiitb_bcdc/src/*",
   "SYNTH_DRIVING_CELL":"sky130_vsdinv"
   
}
```
Now, paste the verilog code `iiitb_bcdc.v`, `sky130_vsdinv.lef`, `sky130_fd_sc_hd__fast.lib`,  `sky130_fd_sc_hd__slow.lib` and `sky130_fd_sc_hd__typical.lib`inside the folder `OpenLane/designs/iiitb_bcdc/src`


To invoke OpenLane, type the following commands. On typing the following commands, `runs` folder is created inside the `iiitb_bcdc` folder. 
```
cd OpenLane
make mount
./flow.tcl -interactive
prep -design iiitb_bcdc
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
```
<p align="center">
  <img src="/images/invoking_openlane.png">
</p><br>

## Synthesis:
Now, to run synthesis, type the following command
```
run_synthesis
```
The synthesized netlist is present in the results folder and the stats are present in the reports folder. 

<p align="center">
  <img width="700" height="600"src="/images/stats.png">
</p><br>


Here, we notice that our custom cell `sky130_vsdinv` is displayed in the netlist generated.

## Floorplan and Placement

Also, sta report post synthesis can be viewed by going to the location `logs\synthesis\2-sta.log`

The next step is to run `floorplan` and `placement`. Type the following commands.
```
run_floorplan
run_placement
```
The floorplan can be viewed by typing the following command.
```
magic -T /home/sritam/Desktop/vsdflow/work/tools/openlane_working_dir/OpenLane/pdks/volare/sky130/versions/e8294524e5f67c533c5d0c3afa0bcc5b2a5fa066/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef fed read iiitb_bcdc.def &
```
<p align="center">
  <img src="/images/floorplan.png">
</p><br>

The placement can be viewed by typing the following command.
```
magic -T /home/sritam/Desktop/vsdflow/work/tools/openlane_working_dir/OpenLane/pdks/volare/sky130/versions/e8294524e5f67c533c5d0c3afa0bcc5b2a5fa066/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef fed read iiitb_bcdc.def &
```
<p align="center">
  <img src="/images/placement.png">
</p><br>

## Clock Tree Synthesis

The next step is to run run clock tree synthesis. The CTS run adds clock buffers in therefore buffer delays come into picture and our analysis from here on deals with real clocks. To run clock tree synthesis, type the following commands

```
run_cts
```

Also, sta report post synthesis can be viewed by going to the location `logs\synthesis\12-cts.log`


## Routing
The command to run routing is 
```
run_routing
```
<p align="center">
  <img src="/images/routing.png">
</p><br>


 ## Contributors

- **Sriman Sritam Birtia** 
- **Kunal Ghosh** 



## Acknowledgments


- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
- Madhav Rao, Associate Professor,International Institute of Information Technology, Bangalore
- V N Muralidhara, Associate Professor,International Institute of Information Technology, Bangalore

## Contact Information

- Sriman Sritam Birtia, Postgraduate Student, International Institute of Information Technology, Bangalore,  sritambirtia123@gmail.com
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd., kunalghosh@gmail.com

## *References*
**(1)	Emilliano, Chandan Kumar Chakrabarty, Ahmad Basri A Ghani, and Agileswari K Ramaswamy, “VHDL Simulation on peak detector, 64 bit BCD Conuter and Reset Automation Block for PD Detection system using FPGA” (https://ieeexplore.ieee.org/document/5545328)**

**(2) bcd counter (https://www.watelectronics.com/bcd-counter-design-operation/)**

**(3) Icarus Verilog - [iverilog](http://iverilog.icarus.com/)**

**(4) GTK Wave [documentation](http://gtkwave.sourceforge.net/gtkwave.pdf)**
