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

The next step is to run run clock tree synthesis. The CTS run adds clock buffers in therefore buffer delays come into picture and our analysis from here on deals with real clocks. To run clock tree synthesis, type the following commands
```
run_cts
```
Also, the netlist with clock buffers can be viewed by going to the location `results\cts\iiitb_bcdc.v`
```

module iiitb_bcdc (CK,
    EN,
    RN,
    VGND,
    VPWR,
    Q,
    Qu,
    Qz);
 input CK;
 input EN;
 input RN;
 input VGND;
 input VPWR;
 output [7:0] Q;
 output [3:0] Qu;
 output [3:0] Qz;

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
 wire net1;
 wire net10;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net18;
 wire net19;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;

 sky130_fd_sc_hd__decap_3 PHY_0 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_1 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_10 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_11 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_12 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_13 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_14 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_15 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_16 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_17 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_18 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_19 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_2 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_20 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_21 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_22 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_23 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_24 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_25 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_26 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_27 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_3 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_4 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_5 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_6 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_7 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_8 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__decap_3 PHY_9 (.VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_28 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_29 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_30 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_31 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_32 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_33 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_34 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_35 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_36 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_37 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_38 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_39 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_40 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_41 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_42 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_43 (.VGND(VGND),
    .VPWR(VPWR));
 sky130_fd_sc_hd__xor2_1 _27_ (.A(net4),
    .B(net2),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_00_));
 sky130_fd_sc_hd__nor2b_2 _28_ (.A(net6),
    .B_N(net7),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Y(_08_));
 sky130_fd_sc_hd__and3b_1 _29_ (.A_N(_08_),
    .B(net2),
    .C(net4),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_09_));
 sky130_fd_sc_hd__and3_1 _30_ (.A(net4),
    .B(net5),
    .C(net2),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_10_));
 sky130_fd_sc_hd__o21ba_1 _31_ (.A1(net5),
    .A2(_09_),
    .B1_N(_10_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_01_));
 sky130_fd_sc_hd__xor2_1 _32_ (.A(net6),
    .B(_10_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_02_));
 sky130_fd_sc_hd__a21o_1 _33_ (.A1(net6),
    .A2(_10_),
    .B1(net7),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_11_));
 sky130_fd_sc_hd__and3b_1 _34_ (.A_N(net5),
    .B(net2),
    .C(net4),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_12_));
 sky130_fd_sc_hd__nand2_1 _35_ (.A(_08_),
    .B(_12_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Y(_13_));
 sky130_fd_sc_hd__nand3_1 _36_ (.A(net6),
    .B(net7),
    .C(_10_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Y(_14_));
 sky130_fd_sc_hd__and3_1 _37_ (.A(_11_),
    .B(_13_),
    .C(_14_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_15_));
 sky130_fd_sc_hd__clkbuf_1 _38_ (.A(_15_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_03_));
 sky130_fd_sc_hd__and3_1 _39_ (.A(net8),
    .B(_08_),
    .C(_12_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_16_));
 sky130_fd_sc_hd__a21oi_1 _40_ (.A1(_08_),
    .A2(_12_),
    .B1(net8),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Y(_17_));
 sky130_fd_sc_hd__nor2_1 _41_ (.A(_16_),
    .B(_17_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Y(_04_));
 sky130_vsdinv _42_ (.A(net10),
    .Y(_18_),
    .VPWR(VPWR),
    .VGND(VGND));
 sky130_fd_sc_hd__a21oi_1 _43_ (.A1(net11),
    .A2(_18_),
    .B1(net9),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Y(_19_));
 sky130_fd_sc_hd__mux2_1 _44_ (.A0(net9),
    .A1(_19_),
    .S(_16_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_20_));
 sky130_fd_sc_hd__clkbuf_1 _45_ (.A(_20_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_05_));
 sky130_fd_sc_hd__and4_1 _46_ (.A(net8),
    .B(net9),
    .C(_08_),
    .D(_12_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_21_));
 sky130_fd_sc_hd__xnor2_1 _47_ (.A(_18_),
    .B(_21_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Y(_06_));
 sky130_vsdinv _48_ (.A(net11),
    .Y(_22_),
    .VPWR(VPWR),
    .VGND(VGND));
 sky130_fd_sc_hd__and3_1 _49_ (.A(net8),
    .B(net9),
    .C(net10),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_23_));
 sky130_fd_sc_hd__and4bb_1 _50_ (.A_N(net9),
    .B_N(net10),
    .C(net11),
    .D(net8),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_24_));
 sky130_fd_sc_hd__nor2_1 _51_ (.A(_23_),
    .B(_24_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Y(_25_));
 sky130_fd_sc_hd__a31o_1 _52_ (.A1(_08_),
    .A2(_12_),
    .A3(_23_),
    .B1(net11),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_26_));
 sky130_fd_sc_hd__o31a_1 _53_ (.A1(_22_),
    .A2(_13_),
    .A3(_25_),
    .B1(_26_),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(_07_));
 sky130_fd_sc_hd__dfrtp_2 _54_ (.CLK(net1),
    .D(_00_),
    .RESET_B(net3),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Q(net4));
 sky130_fd_sc_hd__dfrtp_1 _55_ (.CLK(net1),
    .D(_01_),
    .RESET_B(net3),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Q(net5));
 sky130_fd_sc_hd__dfrtp_4 _56_ (.CLK(net1),
    .D(_02_),
    .RESET_B(net3),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Q(net6));
 sky130_fd_sc_hd__dfrtp_1 _57_ (.CLK(net1),
    .D(_03_),
    .RESET_B(net3),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Q(net7));
 sky130_fd_sc_hd__dfrtp_2 _58_ (.CLK(net1),
    .D(_04_),
    .RESET_B(net3),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Q(net8));
 sky130_fd_sc_hd__dfrtp_2 _59_ (.CLK(net1),
    .D(_05_),
    .RESET_B(net3),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Q(net9));
 sky130_fd_sc_hd__dfrtp_1 _60_ (.CLK(net1),
    .D(_06_),
    .RESET_B(net3),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Q(net10));
 sky130_fd_sc_hd__dfrtp_2 _61_ (.CLK(net1),
    .D(_07_),
    .RESET_B(net3),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .Q(net11));
 sky130_fd_sc_hd__clkbuf_1 _62_ (.A(net4),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net12));
 sky130_fd_sc_hd__clkbuf_1 _63_ (.A(net5),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net13));
 sky130_fd_sc_hd__clkbuf_1 _64_ (.A(net6),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net14));
 sky130_fd_sc_hd__clkbuf_1 _65_ (.A(net7),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net15));
 sky130_fd_sc_hd__clkbuf_1 _66_ (.A(net8),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net16));
 sky130_fd_sc_hd__clkbuf_1 _67_ (.A(net9),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net17));
 sky130_fd_sc_hd__clkbuf_1 _68_ (.A(net10),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net18));
 sky130_fd_sc_hd__clkbuf_1 _69_ (.A(net11),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net19));
 sky130_fd_sc_hd__clkbuf_2 input1 (.A(CK),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net1));
 sky130_fd_sc_hd__dlymetal6s2s_1 input2 (.A(EN),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_4 input3 (.A(RN),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(net3));
 sky130_fd_sc_hd__buf_2 output10 (.A(net10),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Q[6]));
 sky130_fd_sc_hd__buf_2 output11 (.A(net11),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Q[7]));
 sky130_fd_sc_hd__buf_2 output12 (.A(net12),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Qu[0]));
 sky130_fd_sc_hd__buf_2 output13 (.A(net13),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Qu[1]));
 sky130_fd_sc_hd__buf_2 output14 (.A(net14),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Qu[2]));
 sky130_fd_sc_hd__buf_2 output15 (.A(net15),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Qu[3]));
 sky130_fd_sc_hd__buf_2 output16 (.A(net16),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Qz[0]));
 sky130_fd_sc_hd__buf_2 output17 (.A(net17),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Qz[1]));
 sky130_fd_sc_hd__buf_2 output18 (.A(net18),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Qz[2]));
 sky130_fd_sc_hd__buf_2 output19 (.A(net19),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Qz[3]));
 sky130_fd_sc_hd__buf_2 output4 (.A(net4),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Q[0]));
 sky130_fd_sc_hd__buf_2 output5 (.A(net5),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Q[1]));
 sky130_fd_sc_hd__buf_2 output6 (.A(net6),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Q[2]));
 sky130_fd_sc_hd__buf_2 output7 (.A(net7),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Q[3]));
 sky130_fd_sc_hd__buf_2 output8 (.A(net8),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Q[4]));
 sky130_fd_sc_hd__buf_2 output9 (.A(net9),
    .VGND(VGND),
    .VNB(VGND),
    .VPB(VPWR),
    .VPWR(VPWR),
    .X(Q[5]));
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
