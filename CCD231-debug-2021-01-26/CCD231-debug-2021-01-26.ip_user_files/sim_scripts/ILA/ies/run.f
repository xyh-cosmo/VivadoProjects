-makelib ies_lib/xil_defaultlib -sv \
  "/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/sim/ILA.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

