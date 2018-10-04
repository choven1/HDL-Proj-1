module Pattern(PatternSignal,NextPattern,reset);
  input NextPattern;
  output [119:0] PatternSignal;
  input reset;

  reg [4:0] S;

  always @(posedge NextPattern)
  begin
    if(reset)
      S <= 0;
    else
      S <= S+1;
  end

  always @(S)
  begin
    case (S)
      5'h00: begin assign PatternSignal = 120'h0000FF_000000_000000_000000_000000; end
      5'h01: begin assign PatternSignal = 120'h00000F_0003FF_000000_000000_000000; end
      5'h02: begin assign PatternSignal = 120'h000003_00020F_000FFF_000000_000000; end
      5'h03: begin assign PatternSignal = 120'h000000_000103_00070F_003FFF_000000; end
      5'h04: begin assign PatternSignal = 120'h000000_000000_000103_00070F_00FFFF; end
      5'h05: begin assign PatternSignal = 120'h000000_000000_000000_00FF3F_000F0F; end
      5'h06: begin assign PatternSignal = 120'h000000_000000_00FF0F_000F07_000303; end
      5'h07: begin assign PatternSignal = 120'h000000_00FF03_000F07_000301_000000; end
      5'h08: begin assign PatternSignal = 120'h00FF00_000F02_000301_000000_000000; end
      5'h09: begin assign PatternSignal = 120'h000F00_03FF00_000000_000000_000000; end
      5'h0a: begin assign PatternSignal = 120'h000300_020F00_0FFF00_000000_000000; end
      5'h0b: begin assign PatternSignal = 120'h000000_010300_070F00_3FFF00_000000; end
      5'h0c: begin assign PatternSignal = 120'h000000_000000_010300_070F00_FFFF00; end
      5'h0d: begin assign PatternSignal = 120'h000000_000000_000000_FF3F00_0F0F00; end
      5'h0e: begin assign PatternSignal = 120'h000000_000000_FF0F00_0F0700_030300; end
      5'h0f: begin assign PatternSignal = 120'h000000_FF0300_0F0700_030100_000000; end
      5'h10: begin assign PatternSignal = 120'hFF0000_0F0200_030100_000000_000000; end
      5'h11: begin assign PatternSignal = 120'h0F0000_FF0003_000000_000000_000000; end
      5'h12: begin assign PatternSignal = 120'h030000_0F0002_FF000F_000000_000000; end
      5'h13: begin assign PatternSignal = 120'h000000_030001_0F0007_FF003F_000000; end
      5'h14: begin assign PatternSignal = 120'h000000_000000_030001_0F0007_FF00FF; end
      5'h15: begin assign PatternSignal = 120'h000000_000000_000000_3F00FF_0F000F; end
      5'h16: begin assign PatternSignal = 120'h000000_000000_0F00FF_07000F_030003; end
      5'h17: begin assign PatternSignal = 120'h000000_0300FF_07000F_010003_000000; end
      5'h18: begin assign PatternSignal = 120'h0000FF_02000F_010003_000000_000000; end
      5'h19: begin assign PatternSignal = 120'h00000F_010003_000000_000000_000000; end
      5'h1a: begin assign PatternSignal = 120'h000003_000000_000000_000000_000000; end
      5'h1b: begin assign PatternSignal = 120'h000000_000000_000000_000000_000000; end
      default: begin assign PatternSignal = 120'h00; nS = 5'h00; end
    endcase
  end

endmodule