//finite state machine
//car indicators

module car_indicator(clk,reset,E,L,R,next_state);

	output reg [1:0] next_state;
	input clk,reset,E,L,R;

	reg [1:0] pre_state;

	parameter NO_IND = 2'b00, RIGHT_IND = 2'b01, LEFT_IND = 2'b10, EMERGENCY = 2'b11;
	//parameter L = 1'b0, E = 1'b1;

	always @(E,L,R,pre_state)
	begin
		case (pre_state)
			NO_IND : begin
					if (L)
						begin
							next_state = LEFT_IND;
							repeat(5)
								@(posedge clk);
							next_state = NO_IND;
						end
					else if (R)
						begin
							next_state = RIGHT_IND;
							repeat(5)
								@(posedge clk);
							next_state = NO_IND;
							
						end
					else
						next_state = NO_IND;
				 end
			RIGHT_IND : begin
					    if (L)
						begin
							next_state = LEFT_IND;
							repeat(5)
								@(posedge clk);
							next_state = NO_IND;
						end
					   else	if (R)begin
							next_state = RIGHT_IND;
							repeat (5)
								@(posedge clk);
							next_state = NO_IND; end
					else
						next_state = NO_IND;
				    end 
			LEFT_IND : begin if (L)
						begin
							next_state = LEFT_IND;
							repeat(5)
								@(posedge clk);
							next_state = NO_IND;
						end
					else if (R)
						begin
							next_state = RIGHT_IND;
							repeat(5)
								@(posedge clk);
							next_state = NO_IND;
							
						end
					else
						next_state = NO_IND;
					end
			EMERGENCY : begin if (L)
						begin
							next_state = LEFT_IND;
							repeat(5)
								@(posedge clk);
							next_state = NO_IND;
						end
					else if (R)
						begin
							next_state = RIGHT_IND;
							repeat(5)
								@(posedge clk);
							next_state = NO_IND;
							
						end
						else next_state = EMERGENCY;
					end

			endcase
	end

	always @(posedge clk)
	begin
		if (reset) begin
			pre_state = NO_IND;
		 end
		else if (E)
			pre_state = EMERGENCY;
		else
			pre_state = next_state;
	end
endmodule

//test bench

module fsm_car_indicator_tb();

	reg clk,reset,E,L,R;
	wire [1:0] next_state;

	car_indicator tb(clk,reset,E,L,R,next_state);
		
	initial
	begin
		clk = 0;
		reset = 0;
		#5 reset = 1;
		#20 reset = 0;
	end

	always #10 clk = ~clk;

	initial
	begin
		E = 0;
		R = 0;
		L = 0;
		#25 E = 1;
		#50 L = 1;
		#20 E = 0;
		#50 R = 1;
		#50 L = 0;
		#50 R = 0;
	end
endmodule


