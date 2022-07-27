module iiitb_bcdc_tb();
reg sRN,sCK, EN;
wire [7:0] sQ;
wire [3:0] sQu,sQz;

iiitb_bcdc test_bcd(.EN(EN),.RN(sRN),.CK(sCK),.Qu(sQu),.Qz(sQz),.Q(sQ));

initial begin
sRN=1'b0;
sCK=1'b1;
EN = 1;
$dumpfile("iiitb_bcdc.vcd");
$dumpvars(0);
$monitor($time,"sRN=%b,sCK=%b,sQ=%b,sQu=%b,sQz=%b",sRN,sCK,sQ,sQu,sQz);
#5 sRN=1'b1;
#700 $finish;
end
 always #3 sCK=~sCK;
endmodule
