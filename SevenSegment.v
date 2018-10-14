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
