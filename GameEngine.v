// Code your design here

module GameEngine1(GRBout,Cycle,Flag,Go,clk,reset,Run,Lvl);
	output reg 	[119:0] GRBout;
	output 		Cycle;
	output reg	Flag;
	input 		[2:0] Lvl; 
	input		Go, clk, reset, Run;

	reg [3:0]	S, nS;
	reg [26:0] 	Count, nCount;
	reg [23:0] color;
	parameter OFF = 24'h000000, RED = 24'h00FF00, ORANGE = 24'h66FF00, GREEN = 24'hFF0000;
	parameter CYAN = 24'hFF00FF, BLUE = 24'h0000FF, VIOLET = 24'h0066FF;

	always @(posedge clk)
		if(reset) begin
		    Count <= 0;
			S <= 0; end
	else if (Go || Count [24]) begin
			S <= nS;
			Count <= nCount; end
		else begin
			S <= S;
			Count <= nCount; end
			
	always @(*)
		if(Count [24])
			nCount = 0;
		else if (Run)
			nCount = Count+1;
		else
			nCount = Count;

	always @(*) 
		case(S)
			4'b0000: begin 	GRBout = {RED,   color, OFF,   color, color}; 
							nS = (Go ? S : S+1); end
			4'b0001: begin 	GRBout = {color, RED,   OFF,   color, color}; 
							nS = (Go ? S : S+1); end
			4'b0010: begin 	GRBout = {color, color, RED,   color, color}; 
							nS = (Go ? 4'b1000 : S+1); end
			4'b0011: begin 	GRBout = {color, color, OFF,   RED,   color}; 
							nS = (Go ? S : S+1); end
			4'b0100: begin 	GRBout = {color, color, OFF,   color, RED}; 
							nS = (Go ? S : S+1); end
			4'b0101: begin 	GRBout = {color, color, OFF,   RED,   color}; 
							nS = (Go ? S : S+1); end
			4'b0110: begin 	GRBout = {color, color, RED,   color, color}; 
							nS = (Go ? 4'b1000 : S+1); end
			4'b0111: begin 	GRBout = {color, RED,   OFF,   color, color}; 
							nS = (Go ? S : 4'b0000); end
			4'b1000: begin 	GRBout = {color, color, color, color, color};
							nS = (Run ? 4'b0000 : 4'b1000); end 
			default: begin 	GRBout = {OFF,   OFF,   OFF,   OFF,   OFF}; 
							nS = 4'b0000; end
		endcase
		
	always @ (Lvl)
		case (Lvl)
			3'b000: 	color = ORANGE;
			3'b001: 	color = GREEN;
			3'b010: 	color = CYAN;
			3'b011: 	color = BLUE;
			3'b100: 	color = VIOLET;
			default: 	color = OFF;
		endcase
		
	always @(*)
	   if (S==4'b1000)
	       Flag = 1'b1;
	   else
	       Flag = 1'b0;
	               
	assign 	Cycle = Count[24];
endmodule

