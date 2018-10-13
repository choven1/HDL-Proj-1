module GamePattern(GRBSeq, Cycle, S, Run, lvl, FlashCorrect, FlashWrong, Normal, reset,clk);
  output reg [119:0] GRBSeq;
  output Cycle;
  output [2:0] S;
  input Run, FlashCorrect, FlashWrong, Normal, reset, clk;
  input [2:0] lvl;
  reg [2:0] S, nS = 0;
  reg [26:0] Count, nCount;
  reg [23:0] color;
  parameter OFF = 24'h000000, RED = 24'h00FF00, ORANGE = 24'h66FF00, GREEN = 24'hFF0000;
  parameter CYAN = 24'hFF00FF, BLUE = 24'h0000FF, VIOLET = 24'h0066FF;
  
  always @(posedge clk)
    begin
      if (reset) begin
        Count <= 0;
        S <= 0; end
      else if ((Run||FlashCorrect||FlashWrong)) begin
        if (Count[4]) S <= nS;
        else Count <= nCount;
      end
      else S <= S;
    end
    
  always @(Count)
    begin
      if(Count [4]) nCount = 0;
      else nCount = Count+1;
    end
  
  always @(S, color)
    begin
      if (Normal) begin
        case(S)
          3'b000: begin GRBSeq = {RED  ,color,OFF  ,color,color}; nS = S+1; end
          3'b001: begin GRBSeq = {color,RED  ,OFF  ,color,color}; nS = S+1; end
          3'b010: begin GRBSeq = {color,color,RED  ,color,color}; nS = S+1; end
          3'b011: begin GRBSeq = {color,color,OFF  ,RED  ,color}; nS = S+1; end
          3'b100: begin GRBSeq = {color,color,OFF  ,color,RED  }; nS = S+1; end
          3'b101: begin GRBSeq = {color,color,OFF  ,RED  ,color}; nS = S+1; end
          3'b110: begin GRBSeq = {color,color,RED  ,color,color}; nS = S+1; end
          3'b111: begin GRBSeq = {color,RED  ,OFF  ,color,color}; nS = S+1; end
          default: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  };  nS = 0; end
        endcase
      end
      else if(FlashCorrect) begin
        case(S)
          3'b000: begin GRBSeq = {color,color,color,color,color}; nS = 2; end
          3'b001: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 2; end
          3'b010: begin GRBSeq = {color,color,color,color,color}; nS = 6; end
          3'b011: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 2; end
          3'b100: begin GRBSeq = {color,color,color,color,color}; nS = 2; end
          3'b101: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 2; end
          3'b110: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 2; end
          3'b111: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 2; end
          default: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 2; end
        endcase
      end
      else if(FlashWrong)
        case(S)
          3'b000: begin GRBSeq = {RED  ,RED  ,RED  ,RED  ,RED  }; nS = 3; end
          3'b001: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 3; end
          3'b010: begin GRBSeq = {RED  ,RED  ,RED  ,RED  ,RED  }; nS = 3; end
          3'b011: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 4; end
          3'b100: begin GRBSeq = {RED  ,RED  ,RED  ,RED  ,RED  }; nS = 3; end
          3'b101: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 3; end
          3'b110: begin GRBSeq = {RED  ,RED  ,RED  ,RED  ,RED  }; nS = 3; end
          3'b111: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 3; end
          default: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 0; end
        endcase
      else
        case(S)
          3'b000: begin GRBSeq = {color,color,RED  ,color,color}; nS = 1; end
          3'b001: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 0; end
          3'b010: begin GRBSeq = {color,color,RED  ,color,color}; nS = 0; end
          3'b011: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 0; end
          3'b100: begin GRBSeq = {color,color,RED  ,color,color}; nS = 0; end
          3'b101: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 0; end
          3'b110: begin GRBSeq = {color,color,RED  ,color,color}; nS = 0; end
          3'b111: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 0; end
          default: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 0; end
        endcase
    end
  
  always @ (lvl)
    case (lvl)
      3'b000: color = ORANGE;
      3'b001: color = GREEN;
      3'b010: color = CYAN;
      3'b011: color = BLUE;
      3'b100: color = VIOLET;
      default: color = OFF;
    endcase
  
  assign  Cycle = Count[4];
  
endmodule