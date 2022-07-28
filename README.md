# iiitb_bcdc - 8 bit bcd counter
## Description <br />
The 8 bit Binary Coded Decimal (BCD) Counter is a counter that counts 100 digits starting from 0 to 99.BCD is an encoding where each digit in a decimal number is represented in the form of bits(usually 4 bits). For example the number 89 can be represented as 10001001 in BCD as 1000 is the BCD representation of 8 and 1001 is the BCD representation of 9.BCD code is also known as 8421 BCD code. This also makes it a weighted code which implies that each bit in the four bit groups representing each decimal digit has a specific weight. As compared to prevalent binary positioning system it’s easy to convert it into human readable representation with the drawback of slight increase in complexity of the circuits.<br />
<br />
The BCD Counter finds application in clock production, clock division, used in minimal power cmos circuit, implemented in frequency counting circuits.<br />
<br />
The 8 bit BCD counter counts from 00000000(0) to 10011001(99). After that it resets to initial value 0 and the process is repeated again. The Verilog code contains 8 bit output and clock, reset & enable as input. The 8 bit BCD counter block diagram is shown in Fig1 and the port list are given in Table1.In Fig2 output waveform for few clock cycles is displayed.<br />
<br />
## Fig1 <br />
![Fig1](./blockdiagram.png)
<br />
<br />
## Table1 <br />
![Table1](./Table1.png)
<br />
<br />
## Fig2 <br />
![Fig2](./waveform.png)
<br />

steps for functional-simulation:-<br />
1.To clone the respository and download the netlist files for simulation, enter the following commands in your terminal<br />
 $ sudo apt install -y git<br />
 $ git clone https://github.com/Sritam519/iiitb_bcdc.git<br />
2.To run the simulation use the following commands:- <br />
 $ cd iiitb_bcdc<br />
 $ iverilog iiitb_bcdc.v iiitb_bcdc_tb.v<br />
 $ gtkwave iiitb_bcdc.vsd<br />
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
 
 
 

