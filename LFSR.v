//LFSR - Linear feedback shift register

module random_no_gen #(parameter seed = 5'b00001)(random_no,clk,reset);

	output reg [4:0] random_no;
	input clk,reset;
	reg [4:0] im_data = seed;

	always @(posedge clk, negedge reset)
	begin
		if (!reset) im_data <= seed ;
		else
		begin
			im_data <= {im_data[2:0], im_data[3] ^ im_data[2]};
			random_no <= im_data;
		end
	end
endmodule
