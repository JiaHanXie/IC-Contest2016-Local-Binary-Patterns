module Output_Buffer(
	input				reset,
	input				clk,
	input				en,
	input		[7:0]	Data_in,
	output	reg	[7:0]	Data_out);
//====================================================================
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Data_out<=8'd0;
		end else if(en)begin
			Data_out<=Data_in;
		end
	end
endmodule