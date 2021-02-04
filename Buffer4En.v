module Buffer4En(
 		input				reset,
 		input				clk,
 		input		[8:0]	datain,//9
 		output	reg	[8:0]	dataout);//9
	always@(negedge clk or posedge reset)begin
		if(reset)begin
			dataout<=9'd0;
		end else begin
			dataout<=datain;
		end
	end
endmodule