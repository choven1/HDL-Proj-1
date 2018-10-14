// Display.v
module Display(Seg,Anode,clk,Lvl);
  input  clk;
  input  [2:0] Lvl;
  output [0:6] Seg;
  output [3:0] Anode;
	
  wire [2:0] Dig;
  wire Ghost;
	
  SevenSegment d1 (Seg,Dig,Ghost);
  Mux4Machine	 m1 (Dig,Anode,Ghost,Lvl,clk);
endmodule
