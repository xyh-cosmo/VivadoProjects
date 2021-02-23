// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
// Date        : Tue Feb 23 18:38:59 2021
// Host        : apple running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/xyh/NFS_Alinx/VivadoProjects/CCD231/CCD231.srcs/sources_1/ip/my_clk_generator/my_clk_generator_stub.v
// Design      : my_clk_generator
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z035ffg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module my_clk_generator(clk_10M, clk_20M, clk_150M, locked, clk_in)
/* synthesis syn_black_box black_box_pad_pin="clk_10M,clk_20M,clk_150M,locked,clk_in" */;
  output clk_10M;
  output clk_20M;
  output clk_150M;
  output locked;
  input clk_in;
endmodule
