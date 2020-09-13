module dff_asyn_reset_exc(d,clk,q,qbar,reset);

	input clk;
	input d;
	input reset;
	output reg q, qbar;

	always @(posedge clk or negedge reset)
	begin
		if (!reset)
			q <= 0;
		else 
		begin
			q <= d;
			qbar <= ~q;
		end
	end
endmodule

module dff_asyn_reset_exc_tb();

	reg d,clk,reset;
	wire q,qbar;

	dff_asyn_reset_exc tb(d,clk,q,qbar,reset);

	initial
	begin
		clk = 0;
		reset = 0;
		#20 reset = 1;
	end

	always #5 clk = ~clk;

	initial
	begin
		#10 d = 1;
		#10 d = 0;
		#10 d = 0;
	end	
endmodule


