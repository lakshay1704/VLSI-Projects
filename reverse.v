//reversing a  number

module reverse(in,out);
	input [99:0]in;
	output reg [99:0]out;
	
	//reg i = 100;
	//repeat(i)
	//	begin
	//		assign in[0] = in[99];
	//		assign in = in>>1;
	//		out[0] = in[0];
	//		out = out>>1;
	//	end

	initial
	begin
	out = in;
	repeat(100)
		begin
			 out <= out>>1;
			 out[99] <= out[1];
		end
	end
endmodule


module reverse_tb();
	
	reg [99:0]in;
	wire [99:0]out;

	reverse tb(in,out);

	initial
	begin
		in = 1'b0;
		#5;
		in = 100'h1010101010101010101010111;
	end
endmodule
