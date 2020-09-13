//parallel in shift out

module piso(TXData,shift,load,data);

	input [7:0] TXData;
	input shift,load;
	output reg data;
	
	reg [7:0] tmp;

	always @(shift or load or TXData) 
	//always @(baud)
	begin
		if (load)
		begin
			tmp <= TXData;
		end
		else if (shift)
		begin
			data <= tmp[0];
			tmp <= tmp >> 1;
		end
		else
		begin
			data <= tmp[0];
		end
	end

endmodule
