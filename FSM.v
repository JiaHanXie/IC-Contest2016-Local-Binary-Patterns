`define		Reset_State		3'd0
`define		Read0_State		3'd1
`define		Read1_State		3'd2
`define		Compute_State	3'd3
`define		Write_State		3'd4
`define		Finish_State	3'd5
module FSM(
		input					reset,//1
		input					clk,//1
		output	wire	[13:0]	gray_addr,
		output	reg				gray_req,//1
		input					gray_ready,//1
		output	wire	[13:0]	lbp_addr,//14
		output	reg				lbp_valid,//1
		output	reg				finish,//1
		output	reg		[8:0]	En4Reg,//9
		output	reg				en4Out,//1
		output	reg				EN4Counter,//1
		input			[13:0]	counter);//14
//var====================================================================
	reg		[2:0]	state;
	reg		[2:0]	next_state;
	reg		[2:0]	next_Read0_State;
	reg		[3:0]	counter4read;
	wire	[3:0]	next_counter4read;
	reg		[6:0]	positionY;
	reg		[6:0]	positionX;
//====================================================================
//FSM
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			state<=3'd0;
		end else begin
			state<=next_state;
		end
	end
//Comb4FSM
	always@(*)begin
		case(state)
			`Reset_State:begin
				next_state=(gray_ready==1'b1)?`Read0_State:state;
			end
			`Read0_State:begin
				next_state=next_Read0_State;
			end
			`Read1_State:begin
				next_state=`Compute_State;
			end
			`Compute_State:begin
				next_state=`Write_State;
			end
			`Write_State:begin
				next_state=(counter=={7'd126,7'd126})?`Finish_State:`Read0_State;
			end
			`Finish_State:begin
				next_state=state;
			end
			default:begin
				next_state=state;
			end
		endcase
	end
//next_Read0_State
	always@(*)begin
		if(counter4read==4'd8)begin
			next_Read0_State=`Read1_State;
		end else begin
			next_Read0_State=state;
		end
	end
//counter4read
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			counter4read<=4'd0;
		end else if(state==`Read0_State)begin
			counter4read<=next_counter4read;
		end else begin
			counter4read<=4'd0;
		end
	end
//Comb4counter4read
	assign next_counter4read=counter4read+4'd1;
//====================================================================
//gray_addr  14
	always@(*)begin
		case(counter4read)
			4'd0,4'd3,4'd6:begin
				positionX=counter[6:0]-7'd1;
			end
			4'd1,4'd4,4'd7:begin
				positionX=counter[6:0];
			end
			4'd2,4'd5,4'd8:begin
				positionX=counter[6:0]+7'd1;
			end
			default:begin
				positionX=7'dx;
			end
		endcase
	end
	always@(*)begin
		case(counter4read)
			4'd0,4'd1,4'd2:begin
				positionY=counter[13:7]-7'd1;
			end
			4'd3,4'd4,4'd5:begin
				positionY=counter[13:7];
			end
			4'd6,4'd7,4'd8:begin
				positionY=counter[13:7]+7'd1;
			end
			default:begin
				positionY=7'dx;
			end
		endcase
	end
	assign gray_addr={positionY,positionX};
//gray_req
	always@(*)begin
		if(state==`Read0_State)begin
			gray_req=1'b1;
		end else begin
			gray_req=1'b0;
		end
	end
//lbp_addr  14
	assign lbp_addr=counter;
//lbp_valid
	always@(*)begin
		if(state==`Write_State)begin
			lbp_valid=1'b1;
		end else begin
			lbp_valid=1'b0;
		end
	end
//finish
	always@(*)begin
		if(state==`Finish_State)begin
			finish=1'b1;
		end else begin
			finish=1'b0;
		end
	end
//En4Reg
	always@(*)begin
		if(state==`Read0_State)begin
			case(counter4read)
				4'd0:begin
					En4Reg=9'b000000001;
				end
				4'd1:begin
					En4Reg=9'b000000010;
				end
				4'd2:begin
					En4Reg=9'b000000100;
				end
				4'd3:begin
					En4Reg=9'b000001000;
				end
				4'd4:begin
					En4Reg=9'b000010000;
				end
				4'd5:begin
					En4Reg=9'b000100000;
				end
				4'd6:begin
					En4Reg=9'b001000000;
				end
				4'd7:begin
					En4Reg=9'b010000000;
				end
				4'd8:begin
					En4Reg=9'b100000000;
				end
				default:begin
					En4Reg=9'd0;
				end
			endcase
		end else begin
			En4Reg=9'd0;
		end
	end
//en4Out
	always@(*)begin
		if(state==`Compute_State)begin
			en4Out=1'b1;
		end else begin
			en4Out=1'b0;
		end
	end
//EN4Counter
	always@(*)begin
		if(state==`Write_State)begin
			EN4Counter=1'b1;
		end else begin
			EN4Counter=1'b0;
		end
	end
//====================================================================
endmodule