// Code your design here

module GameEngine(GRBSeq,Cycle,Win,Go,clk,reset);
  output [119:0] GRBSeq;
  output Cycle, Win;
  input Go, clk, reset;

  reg [3:0] S, nS=0;
  reg [26:0] Count, nCount=0;
  reg [2:0] lvl;
  reg Run, FlashCorrect, FlashWrong, Normal, Win;
  wire [2:0] PatteS;

  GamePattern GamePatterner(GRBSeq, Cycle, PatteS, Run, lvl, FlashCorrect, FlashWrong, Normal, reset,clk);
  
  always @(posedge clk)
      begin
      if(reset) begin
        {Count,S,lvl} <= 0;
        end
        else S <= nS;
        Count <= nCount;
      end
      
  always @(Count)
      begin
        if(Count [4]) nCount = 0;
        else nCount = Count+1;
      end
  
  /*states: Startup, Running, Check success, win check*/
  
  always @(S,Go)
    begin
      case(S)
        3'b000: begin lvl = 0; nS = S+1; end
        3'b001: begin {FlashCorrect, FlashWrong, Normal, Run, Win} = 0; nS = S+1; end
        3'b010: begin nS = Go ? S+1 : S; Normal = 1; Run = ~Go; end
        3'b011: begin nS = Go ? S : S+1; Normal = 0; Run = 0; end
        3'b100: begin
          nS = S+1;
          if(PatteS==4'b0010) begin lvl = lvl + 1; FlashCorrect = 1;  end
          else if(PatteS==4'b0110) begin lvl = lvl + 1; FlashCorrect = 1; end
          else begin lvl = 0;  FlashWrong = 1; end
            end
        3'b101: begin Run = 0; nS = Go ? S+1 : S; end
        3'b110: begin Run = 0; nS = Go ? S : S+1; end
        3'b111: begin if (lvl==4) Win = 1;/*execute win sequence*/
          else nS = 1;
        end
        default: nS = 0;
      endcase
    end
endmodule

