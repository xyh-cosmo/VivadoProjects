-makelib ies_lib/xil_defaultlib -sv \
  "/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../new-spi-demo.srcs/sources_1/ip/my_clk_generator/my_clk_generator_clk_wiz.v" \
  "../../../../new-spi-demo.srcs/sources_1/ip/my_clk_generator/my_clk_generator.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

