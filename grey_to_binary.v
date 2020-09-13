//Gate level modelling of 3 bit grey to binary

module g2b3bit(b,g);
	input [2:0] g;
	output [2:0] b;

	buf bf1(b[2],g[2]); 
	xor x1(b[1],b[2],g[1]);
	xor x2(b[0],b[1],g[0]);

endmodule

//test bench

module g2b3bit_tb();

	reg [2:0] g;
	wire [2:0] b;

	g2b3bit tb(b,g);

	initial
	begin
		#10 g = 3'b011;
		#10 g = 3'b101;
	end
endmodule


