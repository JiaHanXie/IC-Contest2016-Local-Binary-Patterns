`timescale 1ns/10ps
module LBP ( clk, reset, gray_addr, gray_req, gray_ready, gray_data, lbp_addr, lbp_valid, lbp_data, finish);
input						clk;
input						reset;
output	wire	[13:0]		gray_addr;
output	wire				gray_req;
input						gray_ready;
input			[7:0]		gray_data;
output	wire	[13:0]		lbp_addr;
output	wire				lbp_valid;
output	wire	[7:0]		lbp_data;
output	wire				finish;
//====================================================================
	wire	[8:0]	En4Reg;
	wire	[8:0]	EN4Reg_;
	wire	[7:0]	Reg0;
	wire	[7:0]	Reg1;
	wire	[7:0]	Reg2;
	wire	[7:0]	Reg3;
	wire	[7:0]	Reg4;
	wire	[7:0]	Reg5;
	wire	[7:0]	Reg6;
	wire	[7:0]	Reg7;
	wire	[7:0]	Reg8;
	wire	[7:0]	Lbp;
	wire			en4Out;
//====================================================================
	Register Register(
		.reset(reset),
		.clk(clk),
		.Data(gray_data),//8
		.En(En4Reg),//9
		.Reg0(Reg0),//8
		.Reg1(Reg1),//8
		.Reg2(Reg2),//8
		.Reg3(Reg3),//8
		.Reg4(Reg4),//8
		.Reg5(Reg5),//8
		.Reg6(Reg6),//8
		.Reg7(Reg7),//8
		.Reg8(Reg8));//8

	PE PE(
		.Reg0(Reg0),//8
		.Reg1(Reg1),//8
		.Reg2(Reg2),//8
		.Reg3(Reg3),//8
		.Reg4(Reg4),//8
		.Reg5(Reg5),//8
		.Reg6(Reg6),//8
		.Reg7(Reg7),//8
		.Reg8(Reg8),//8
		.LBP(/*Lbp*/lbp_data));//8

	Control_Unit CTL(
		.reset(reset),
		.clk(clk),
		.gray_addr(gray_addr),//14  out
		.gray_req(gray_req),//1  out
		.gray_ready(gray_ready),//1  input
		.lbp_addr(lbp_addr),//14  output
		.lbp_valid(lbp_valid),//1  output
		.finish(finish),//1  output
		.En4Reg(En4Reg),//9  output
		.en4Out(en4Out));//1  output
//====================================================================
endmodule
`include "Register.v"
`include "PE.v"
`include "Control_Unit.v"