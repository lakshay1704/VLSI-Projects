//pipo parallel in parallel out

module pipo(data_in,data_out,reset,load,clk);

	input clk,reset,load;
	input [3:0] data_in;
	output reg [3:0] data_out;
	reg [3:0] tmp;

	always @(posedge clk)
	begin
		if (reset)
			tmp[3:0] = 0;
		else if (load)
			tmp <= data_in;
		else
			data_out <= tmp;			
	end

endmodule


module pipo_tb();

	reg [3:0] data_in;
	reg clk,reset,load;
	wire [3:0] data_out;
	
	pipo p1(data_in,data_out,reset,load,clk);

	initial
	begin
		clk = 0;
		reset = 1;
		#10 reset = 0;
		load = 0;
		#10 load = 1;
		#20 load = 0;
	end

	always #5 clk = ~clk;

	initial
	begin
		data_in = 4'b0010;
		#50 data_in = 4'b0011;
	end
endmodule
