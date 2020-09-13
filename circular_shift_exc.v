module circular_shift(q,d,reset,clk,load);

	input reset,clk,load;
	input [3:0] d;
	output reg [3:0] q;

	always @(posedge clk or posedge reset or posedge load)
	begin
		if (load)
			q <= d;
		else if (reset)
			q <= 0;
		else begin
			q <= q << 1;
			q[0] <= q[3]; end
	end
endmodule

//test bench
module circular_shift_tb();

	reg reset,clk,load;
	reg [3:0] d;
	wire [3:0] q;

	circular_shift tb(q,d,reset,clk,load);
	
	initial
	begin
		clk = 0;
		reset = 1;
		#20 reset = 0;
		load = 1;
		#30 load = 0;
	end

	always #5 clk = ~clk;

	initial
	begin	
		#25 d = 4'b0101;
	end
endmodule


