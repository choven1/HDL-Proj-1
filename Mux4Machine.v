// State machine to drive multiplexed four-bit values for display
// on Digilent BASYS2 seven segment displays.
// A==MSD .... D=LSD
module Mux4Machine(Dig,Anode,Ghost,Lvl,clk);
  output reg [2:0] Dig; // The multiplexed output selected from hexVal
  output reg [3:0] Anode;  // Active low common anode drive of display
  output Ghost; 
  input  [2:0] Lvl;
  input  clk;

  parameter NUMSVAR=7;
  reg [24:0] NS, S; // Internal states to provide clk division
  reg [1:0] NSel, Sel; // Selector of common anode
	
  always @(posedge clk)
    S <= NS;
	
  always @(posedge S[NUMSVAR])
    Sel <= NSel;

  always @(*)
    NS = S + 1;

  always @(*)
    NSel = Sel + 1;

  always @(*)
    case(Sel)
      2'b00:   begin Dig = 3'h0; Anode=4'b1111; end //not used
      2'b01:   begin Dig = Lvl;  Anode=(Lvl==3'b101 && S[24]) ? 4'b1111 : 4'b1011; end //score = lvlx100
      2'b10:   begin Dig = 3'h0; Anode=(Lvl==3'b101 && S[24]) ? 4'b1111 : 4'b1101; end
      2'b11:   begin Dig=3'h0;   Anode=(Lvl==3'b101 && S[24]) ? 4'b1111 : 4'b1110; end
      default: begin Dig=3'h0;   Anode=4'b1111; end
    endcase
        
  assign Ghost = S[8]; //controls segment display shadow
endmodule
