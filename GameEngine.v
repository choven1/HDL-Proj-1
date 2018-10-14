// Code your design here

module GameEngine1(GRBout,Cycle,Flag,Go,clk,reset,Run,Lvl);
  output reg [119:0] GRBout;
  output Cycle;
  output Flag;
  input [2:0] Lvl; 
  input Go, clk, reset, Run;

  reg [3:0] S, nS;
  reg [24:0] Count, nCount;
  reg [23:0] color; //assigned to current level's color for output
  reg [3:0] N; //used to tell the patternt what speed to run at
  parameter OFF = 24'h000000, RED = 24'h00FF00, ORANGE = 24'h44FF00, GREEN = 24'hFF0000;
  parameter CYAN = 24'hFF00FF, BLUE = 24'h0000FF, VIOLET = 24'h0088FF;

  //handles clock cycle assignments to state and count
  always @(posedge clk)
    begin
      if(reset) begin
        Count <= 0;
        S <= 0; end
      else if (Go || (Count[24:21]==N)) begin
        S <= nS;
        Count <= nCount; end
      else begin
        S <= S;
        Count <= nCount; end
    end
  
  //generates a slower timing signal used for LED output
  always @(*)
    begin
      if((Count[24:21]==N))
        nCount = 0;
      else if (Run)
        nCount = Count+1;
      else
        nCount = Count;
    end

  //assigns the LED bit output and next set of colors
  //uses state 4'b1000 to signify a successful button timing where it
  //stays until button is pressed again
  always @(*)
    case(S)
      4'b0000: begin GRBout = {RED,   color, OFF,   color, color}; nS = (Go ? S : S+1); end
      4'b0001: begin GRBout = {color, RED,   OFF,   color, color}; nS = (Go ? S : S+1); end
      4'b0010: begin GRBout = {color, color, RED,   color, color}; nS = (Go ? 4'b1000 : S+1); end
      4'b0011: begin GRBout = {color, color, OFF,   RED,   color}; nS = (Go ? S : S+1); end
      4'b0100: begin GRBout = {color, color, OFF,   color, RED  }; nS = (Go ? S : S+1); end
      4'b0101: begin GRBout = {color, color, OFF,   RED,   color}; nS = (Go ? S : S+1); end
      4'b0110: begin GRBout = {color, color, RED,   color, color}; nS = (Go ? 4'b1000 : S+1); end
      4'b0111: begin GRBout = {color, RED,   OFF,   color, color}; nS = (Go ? S : 4'b0000); end
      4'b1000: begin GRBout = {color, color, color, color, color}; nS = (Run ? 4'b0000 : 4'b1000); end 
      default: begin GRBout = {OFF,   OFF,   OFF,   OFF,   OFF  }; nS = 4'b0000; end
    endcase
		
  //assigns the relevant bit sequence to color for LED output
  always @ (Lvl)
    case (Lvl)
      3'b000:  begin color = ORANGE; N = 4'b1110; end
      3'b001:  begin color = GREEN;  N = 4'b1000; end
      3'b010:  begin color = CYAN;   N = 4'b0110; end
      3'b011:  begin color = BLUE;   N = 4'b0100; end
      3'b100:  begin color = VIOLET; N = 4'b0011; end
      default: begin color = OFF;    N = 4'b1100; end
    endcase
		
  assign Flag = (S==4'b1000) ? 1'b1 : 1'b0; //win\loss condition    
  assign Cycle = Count[21]; //tells system to output LED pattern
endmodule

