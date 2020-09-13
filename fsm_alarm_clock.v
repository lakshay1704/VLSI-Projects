module alarm_clock(alarm_in,weekday,clk,alarm_out,reset);

	output reg alarm_out;
	input alarm_in,clk,weekday,reset;

	reg [1:0] pre_state;
	reg [1:0] next_state;

	parameter ASLEEP = 2'b00, AWAKE_IN_BED = 2'b01, AWAKE_AND_UP = 2'b10;

	always @(alarm_in,weekday)
	begin
		case (pre_state)
			ASLEEP : begin
					if (alarm_in == 0)
						begin
							next_state = ASLEEP;
							alarm_out = 0;
						end
					else
						begin
							next_state = AWAKE_IN_BED;
							alarm_out = 1;
						end
				 end
			AWAKE_IN_BED : begin
						if (alarm_in == 1)
							begin
								next_state = AWAKE_IN_BED;
								alarm_out = 1;
							end
						else
						begin
							if (weekday == 1)
							begin
								next_state = AWAKE_AND_UP;
								alarm_out = 0;
							end
						end
					end 
			AWAKE_AND_UP : begin
						next_state = AWAKE_AND_UP;
						alarm_out = 0;
					end
			default : begin
					next_state = 2'bxx;
					alarm_out = 0;
				  end
													
		endcase
	end

	always @(posedge clk)
	begin
		if (reset)
			pre_state = ASLEEP;	
		else
			pre_state = next_state;
	end
endmodule

module fsm_alarm_clock_tb();

	reg alarm_in,clk,weekday,reset;
	wire alarm_out;

	alarm_clock tb(alarm_in,weekday,clk,alarm_out,reset);

	initial
	begin
		clk = 0;
		reset = 0;
		#10 reset = 1;
		#10 reset = 0;
	end

	always #5 clk =~ clk;

	initial
	begin
		alarm_in = 0; weekday = 0;
		#20 alarm_in = 1;
		#20 alarm_in = 0;
		#20 alarm_in = 0; weekday = 1;
	end
endmodule


