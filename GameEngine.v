
module GameEngine(GRBSeq,Cycle,Go,clk,reset);
	output reg 	[119:0] GRBSeq;
	output 	Cycle;
	input	Go, clk, reset;

	reg [3:0]	S, nS;
	reg [26:0] 	Count, nCount;
	reg [2:0] 	lvl, nlvl;
	reg [23:0] color;
	parameter OFF = 24'h000000, RED = 24'h00FF00, ORANGE = 24'h66FF00, GREEN = 24'hFF0000;
	parameter CYAN = 24'hFF00FF, BLUE = 24'h0000FF, VIOLET = 24'h0066FF;

	always @(posedge clk)
		if(reset) begin
		    Count <= 0;
			S <= 0; 
			lvl <= 0; end
		else if (Count [24]) begin
			S <= nS;
			Count <= nCount; end
		else begin
			S <= S;
			Count <= nCount; 
			lvl <= nlvl; end
			
	always @(Count)
    if(Count [24])
		nCount = 0;
	else
		nCount = Count+1;
		
	always @(lvl, Go, S)
		if(Go)
			nlvl = (((S!=4'b0010)||(S!=4'b0110)) ? 0 : lvl+1);
		else
			nlvl = lvl;

	always @(S, Go) 
		case(S)
			4'b0000: nS = (Go ? S : S+1);
			4'b0001: nS = (Go ? S : S+1);
			4'b0010: nS = (Go ? 4'b1001 : S+1);
			4'b0011: nS = (Go ? S : S+1);
			4'b0100: nS = (Go ? S : S+1);
			4'b0101: nS = (Go ? S : S+1);
			4'b0110: nS = (Go ? 4'b1001 : S+1);
			4'b0111: nS = (Go ? S : 4'b0000);
			default: nS = 4'b0000;
		endcase
	
	always @(S, color)
		case(S)
			4'b0000: GRBSeq = {RED,color,OFF,color,color};
			4'b0001: GRBSeq = {color,RED,OFF,color,color};
			4'b0010: GRBSeq = {color,color,RED,color,color};
			4'b0011: GRBSeq = {color,color,OFF,RED,color};
			4'b0100: GRBSeq = {color,color,OFF,color,RED};
			4'b0101: GRBSeq = {color,color,OFF,RED,color};
			4'b0110: GRBSeq = {color,color,RED,color,color};
			4'b0111: GRBSeq = {color,RED,OFF,color,color};
			4'b1000: GRBSeq = {OFF,OFF,OFF,OFF,OFF};
			4'b1001: GRBSeq = {color,color,color,color,color};
			default: GRBSeq = {OFF,OFF,OFF,OFF,OFF};
		endcase
		
	always @ (lvl)
		case (lvl)
			3'b000: color = ORANGE;
			3'b001: color = GREEN;
			3'b010: color = CYAN;
			3'b011: color = BLUE;
			3'b100: color = VIOLET;
			default: color = OFF;
		endcase
	
	assign 	Cycle = Count[24];
endmodule

