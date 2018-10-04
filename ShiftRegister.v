// ShiftRegister.v
// determines the 24-bit control word for an LED module
// shifts it out one bit at a time
// keeps sending the same 24 bits, so same color to all modules

module ShiftRegister(CurrentBit,InputBits,LoadRegister,RotateRegisterLeft,clk,reset);
  output CurrentBit;
  input  [119:0] InputBits;
  input  LoadRegister, RotateRegisterLeft;
  input  clk, reset;

  parameter DEFAULTREG=120'h0F0F0F_0F0F0F_0F0F0F;  // white, half brightness

  reg [119:0]  TheReg, nTheReg;  // 24 bits for GRB control

  always @(posedge clk)
    if(reset) TheReg <= DEFAULTREG;
    else  TheReg <= nTheReg;
      
    // switches set the upper 4 bits of the GRB control bytes
  always @(TheReg, LoadRegister, RotateRegisterLeft, InputBits)
    if(NumLEDs==5)
      if(LoadRegister)
        nTheReg = InputBits[119:0];
      else if(RotateRegisterLeft)
        nTheReg = {TheReg[118:0],TheReg[119]};
      else
        nTheReg = TheReg;
    else if(NumLEDs==4)
      if(LoadRegister)
        nTheReg = InputBits[119:24];
      else if(RotateRegisterLeft)
        nTheReg = {TheReg[118:24],TheReg[119],24'b0};
      else
        nTheReg = TheReg;
    else if(NumLEDs==3)
      if(LoadRegister)
        nTheReg = InputBits[119:48];
      else if(RotateRegisterLeft)
        nTheReg = {TheReg[118:48],TheReg[119],48'b0};
      else
        nTheReg = TheReg;
    else if(NumLEDs==2)
      if(LoadRegister)
        nTheReg = InputBits[119:72];
      else if(RotateRegisterLeft)
        nTheReg = {TheReg[118:72],TheReg[119],72'b0};
      else
        nTheReg = TheReg;
    else if(NumLEDs==1)
      if(LoadRegister)
        nTheReg = InputBits[119:96];
      else if(RotateRegisterLeft)
        nTheReg = {TheReg[118:96],TheReg[119],96'b0};
      else
        nTheReg = TheReg;
    else
      if(LoadRegister)
        nTheReg = InputBits[119:96];
      else if(RotateRegisterLeft)
        nTheReg = {TheReg[118:96],TheReg[119],96'b0};
      else
        nTheReg = TheReg;

  assign  CurrentBit = TheReg[119];
endmodule
