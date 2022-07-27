module iiitb_bcdc(RN,EN,CK,Qz,Qu,Q);
	input RN,CK,EN;
	output [3:0]Qz,Qu;
	output [7:0]Q;
	reg [3:0] Qz1,Qu1;
	always@(posedge CK or negedge RN)
		begin
		if(!RN)
			begin
			Qz1=4'b0;
			Qu1=4'b0;
			end
		else if(EN)
			begin
			if({Qz1,Qu1}==8'b10011001)
				begin
				Qz1=4'b0;
				Qu1=4'b0;
				end
			else if(Qu1==4'b1001)
				begin
				Qu1=4'b0;
				Qz1=Qz1+1;
				if(Qz1==4'b1010)
					Qz1=4'b0;
				end
			else Qu1=Qu1+1;
			end
		end
	assign Q={Qz1,Qu1};
	assign Qu=Qu1;
	assign Qz=Qz1;
endmodule

