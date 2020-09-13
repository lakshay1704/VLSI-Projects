//4 bit ripple carry adder using full adder instantiation
//Gate level modelling of full adder circuit

module fulladder(sum,cout,A,B,cin);
	
	input A,B,cin;
	output sum,cout;
	wire w1,w2,w3;

	xor x1(w1,A,B);
	xor x2(sum,w1,cin);
	and a1(w2,A,B);
	and a2(w3,w1,cin);
	or o1(cout,w2,w3);

endmodule

module ripplecarry(sum, cout, a, b, cin);

	input [3:0] a,b;
	output [3:0] sum;
	input cin;
	output cout;
	wire w1,w2,w3;

	fulladder f0(sum[0],w1,a[0],b[0],cin);
	fulladder f1(sum[1],w2,a[1],b[1],w1);
	fulladder f2(sum[2],w3,a[2],b[2],w2);
	fulladder f3(sum[3],cout,a[3],b[3],w3);

endmodule
