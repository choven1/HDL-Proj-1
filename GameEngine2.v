//IGNORE THIS FILE FOW NOW
/*
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
    if(Count [24]) nCount = 0;
    else nCount = Count+1;
		
	always @(lvl, Go, S)
		if(Go) nlvl = (((S!=4'b0010)||(S!=4'b0110)) ? 0 : lvl+1);
		else nlvl = lvl;
*/
	/*always @(S, Go, color) 
		case(S)
			4'b0000: begin GRBSeq = {RED  ,color,OFF  ,color,color}; nS = (Go ? S : S+1);       end
			4'b0001: begin GRBSeq = {color,RED  ,OFF  ,color,color}; nS = (Go ? S : S+1);       end
			4'b0010: begin GRBSeq = {color,color,RED  ,color,color}; nS = (Go ? 4'b1001 : S+1); end
			4'b0011: begin GRBSeq = {color,color,OFF  ,RED  ,color}; nS = (Go ? S : S+1);       end
			4'b0100: begin GRBSeq = {color,color,OFF  ,color,RED  }; nS = (Go ? S : S+1);       end
			4'b0101: begin GRBSeq = {color,color,OFF  ,RED  ,color}; nS = (Go ? S : S+1);       end
			4'b0110: begin GRBSeq = {color,color,RED  ,color,color}; nS = (Go ? 4'b1001 : S+1); end
			4'b0111: begin GRBSeq = {color,RED  ,OFF  ,color,color}; nS = (Go ? S : 4'b0000);   end
      4'b1000: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  };                            end
      4'b1001: begin GRBSeq = {color,color,color,color,color};                            end
			default: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 4'b0000;              end
		endcase
	*/
/*
	
	assign 	Cycle = Count[24];
endmodule

module RunningGame(GRBSeq,S,lvl,Flash,Run)
  output [119:0] GRBSeq;
  output [3:0] S;
  input [2:0] lvl;
  input Flash,Run;

  reg [3:0] S,nS;

  always @(S, Go, color)
    begin
      if(Flash) begin
        case(S)
          4'b0000: begin GRBSeq = {RED  ,color,OFF  ,color,color}; nS = (Go ? S : S+1);     end
          4'b0001: begin GRBSeq = {color,RED  ,OFF  ,color,color}; nS = (Go ? S : S+1);     end
          4'b0010: begin GRBSeq = {color,color,RED  ,color,color}; nS = (Go ? S : S+1);     end
          4'b0011: begin GRBSeq = {color,color,OFF  ,RED  ,color}; nS = (Go ? S : S+1);     end
          4'b0100: begin GRBSeq = {color,color,OFF  ,color,RED  }; nS = (Go ? S : S+1);     end
          4'b0101: begin GRBSeq = {color,color,OFF  ,RED  ,color}; nS = (Go ? S : S+1);     end
          4'b0110: begin GRBSeq = {color,color,RED  ,color,color}; nS = (Go ? S : S+1);     end
          4'b0111: begin GRBSeq = {color,RED  ,OFF  ,color,color}; nS = (Go ? S : 4'b0000); end
          default: begin GRBSeq = {OFF  ,OFF  ,OFF  ,OFF  ,OFF  }; nS = 4'b0000;            end
        endcase
        end
      //else
    end

  always @ (lvl)
    case (lvl)
      3'b000:  color = ORANGE;
      3'b001:  color = GREEN;
      3'b010:  color = CYAN;
      3'b011:  color = BLUE;
      3'b100:  color = VIOLET;
      default: color = OFF;
    endcase

endmodule
*/
