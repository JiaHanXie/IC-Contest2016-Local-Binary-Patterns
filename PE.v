module PE(
	input			[7:0]	Reg0,
	input			[7:0]	Reg1,
	input			[7:0]	Reg2,
	input			[7:0]	Reg3,
	input			[7:0]	Reg4,
	input			[7:0]	Reg5,
	input			[7:0]	Reg6,
	input			[7:0]	Reg7,
	input			[7:0]	Reg8,
	output	wire	[7:0]	LBP);
//====================================================================
	assign LBP[0]=(Reg0>=Reg4);
	assign LBP[1]=(Reg1>=Reg4);
	assign LBP[2]=(Reg2>=Reg4); 
	assign LBP[3]=(Reg3>=Reg4);
	assign LBP[4]=(Reg5>=Reg4);
	assign LBP[5]=(Reg6>=Reg4);
	assign LBP[6]=(Reg7>=Reg4);
	assign LBP[7]=(Reg8>=Reg4);

endmodule