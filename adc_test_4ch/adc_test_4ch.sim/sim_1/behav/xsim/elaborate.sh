#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2017.4 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Mon Dec 28 14:26:42 CST 2020
# SW Build 2086221 on Fri Dec 15 20:54:30 MST 2017
#
# Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep xelab -wto f3badb26fd5041db8fb6dfe30d0cb619 --incr --debug typical --relax --mt 8 -L axi_infrastructure_v1_1_0 -L smartconnect_v1_0 -L axi_protocol_checker_v2_0_1 -L axi_vip_v1_1_1 -L processing_system7_vip_v1_0_3 -L xil_defaultlib -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_12 -L generic_baseblocks_v2_1_0 -L fifo_generator_v13_2_1 -L axi_data_fifo_v2_1_14 -L axi_register_slice_v2_1_15 -L axi_protocol_converter_v2_1_15 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot top_behav xil_defaultlib.top xil_defaultlib.glbl -log elaborate.log