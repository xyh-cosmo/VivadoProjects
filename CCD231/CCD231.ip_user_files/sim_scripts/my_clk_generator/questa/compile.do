vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv -L smartconnect_v1_0 -L axi_protocol_checker_v2_0_1 -L axi_vip_v1_1_1 -L processing_system7_vip_v1_0_3 -L xilinx_vip "+incdir+../../../ipstatic" "+incdir+/home/xyh/Xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/home/xyh/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" "+incdir+/home/xyh/Xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/home/xyh/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../CCD231.srcs/sources_1/ip/my_clk_generator/my_clk_generator_clk_wiz.v" \
"../../../../CCD231.srcs/sources_1/ip/my_clk_generator/my_clk_generator.v" \

vlog -work xil_defaultlib \
"glbl.v"
