
module tff_sync_reset(t,clk,q,reset);

	output reg q;
	input clk,reset;
	input t;

	always @(posedge clk)
	begin
		if(reset)
			q <= 0;
		else 
		begin
			if (t == 0)
				q <= q;
			else
			begin
				if (q == 0)
					q <= 1;
				else
					q <= 0;
			end
	   	end
	   end

endmodule

module tff_sync_reset_tb();

	reg t,clk,reset;
	wire q;

	tff_sync_reset tb(t,clk,q,reset);

	always #10 clk = ~clk;

	initial
	begin
		clk = 0;
		reset = 1;
		#10 reset = 0;
	end

	initial
	begin
		#20 t = 1;
		#20 t = 0;
		#20 t = 1;
		#20 t = 0;
		#20 t = 1;
		#20 t = 0;
	end

endmodule

