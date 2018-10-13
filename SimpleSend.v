// SimpleSend.v
// top-level module for WS2812B LED strip
// VERY basic design, sends same color to all modules
// Updated to support new WS2812B reset code of > 280 us

module SimpleSend(dataOut,Go,clk,reset,Ready2Go);
	output	dataOut, Ready2Go;
	input	Go, clk, reset;

	parameter   [3:1]  NumLEDs = 3'b101;
	wire		shipGRB, Done, allDone, Win;
	wire [1:0]	qmode;
	wire		LoadGRBPattern, ShiftPattern, StartCoding, ClrCounter, IncCounter, theBit, bdone, Cycle;
	wire [7:0]	Count;
	wire [119:0] GRBSeq;

	SSStateMachine	sssm(shipGRB,Done,Cycle,clk,reset,allDone,Ready2Go);
	GRBStateMachine grbsm(qmode,Done,LoadGRBPattern,ShiftPattern,StartCoding,ClrCounter,IncCounter,
                              shipGRB,theBit,bdone,Count,NumLEDs,clk,reset,allDone);
	ShiftRegister   shftr(theBit,GRBSeq,LoadGRBPattern,ShiftPattern,clk,reset);
	BitCounter	btcnt(Count,ClrCounter,IncCounter,clk,reset);
	NZRbitGEN	nzrgn(dataOut,bdone,qmode,StartCoding,clk,reset);
	GameEngine game(GRBSeq,Cycle,Win,Go,clk,reset);
endmodule
