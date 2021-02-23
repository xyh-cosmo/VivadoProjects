// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2017.4" *)
module u_ila_1_CV(clk, probe0, probe1);
  input clk;
  input [11:0]probe0;
  input [11:0]probe1;
endmodule
