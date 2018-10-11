module Selector(GRBSeq, CylonGRBSeq, MemoryGRBSeq)
  output [119:0] GRBSeq;
  input [119:0] CylonGRBSeq, MemoryGRBSeq;

  assign GRBSeq = MemoryGRBSeq;
endmodule