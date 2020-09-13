//d latch using nand gates

module d_latch_nand(d,en,q,q_bar);

	input en;
	input d;
	output wire q,q_bar;
	wire w1,w2;

	nand n0(w1,d,en);
	nand n1(w2,en,~d);
	nand n2(q,w1,q_bar);
	nand n3(q_bar,w2,q);

endmodule

//test bench
module d_latch_nand_tb();

	reg en,d;
	wire q,q_bar;

	d_latch_nand tb(d,en,q,q_bar);

	initial
	begin
		en = 0; d = 0;
		#10 en = 1; d = 0;
		#10 en = 1; d = 1;
		#10 en = 1; d = 0;
		#10 en = 0;
		#10 en = 1; d = 1;
	
	end
endmodule

