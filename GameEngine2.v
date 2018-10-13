
module GameEngine2(GRBSeq,Refresh,Run,Lvl,Go,clk,reset,GRBin,Cycle,Flag);
	output reg 	[119:0] GRBSeq;
	output 	Refresh, Run, Lvl;
	input	Go, clk, reset, Cycle;
	input 	[119:0] GRBin;
	input   Flag;

	reg [1:0] S, nS;
	reg [28:0] 	Count, nCount;
	reg [2:0] 	Lvl, nLvl;
	reg [23:0] color;
	parameter PLAY = 2'b00, FLASH = 2'b01, WIN = 2'b10;
	parameter OFF = 24'h000000_000000_000000_000000_000000;

	always @(posedge clk)
		if (reset) begin
		    Count <= 0;
			S <= 0; 
			Lvl <= 0; end
		else begin
			S <= nS;
			Count <= nCount; 
			Lvl <= nLvl; end
			
	always @(*)
		if (Count[28]) begin
		  if (Flag)
			 nLvl = Lvl+1;
		  else
		      nLvl = 0; end
		else
			nLvl = Lvl;
			
	always @(*)
		if(S!=FLASH || Count[28])
			nCount = 0;
	    else if (S==FLASH)
			nCount = Count+1;
		else
			nCount = Count;
			
	always @(*)
		if (S==PLAY) begin
			if (Lvl==3'b101) 
				nS = WIN;
			else
				nS = (Go ? FLASH : PLAY); end
		else if (S==FLASH)
			nS = (Count[28] ? PLAY : FLASH);
		else
			nS = (Go ? PLAY : WIN);
		
	always @(*)
	   if (S==FLASH && Count[24])
	        GRBSeq = OFF;
	   else
	    	GRBSeq = GRBin;	

	assign Refresh = (Cycle || Count[23]);
	assign Run = (S==PLAY);
endmodule

