#
#Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
#
set_param xicom.use_bs_reader 1
set_param tcl.collectionResultDisplayLimit 0
set_param project.singleFileAddWarning.threshold 0
set_param chipscope.flow 0
set part xc7z035ffg676-2
set tool_flow Vivado
set ip_vlnv xilinx.com:ip:ila:6.2
set ip_module_name u_ila_2_CV
set params {{{PARAM_VALUE.ALL_PROBE_SAME_MU} {true} {PARAM_VALUE.ALL_PROBE_SAME_MU_CNT} {1} {PARAM_VALUE.C_ADV_TRIGGER} {false} {PARAM_VALUE.C_DATA_DEPTH} {4096} {PARAM_VALUE.C_EN_STRG_QUAL} {false} {PARAM_VALUE.C_INPUT_PIPE_STAGES} {0} {PARAM_VALUE.C_NUM_OF_PROBES} {19} {PARAM_VALUE.C_PROBE0_TYPE} {0} {PARAM_VALUE.C_PROBE0_WIDTH} {64} {PARAM_VALUE.C_PROBE10_TYPE} {0} {PARAM_VALUE.C_PROBE10_WIDTH} {10} {PARAM_VALUE.C_PROBE11_TYPE} {0} {PARAM_VALUE.C_PROBE11_WIDTH} {1} {PARAM_VALUE.C_PROBE12_TYPE} {0} {PARAM_VALUE.C_PROBE12_WIDTH} {1} {PARAM_VALUE.C_PROBE13_TYPE} {0} {PARAM_VALUE.C_PROBE13_WIDTH} {1} {PARAM_VALUE.C_PROBE14_TYPE} {0} {PARAM_VALUE.C_PROBE14_WIDTH} {1} {PARAM_VALUE.C_PROBE15_TYPE} {0} {PARAM_VALUE.C_PROBE15_WIDTH} {1} {PARAM_VALUE.C_PROBE16_TYPE} {0} {PARAM_VALUE.C_PROBE16_WIDTH} {1} {PARAM_VALUE.C_PROBE17_TYPE} {0} {PARAM_VALUE.C_PROBE17_WIDTH} {1} {PARAM_VALUE.C_PROBE18_TYPE} {0} {PARAM_VALUE.C_PROBE18_WIDTH} {1} {PARAM_VALUE.C_PROBE1_TYPE} {0} {PARAM_VALUE.C_PROBE1_WIDTH} {32} {PARAM_VALUE.C_PROBE2_TYPE} {0} {PARAM_VALUE.C_PROBE2_WIDTH} {8} {PARAM_VALUE.C_PROBE3_TYPE} {0} {PARAM_VALUE.C_PROBE3_WIDTH} {3} {PARAM_VALUE.C_PROBE4_TYPE} {0} {PARAM_VALUE.C_PROBE4_WIDTH} {32} {PARAM_VALUE.C_PROBE5_TYPE} {0} {PARAM_VALUE.C_PROBE5_WIDTH} {12} {PARAM_VALUE.C_PROBE6_TYPE} {0} {PARAM_VALUE.C_PROBE6_WIDTH} {12} {PARAM_VALUE.C_PROBE7_TYPE} {0} {PARAM_VALUE.C_PROBE7_WIDTH} {12} {PARAM_VALUE.C_PROBE8_TYPE} {0} {PARAM_VALUE.C_PROBE8_WIDTH} {12} {PARAM_VALUE.C_PROBE9_TYPE} {0} {PARAM_VALUE.C_PROBE9_WIDTH} {5} {PARAM_VALUE.C_TRIGIN_EN} {0} {PARAM_VALUE.C_TRIGOUT_EN} {0}}}
set output_xci /home/xyh/NFS_Alinx/adc_test_4ch/adc_test_4ch.runs/impl_1/.Xil/Vivado-68348-apple/u_ila_2_CV.0/out/result.xci
set output_dcp /home/xyh/NFS_Alinx/adc_test_4ch/adc_test_4ch.runs/impl_1/.Xil/Vivado-68348-apple/u_ila_2_CV.0/out/result.dcp
set output_dir /home/xyh/NFS_Alinx/adc_test_4ch/adc_test_4ch.runs/impl_1/.Xil/Vivado-68348-apple/u_ila_2_CV.0/out
set ip_repo_paths {}
set ip_output_repo /home/xyh/NFS_Alinx/adc_test_4ch/adc_test_4ch.cache/ip
set ip_cache_permissions {read write}

set oopbus_ip_repo_paths [get_param chipscope.oopbus_ip_repo_paths]

set synth_opts {}
set xdc_files {}
source {/home/xyh/Xilinx/Vivado/2017.4/scripts/ip/ipxchipscope.tcl}

set failed [catch {ipx::chipscope::gen_and_synth_ip $part $tool_flow $ip_vlnv $ip_module_name $params $output_xci $output_dcp $output_dir $ip_repo_paths $ip_output_repo $ip_cache_permissions $oopbus_ip_repo_paths $synth_opts $xdc_files} errMessage]

if { $failed } {
send_msg_id {IP_Flow-19-3805} ERROR "Failed to generate and synthesize debug IP $ip_vlnv. \n $errMessage"
  exit 1
}
