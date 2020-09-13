//d latch using nor gates

module d_latch_nor(d,en,q,q_bar);

	input en;
	input d;
	output wire q,q_bar;
	wire w1,w2;

	nor n0(w1,d,en);
	nor n1(w2,en,~d);
	nor n2(q,w1,q_bar);
	nor n3(q_bar,w2,q);

endmodule

//test bench
module d_latch_nor_tb();

	reg en,d;
	wire q,q_bar;

	d_latch_nor tb(d,en,q,q_bar);

	initial
	begin
		en = 1; d = 0;
		#10 en = 0; d = 0;
		#10 en = 0; d = 1;
		#10 en = 0; d = 0;
	
	end
endmodule

