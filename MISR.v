//MISR multiple input signatire register

module misr #(parameter [3:0] poly = 0)(clk,rst,d_in,d_out);
	
	input clk,rst;
	input [3:0] d_in;
	output reg [3:0] d_out;

	always @(posedge clk)
	begin
		if (rst) d_out = 4'b0000;
		else d_out = d_in ^ ({4{d_out[0]}} & poly) ^ {1'b0,d_out[3:1]};
	end
endmodule
