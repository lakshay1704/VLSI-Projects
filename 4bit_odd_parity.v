//4 bit odd parity generator xnor gate
//even parity generator xor gate
module odd_parity(data,parity);

	 input [3:0] data;
	 output parity;

	assign parity = ~(^data);

endmodule

module odd_parity_tb();

	reg [3:0] data;
	wire parity;

	odd_parity op(data,parity);

	initial begin
		data = 4'b1100;
		#20 data = 4'b1011;
	end
endmodule










/*
module parity_checker_odd(parity,data,out);

	input parity;
	input [3:0] data;
	output reg out; //high if matched else low
	wire tmp;

		assign tmp = ^data;
		initial
		begin
		if (tmp == parity)
			 out = 1;
		else 
			out = 0;
		end
	
endmodule

module parity_checker_odd_tb();

	wire out;
	reg [3:0] data;
	reg parity;

	parity_checker_even tb(parity,data,out);
	initial
	begin
		data = 4'b0001; parity = 0;
		#20 data = 4'b1100; parity = 1ma; 
	end
*/
