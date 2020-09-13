//FPGA based digital alarm clock
//min-min : sec-sec

task display();
	
	//enable and shifting thing
	input [3:0] to_be_displayed[3:0]
	output reg [3:0] enable;
	
	integer i;
	while (1)
	begin
		enable = 4'b0000;
		for (i = 0; i<4; i = i+1)
		begin
			bcd_segment7(to_be_displayed[i],seg);
			enable[i] = 1;
			
		end
	end
	
	
endtask

task bcd_segment7();
	
	input [3:0] bcd;
	output reg [6:0] seg;
        case (bcd) //case statement
            0 : seg = 7'b0000001;
            1 : seg = 7'b1001111;
            2 : seg = 7'b0010010;
            3 : seg = 7'b0000110;
            4 : seg = 7'b1001100;
            5 : seg = 7'b0100100;
            6 : seg = 7'b0100000;
            7 : seg = 7'b0001111;
            8 : seg = 7'b0000000;
            9 : seg = 7'b0000100;
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : seg = 7'b1111111; 
        endcase

endtask

task count_pulses();

	output increment;

	reg [31:0] count;

		if (count < 50000000)
		begin
			count = count + 1;
			increment = 0;
		end
		else if (count == 50000000)
		begin
			count = 0;
			increment = 1;
			#5;
			increment = 0;
		else
		begin
			count = 0;
			increment = 0;
		end

endtask

task what_to_increment();
	
	output reg [3:0]to_be_displayed[3:0];
	if (to_be_displayed[0] < 9)
	begin
		to_be_displayed[0] = to_be_displayed[0] + 1;
	end
	else if (to_be_displayed[0] == 9)
	begin
		if (to_be_displayed[1] < 5)
		begin
			to_be_displayed[1] = to_be_displayed[1] + 1;
			to_be_displayed[0] = 0;
		end
		else if (to_be_displayed[1] == 5)
		begin
			to_be_displayed[0] = 0;
			to_be_displayed[1] = 0;
			if (to_be_displayed[2] < 9)
			begin
				to_be_displayed[2] = to_be_displayed[2] + 1;
				to_be_displayed[0] = 0;
				to_be_displayed[1] = 0;
			end
			else if (to_be_displayed[2] == 9)
			begin
				if (to_be_displayed[3] < 5)
				begin
					to_be_displayed[3] = to_be_displayed[3] + 1;
					to_be_displayed[0] = 0;
					to_be_displayed[1] = 0;
					to_be_displayed[2] = 0;
				end
				else if (to_be_displayed[3] == 5)
				begin
					to_be_displayed[0] = 0;
					to_be_displayed[1] = 0;
					to_be_displayed[2] = 0;
					to_be_displayed[3] = 0;
				end
			end
		end
	end
	always @(to_be_displayed)
	begin
		display(to_be_displayed);
	end
 	
endtask

module digital_clock(reset,to_be_displayed,clk);

	input reset,clk;
	output reg [3:0] to_be_displayed[3:0];
	reg increment;
	reg [3:0] bcd;
	reg [6:0] seg;

	always @(posedge clk)
	begin
		count_pulses(increment);
	end

	always @(posedge increment)
	begin
		what_to_increment(to_be_displayed);
	end
endmodule





