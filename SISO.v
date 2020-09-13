//Serial in Serial Out

//slide 169

module siso(clk,data,out,reset,load);

	input clk,reset,load;
	input data;
	reg [3:0] tmp;
	output reg out;

	always @(posedge clk)
		begin
		if (reset)
		begin
			tmp <= 0;
		end
		else if (load)
		begin
			
			tmp <= {tmp[2:0],data}; // left shifting bit by one
		end
		else
		begin
			out <= tmp[3];
			tmp <= tmp << 1;
		end
	end

endmodule

module siso_tb();

	reg clk,reset,load;
	reg data;
	wire out;

	siso s1(clk,data,out,reset,load);
	
	initial
	begin
		clk = 0;
		reset = 0;
		#5 reset = 1;
		#20 reset = 0;
		load = 0;
		#20 load = 1;
		#50 load = 0;
	end

	always #5 clk = ~clk; // clock of time period 10 time units

	initial
	begin
		#20 data = 1;
		#20 data = 0;
		#20 data = 1;
		#20 data = 0;
		
	
	end
endmodule


