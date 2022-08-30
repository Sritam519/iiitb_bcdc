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
  <img width="500" height="600"src="/images/stats.png">
</p><br>

```
/* Generated by Yosys 0.12+45 (git sha1 UNKNOWN, gcc 8.3.1 -fPIC -Os) */

module iiitb_bcdc(RN, EN, CK, Qz, Qu, Q);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  input CK;
  input EN;
  output [7:0] Q;
  output [3:0] Qu;
  output [3:0] Qz;
  input RN;
  sky130_fd_sc_hd__xor2_2 _27_ (
    .A(Q[0]),
    .B(EN),
    .X(_00_)
  );
  sky130_fd_sc_hd__nor2b_2 _28_ (
    .A(Q[2]),
    .B_N(Q[3]),
    .Y(_08_)
  );
  sky130_fd_sc_hd__and3b_2 _29_ (
    .A_N(_08_),
    .B(EN),
    .C(Q[0]),
    .X(_09_)
  );
  sky130_fd_sc_hd__and3_2 _30_ (
    .A(Q[0]),
    .B(Q[1]),
    .C(EN),
    .X(_10_)
  );
  sky130_fd_sc_hd__o21ba_2 _31_ (
    .A1(Q[1]),
    .A2(_09_),
    .B1_N(_10_),
    .X(_01_)
  );
  sky130_fd_sc_hd__xor2_2 _32_ (
    .A(Q[2]),
    .B(_10_),
    .X(_02_)
  );
  sky130_fd_sc_hd__a21o_2 _33_ (
    .A1(Q[2]),
    .A2(_10_),
    .B1(Q[3]),
    .X(_11_)
  );
  sky130_fd_sc_hd__and3b_2 _34_ (
    .A_N(Q[1]),
    .B(EN),
    .C(Q[0]),
    .X(_12_)
  );
  sky130_fd_sc_hd__nand2_2 _35_ (
    .A(_08_),
    .B(_12_),
    .Y(_13_)
  );
  sky130_fd_sc_hd__nand3_2 _36_ (
    .A(Q[2]),
    .B(Q[3]),
    .C(_10_),
    .Y(_14_)
  );
  sky130_fd_sc_hd__and3_2 _37_ (
    .A(_11_),
    .B(_13_),
    .C(_14_),
    .X(_15_)
  );
  sky130_fd_sc_hd__buf_1 _38_ (
    .A(_15_),
    .X(_03_)
  );
  sky130_fd_sc_hd__and3_2 _39_ (
    .A(Q[4]),
    .B(_08_),
    .C(_12_),
    .X(_16_)
  );
  sky130_fd_sc_hd__a21oi_2 _40_ (
    .A1(_08_),
    .A2(_12_),
    .B1(Q[4]),
    .Y(_17_)
  );
  sky130_fd_sc_hd__nor2_2 _41_ (
    .A(_16_),
    .B(_17_),
    .Y(_04_)
  );
  sky130_vsdinv _42_ (
    .A(Q[6]),
    .Y(_18_)
  );
  sky130_fd_sc_hd__a21oi_2 _43_ (
    .A1(Q[7]),
    .A2(_18_),
    .B1(Q[5]),
    .Y(_19_)
  );
  sky130_fd_sc_hd__mux2_2 _44_ (
    .A0(Q[5]),
    .A1(_19_),
    .S(_16_),
    .X(_20_)
  );
  sky130_fd_sc_hd__buf_1 _45_ (
    .A(_20_),
    .X(_05_)
  );
  sky130_fd_sc_hd__and4_2 _46_ (
    .A(Q[4]),
    .B(Q[5]),
    .C(_08_),
    .D(_12_),
    .X(_21_)
  );
  sky130_fd_sc_hd__xnor2_2 _47_ (
    .A(_18_),
    .B(_21_),
    .Y(_06_)
  );
  sky130_vsdinv _48_ (
    .A(Q[7]),
    .Y(_22_)
  );
  sky130_fd_sc_hd__and3_2 _49_ (
    .A(Q[4]),
    .B(Q[5]),
    .C(Q[6]),
    .X(_23_)
  );
  sky130_fd_sc_hd__and4bb_2 _50_ (
    .A_N(Q[5]),
    .B_N(Q[6]),
    .C(Q[7]),
    .D(Q[4]),
    .X(_24_)
  );
  sky130_fd_sc_hd__nor2_2 _51_ (
    .A(_23_),
    .B(_24_),
    .Y(_25_)
  );
  sky130_fd_sc_hd__a31o_2 _52_ (
    .A1(_08_),
    .A2(_12_),
    .A3(_23_),
    .B1(Q[7]),
    .X(_26_)
  );
  sky130_fd_sc_hd__o31a_2 _53_ (
    .A1(_22_),
    .A2(_13_),
    .A3(_25_),
    .B1(_26_),
    .X(_07_)
  );
  sky130_fd_sc_hd__dfrtp_2 _54_ (
    .CLK(CK),
    .D(_00_),
    .Q(Q[0]),
    .RESET_B(RN)
  );
  sky130_fd_sc_hd__dfrtp_2 _55_ (
    .CLK(CK),
    .D(_01_),
    .Q(Q[1]),
    .RESET_B(RN)
  );
  sky130_fd_sc_hd__dfrtp_2 _56_ (
    .CLK(CK),
    .D(_02_),
    .Q(Q[2]),
    .RESET_B(RN)
  );
  sky130_fd_sc_hd__dfrtp_2 _57_ (
    .CLK(CK),
    .D(_03_),
    .Q(Q[3]),
    .RESET_B(RN)
  );
  sky130_fd_sc_hd__dfrtp_2 _58_ (
    .CLK(CK),
    .D(_04_),
    .Q(Q[4]),
    .RESET_B(RN)
  );
  sky130_fd_sc_hd__dfrtp_2 _59_ (
    .CLK(CK),
    .D(_05_),
    .Q(Q[5]),
    .RESET_B(RN)
  );
  sky130_fd_sc_hd__dfrtp_2 _60_ (
    .CLK(CK),
    .D(_06_),
    .Q(Q[6]),
    .RESET_B(RN)
  );
  sky130_fd_sc_hd__dfrtp_2 _61_ (
    .CLK(CK),
    .D(_07_),
    .Q(Q[7]),
    .RESET_B(RN)
  );
  sky130_fd_sc_hd__buf_2 _62_ (
    .A(Q[0]),
    .X(Qu[0])
  );
  sky130_fd_sc_hd__buf_2 _63_ (
    .A(Q[1]),
    .X(Qu[1])
  );
  sky130_fd_sc_hd__buf_2 _64_ (
    .A(Q[2]),
    .X(Qu[2])
  );
  sky130_fd_sc_hd__buf_2 _65_ (
    .A(Q[3]),
    .X(Qu[3])
  );
  sky130_fd_sc_hd__buf_2 _66_ (
    .A(Q[4]),
    .X(Qz[0])
  );
  sky130_fd_sc_hd__buf_2 _67_ (
    .A(Q[5]),
    .X(Qz[1])
  );
  sky130_fd_sc_hd__buf_2 _68_ (
    .A(Q[6]),
    .X(Qz[2])
  );
  sky130_fd_sc_hd__buf_2 _69_ (
    .A(Q[7]),
    .X(Qz[3])
  );
endmodule
```


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
