//t flip flop usinf latches

module tff_latch(t,q,set,reset,en,clk);

	input t,reset,set,en,clk;
	output reg q;

	always @(posedge clk)
	begin
	if (en)
	begin
		if (set)
			q <= 0;
		if (reset)
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
	end
	
endmodule

//test bench
module tff_latch_tb();

	reg t,reset,set,en,clk;
	wire q;

	tff_latch tb(t,q,set,reset,en,clk);

	initial
	begin
		clk = 0;
		en = 1;
		#5 reset = 1;
		#5 set = 1;
		#5 reset = 0;
		#5 set = 0;
	end

	always #5 clk = ~clk;

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

