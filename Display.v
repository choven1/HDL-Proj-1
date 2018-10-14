// James Mock
// 2018-05-02

// final_display.v
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

// seven segment display
module SevenSegment(Seg,Dig,Ghost);
    input [2:0] Dig;
    input Ghost;
    output reg [0:6] Seg;

    always @(*)
	   case(Dig)
		  3'b000:  Seg = (Ghost) ? 7'b111_1111 : 7'b000_0001; // 0
		  3'b001:  Seg = (Ghost) ? 7'b111_1111 : 7'b100_1111; // 1
		  3'b010:  Seg = (Ghost) ? 7'b111_1111 : 7'b001_0010; // 2
		  3'b011:  Seg = (Ghost) ? 7'b111_1111 : 7'b000_0110; // 3
		  3'b100:  Seg = (Ghost) ? 7'b111_1111 : 7'b100_1100; // 4
		  3'b101:  Seg = (Ghost) ? 7'b111_1111 : 7'b010_0100; // 5
		  default: Seg = 7'b111_1111; // default to off
	   endcase
endmodule

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
	begin S <= NS; end
	
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