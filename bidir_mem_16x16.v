/* module bi_dir_mem(data_in,data_out,addr,wr,rd,en);

	input  [7:0] data_in;
	input  [7:0] addr;
	output [7:0] data_out;
	
	wire [7:0] bus;

	input wr,rd,en;

	reg [7:0] mem [255:0];

	bufif1 bf1(data_out[7],mem[addr][7],rd);
	bufif1 bf2(data_out[6],mem[addr][6],rd);
	bufif1 bf3(data_out[5],mem[addr][5],rd);
	bufif1 bf4(data_out[4],mem[addr][4],rd);
	bufif1 bf5(data_out[3],mem[addr][3],rd);
	bufif1 bf6(data_out[2],mem[addr][2],rd);
	bufif1 bf7(data_out[1],mem[addr][1],rd);
	bufif1 bf8(data_out[0],mem[addr][0],rd);
	//assign data_out = mem[addr];
	always @(wr or data_in)
	begin
	if (wr)
	begin
		mem[addr] <= data_in;
	end
	end
	
endmodule

*/

 module bi_dir_mem(clk,data,addr,w_r,en);

	inout  [7:0] data;
	input  [7:0] addr;
	input 		clk;
	//w_r = 1 == read 

	input w_r,en;

	reg [7:0] mem [255:0];

	bufif1 bf1(data[7],mem[addr][7],w_r & en);
	bufif1 bf2(data[6],mem[addr][6],w_r & en);
	bufif1 bf3(data[5],mem[addr][5],w_r & en);
	bufif1 bf4(data[4],mem[addr][4],w_r & en);
	bufif1 bf5(data[3],mem[addr][3],w_r & en);
	bufif1 bf6(data[2],mem[addr][2],w_r & en);
	bufif1 bf7(data[1],mem[addr][1],w_r & en);
	bufif1 bf8(data[0],mem[addr][0],w_r & en);
	//assign data_out = mem[addr];
	always @(posedge clk)
	begin
	if (!w_r & en)
	begin
		mem[addr] <= data;
	end
	else
		mem[addr] <= mem[addr];
	end
	
endmodule
module bi_dir_tb();

	reg  [7:0] addr,data_in;
	wire [7:0] data;
	reg w_r,en,clk;

	integer i;

	bufif0 bf00(data[0],data_in[0],w_r & en);
	bufif0 bf01(data[1],data_in[1],w_r & en);
	bufif0 bf02(data[2],data_in[2],w_r & en);
	bufif0 bf03(data[3],data_in[3],w_r & en);
	bufif0 bf04(data[4],data_in[4],w_r & en);
	bufif0 bf05(data[5],data_in[5],w_r & en);
	bufif0 bf06(data[6],data_in[6],w_r & en);
	bufif0 bf07(data[7],data_in[7],w_r & en);

	bi_dir_mem tb(clk,data,addr,w_r,en);

	initial
	begin
		en = 1;
		clk = 0;
		for(i=0;i<256;i=i+1)
		begin	
			#2
			addr = i;
			data_in = i; w_r = 0;
		
		end
		for(i=0;i<256;i=i+1)
		begin
		#2
		w_r = 1;
					addr = i;
$display("address ---> %0d,   data_io --->  %0b,   read ---> %0d",addr,data,w_r );
		end
	end

always #1 clk = ~clk;
endmodule


/*
//test bench

module bi_dir_tb();

	reg  [7:0] data_in,addr;
	wire [7:0] data_out;
	reg wr,rd,en;

	integer i;

	bi_dir_mem tb(data_in,data_out,addr,wr,rd,en);

	initial
	begin
		for(i=0;i<256;i=i+1)
		begin	
			addr = i;
			data_in = i; rd = 0; wr = 1;
			#2 wr = 0;
		end
		for(i=0;i<256;i=i+1)
		begin
			#2 addr = i;
			wr = 0;
			rd = 1;
			$display("address ---> %0d,   data_out --->  %0b,   read ---> %0d",addr,data_out,rd );
		end
	end
endmodule

*/