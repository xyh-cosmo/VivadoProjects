vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic" "+incdir+/home/xyh/Xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/home/xyh/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" "+incdir+/home/xyh/Xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/home/xyh/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../CCD231.srcs/sources_1/ip/my_clk_generator/my_clk_generator_clk_wiz.v" \
"../../../../CCD231.srcs/sources_1/ip/my_clk_generator/my_clk_generator.v" \

vlog -work xil_defaultlib \
"glbl.v"
