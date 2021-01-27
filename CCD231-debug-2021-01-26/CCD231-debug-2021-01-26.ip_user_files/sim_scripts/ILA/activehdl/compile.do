vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/hdl/verilog" "+incdir+../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/hdl/verilog" \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/hdl/verilog" "+incdir+../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/hdl/verilog" \
"../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/sim/ILA.v" \

vlog -work xil_defaultlib \
"glbl.v"

