module Counter(
	input						reset,
	input						clk,
	input						EN,
	output		wire	[13:0]	counter);
	reg					[6:0]	position_X;
	reg					[6:0]	position_Y;
	reg					[6:0]	next_position_X;
	reg					[6:0]	next_position_Y;
//====================================================================
	assign counter={position_Y,position_X};

	always@(posedge clk or posedge reset)begin
		if(reset)begin
			position_X<=7'd1;
		end else if(EN)begin
			position_X<=next_position_X;
		end
	end

	always@(posedge clk or posedge reset)begin
		if(reset)begin
			position_Y<=7'd1;
		end else if(EN)begin
			position_Y<=next_position_Y;
		end
	end

	always@(*)begin
		if(position_X==7'd126)begin
			if(position_Y==7'd126)begin
				next_position_X=position_X;
			end else begin
				next_position_X=7'd1;
			end
		end else begin
			next_position_X=position_X+7'd1;
		end
	end

	always@(*)begin
		if((position_X==7'd126)&&(position_Y!=7'd126))begin
			next_position_Y=position_Y+7'd1;
		end else begin
			next_position_Y=position_Y;
		end
	end

endmodule