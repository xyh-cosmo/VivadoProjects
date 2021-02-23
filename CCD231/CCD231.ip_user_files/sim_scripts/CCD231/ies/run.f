-makelib ies_lib/xil_defaultlib -sv \
  "/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/sim/CCD231.v" \
-endlib
-makelib ies_lib/axi_infrastructure_v1_1_0 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/smartconnect_v1_0 -sv \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/02c8/hdl/sc_util_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/axi_protocol_checker_v2_0_1 -sv \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/3b24/hdl/axi_protocol_checker_v2_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/axi_vip_v1_1_1 -sv \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/a16a/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib ies_lib/processing_system7_vip_v1_0_3 -sv \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/1313/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ip/CCD231_processing_system7_0_1/sim/CCD231_processing_system7_0_1.v" \
-endlib
-makelib ies_lib/axi_lite_ipif_v3_0_4 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/lib_cdc_v1_0_2 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/interrupt_control_v3_1_4 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/8e66/hdl/interrupt_control_v3_1_vh_rfs.vhd" \
-endlib
-makelib ies_lib/axi_gpio_v2_0_17 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/c450/hdl/axi_gpio_v2_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ip/CCD231_axi_gpio_0_1/sim/CCD231_axi_gpio_0_1.vhd" \
-endlib
-makelib ies_lib/proc_sys_reset_v5_0_12 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ip/CCD231_rst_ps7_0_148M_1/sim/CCD231_rst_ps7_0_148M_1.vhd" \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ip/CCD231_axi_gpio_0_0/sim/CCD231_axi_gpio_0_0.vhd" \
-endlib
-makelib ies_lib/generic_baseblocks_v2_1_0 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_register_slice_v2_1_15 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/3ed1/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_1 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/5c35/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_1 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_1 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib ies_lib/axi_data_fifo_v2_1_14 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/9909/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_crossbar_v2_1_16 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/c631/hdl/axi_crossbar_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ip/CCD231_xbar_0/sim/CCD231_xbar_0.v" \
-endlib
-makelib ies_lib/axi_protocol_converter_v2_1_15 \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ipshared/ff69/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../CCD231.srcs/sources_1/bd/CCD231/ip/CCD231_auto_pc_0/sim/CCD231_auto_pc_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

