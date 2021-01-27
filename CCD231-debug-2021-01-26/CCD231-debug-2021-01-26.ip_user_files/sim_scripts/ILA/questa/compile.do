vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/hdl/verilog" "+incdir+../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/hdl/verilog" \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/home/xyh/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/hdl/verilog" "+incdir+../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/hdl/verilog" \
"../../../../CCD231-debug-2021-01-26.srcs/sources_1/ip/ILA/sim/ILA.v" \

vlog -work xil_defaultlib \
"glbl.v"

