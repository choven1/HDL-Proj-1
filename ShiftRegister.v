// ShiftRegister.v
// determines the 24-bit control word for an LED module
// shifts it out one bit at a time
// keeps sending the same 24 bits, so same color to all modules

module ShiftRegister(CurrentBit,GRBSeq,LoadRegister,RotateRegisterLeft,clk,reset);
  output CurrentBit;
  input  [119:0] GRBSeq;
  input  LoadRegister, RotateRegisterLeft;
  input  clk, reset;

  parameter DEFAULTREG=120'h000000_000000_000000_000000_000000;  // all off

  reg [119:0]  TheReg, nTheReg;  // 120 bits for GRB control

  always @(posedge clk)
    if(reset) TheReg <= DEFAULTREG;
    else  TheReg <= nTheReg;
      
  always @(TheReg, LoadRegister, RotateRegisterLeft, GRBSeq)
    if(LoadRegister)
      nTheReg = GRBSeq;
    else if(RotateRegisterLeft)
      nTheReg = {TheReg[118:0],TheReg[119]};
    else
      nTheReg = TheReg;

  assign  CurrentBit = TheReg[119];
endmodule
