
module GameEngine2(GRBSeq,Refresh,Run,Lvl,Go,clk,reset,GRBin,Cycle,Flag);
  output reg [119:0] GRBSeq;
  output Refresh, Run, Lvl;
  input Go, clk, reset, Cycle;
  input [119:0] GRBin; //LED input from sequence generator
  input Flag; //is set to 1 if sequence is on a winning state

  reg [1:0] S, nS;
  reg [28:0] Count, nCount;
  reg [2:0] Lvl, nLvl;
  parameter PLAY = 2'b00, FLASH = 2'b01, WIN = 2'b10;
  parameter OFF = 24'h000000_000000_000000_000000_000000;
  
  //assigns next state, count, and level value or resets
  always @(posedge clk)
    if (reset) begin
      Count <= 0;
      S <= 0; 
      Lvl <= 0; end
    else begin
      S <= nS;
      Count <= nCount; 
      Lvl <= nLvl; end
  
  //Determines the level of the game
  //after flashing, lvl incremented if Flag got set
  //otherwise restarts game to lvl 0
  always @(*)
    if (Count[28]) begin
      if (Flag) nLvl = Lvl+1;
      else nLvl = 0; end
    else
      nLvl = Lvl;
			
  //Handles Count used for flashing LEDs
  always @(*)
    begin
      if(S!=FLASH || Count[28])
        nCount = 0;
      else if (S==FLASH)
        nCount = Count+1;
      else
        nCount = Count;
    end
			
  //handles the game state.
  //during PLAY, game is running waiting for input
  //during FLASH, success or loss is calculated and LEDs set to flash
  //    relative to calculation
  //during WIN, Win sequence is initiated
  always @(*)
    case(S)
      PLAY   : begin if (Lvl==3'b101) 
                   nS = WIN;
                 else
                   nS = (Go ? FLASH : PLAY); end 
      FLASH  : nS = (Count[28] ? PLAY : FLASH);
      WIN    : nS = (reset ? PLAY : WIN);
      default: nS = PLAY;
    endcase

  //sets the value of GRBSeq to the input or all off
  //when the button is pressed
  always @(*)
    if (S==FLASH && Count[24]) GRBSeq = OFF;
    else GRBSeq = GRBin;	

  assign Refresh = (Cycle || Count[23]); //tells system to update LEDs
  assign Run = (S==PLAY); //turns on the sequence for game
endmodule

