module ColorOutput(GRBSeq,Color,SendColor);
  output [119:0] GRBSeq;
  output Cycle;
  input [4:0] Color; //determines which colored LEDs will be turned on each bit corresponds to a color
  input SendColor; //enables the output of GRBSeq

  wire [4:0] LED1,LED2,LED3,LED4,LED5;

  always @(Color, SendColor)
    begin
      if (!SendColor) begin
        {LED1,LED2,LED3,LED4,LED5} = {LED1,LED2,LED3,LED4,LED5};
      end
      else begin
        LED1 = Color[4] ? 24'hFFFF00, 24'h0;
        LED2 = Color[3] ? 24'hFF0000, 24'b0;
        LED3 = Color[2] ? 24'h0000FF, 24'b0;
        LED4 = Color[1] ? 24'h00CFFF, 24'b0;
        LED5 = Color[0] ? 24'h00FF00, 24'b0;
      end
    end

  assign GRBSeq = {LED1,LED2,LED3,LED4,LED5};
  assign Cycle = SendColor;

endmodule