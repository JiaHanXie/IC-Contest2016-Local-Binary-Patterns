module Register(
	input			reset,
	input			clk,
	input		[7:0]	Data,
	input		[8:0]	En,
	output	reg	[7:0] 	Reg0,
	output	reg	[7:0] 	Reg1,
	output	reg	[7:0] 	Reg2,
	output	reg	[7:0] 	Reg3,
	output	reg	[7:0] 	Reg4,
	output	reg	[7:0] 	Reg5,
	output	reg	[7:0] 	Reg6,
	output	reg	[7:0] 	Reg7,
	output	reg	[7:0] 	Reg8);
//====================================================================
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Reg0<=8'd0;
		end else if(En[0])begin
			Reg0<=Data;
		end
	end
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Reg1<=8'd0;
		end else if(En[1])begin
			Reg1<=Data;
		end
	end
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Reg2<=8'd0;
		end else if(En[2])begin
			Reg2<=Data;
		end
	end
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Reg3<=8'd0;
		end else if(En[3])begin
			Reg3<=Data;
		end
	end
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Reg4<=8'd0;
		end else if(En[4])begin
			Reg4<=Data;
		end
	end
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Reg5<=8'd0;
		end else if(En[5])begin
			Reg5<=Data;
		end
	end
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Reg6<=8'd0;
		end else if(En[6])begin
			Reg6<=Data;
		end
	end
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Reg7<=8'd0;
		end else if(En[7])begin
			Reg7<=Data;
		end
	end
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Reg8<=8'd0;
		end else if(En[8])begin
			Reg8<=Data;
		end
	end
endmodule