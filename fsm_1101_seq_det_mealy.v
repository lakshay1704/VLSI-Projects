module fsm_1101(x,clk,reset,y);

	input x,clk,reset;
	output reg y;
	
	reg [2:0] pre_state;
	reg [2:0] next_state;

	parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b101;

	always @(x,pre_state)
	begin
		case(pre_state)
			E : begin
				next_state = x ? A : E;
				y = 0;
			    end
			A : begin
				next_state = x ? B : E;
				y = 0;
			    end
			B : begin
				next_state = x ? B : C;
				y = 0;
			    end
			C : begin
				next_state = x ? D : E;
				y = x ? 1 : 0;
			    end
			D : begin
				next_state = x ? B : E;
				y = 0;
			    end
			default begin
					next_state = 3'bxxx;
					y = 1'bx;
				end
			
		endcase
	end

	always @(posedge clk)
	begin
		if (reset)
			pre_state = E;
		else 
			pre_state = next_state;
	end
	
endmodule

//test bench

module fsm_1101_tb();

	reg x,clk,reset;
	wire y;

	fsm_1101 tb(x,clk,reset,y);

	initial
	begin
		clk = 0;
		reset = 1;
		#20 reset = 0;
	end

	always #5 clk = ~clk;

	initial
	begin	
		#23 x = 1;
		#5 x = 1;
		#5 x = 1;
		#5 x = 1;
		#5 x = 0;
		#5 x = 1;
		#5 x = 0;
		#5 x = 1;
		#5 x = 0;
		#5 x = 1;
		#5 x = 1;
		#5 x = 1;
	end
endmodule


