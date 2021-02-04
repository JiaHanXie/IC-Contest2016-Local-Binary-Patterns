`include "FSM.v"
`include "Counter.v"
module Control_Unit(
		input							reset,
		input							clk,
		output		wire	[13:0]		gray_addr,//14  out
		output		wire				gray_req,//1  out
		input							gray_ready,//1  input
		output		wire	[13:0]		lbp_addr,//14  output
		output		wire				lbp_valid,//1  output
		output		wire				finish,//1  output
		output		wire	[8:0]		En4Reg,//9  output
		output		wire				en4Out);//1  output
//====================================================================
//var
	wire			EN4Counter;
	wire	[13:0]	counter;
//FSM
	FSM FSM(
		.reset(reset),//1
		.clk(clk),//1
		.gray_addr(gray_addr),
		.gray_req(gray_req),//1
		.gray_ready(gray_ready),//1
		.lbp_addr(lbp_addr),//14
		.lbp_valid(lbp_valid),//1
		.finish(finish),//1
		.En4Reg(En4Reg),//9
		.en4Out(en4Out),//1
		.EN4Counter(EN4Counter),//1
		.counter(counter));//14
//counter
	Counter Counter(
		.reset(reset),
		.clk(clk),
		.EN(EN4Counter),
		.counter(counter));//14

endmodule