module mux_4x1_gates(s0,s1,a,b,c,d,out);
  
  input s0,s1,a,b,c,d; 
  output wire out;
  wire y1,y2,y3,y4; 

  and a1(y1,a,~s0,~s1); 
  and a2(y2,b,~s0,s1); 
  and a3(y3,c,s0,~s1); 
  and a4(y4,d,s0,s1); 

  or o1(out,y1,y2,y3,y4); 

endmodule

//teset bench 

module mux_4x1_gates_tb();

	reg s0,s1,a,b,c,d;
	wire out;

	mux_4x1_gates tb(s0,s1,a,b,c,d,out);

	initial
	begin
		a = 1; b = 0; c = 1; d = 0;
		s0 = 0; s1 = 0;
		#10 s0 = 0; s1 = 1;
		#10 s0 = 1; s1 = 0;
		#10 s0 = 1; s1 = 1;
	end
endmodule

