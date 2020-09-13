module dff_sync_reset(d,clk,q,qbar,reset);

	output reg q,qbar;
	input clk,reset;
	input d;

	always @(posedge clk)
	begin
		if(reset)
			q <= 0;
		else 
		 begin
			q <= d;
			qbar <= ~q;
	   end
	   end

endmodule

module dff_sync_reset_tb();

	reg d,clk,reset;
	wire q,qbar;

	dff_sync_reset tb(d,clk,q,qbar,reset);

	always #10 clk = ~clk;

	initial
	begin
		clk = 0;
		reset = 1;
		#10 reset = 0;
	end

	initial
	begin
		#20 d = 1;
		#20 d = 0;
	end

endmodule


