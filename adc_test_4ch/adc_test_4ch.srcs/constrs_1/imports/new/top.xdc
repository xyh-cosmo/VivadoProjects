
set_property IOSTANDARD LVCMOS15 [get_ports error]
set_property PACKAGE_PIN G6 [get_ports error]



#只用一个按键PL_KEY
set_property PACKAGE_PIN J8 [get_ports PL_KEY]
set_property IOSTANDARD LVCMOS15 [get_ports PL_KEY]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets PL_KEY_IBUF]

set_property IOSTANDARD LVCMOS15 [get_ports {leds_tri_o[*]}]
set_property PACKAGE_PIN F5 [get_ports {leds_tri_o[2]}]
set_property PACKAGE_PIN E5 [get_ports {leds_tri_o[1]}]
set_property PACKAGE_PIN G5 [get_ports {leds_tri_o[0]}]









#connect_debug_port dbg_hub/clk [get_nets M_AXI_ACLK]


#connect_debug_port dbg_hub/clk [get_nets u_ila_0_FCLK_CLK0]




create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list adc1_clk_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 12 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {adc1_data_a_d0[0]} {adc1_data_a_d0[1]} {adc1_data_a_d0[2]} {adc1_data_a_d0[3]} {adc1_data_a_d0[4]} {adc1_data_a_d0[5]} {adc1_data_a_d0[6]} {adc1_data_a_d0[7]} {adc1_data_a_d0[8]} {adc1_data_a_d0[9]} {adc1_data_a_d0[10]} {adc1_data_a_d0[11]}]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list adc2_clk_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 12 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list {adc2_data_b_d0[0]} {adc2_data_b_d0[1]} {adc2_data_b_d0[2]} {adc2_data_b_d0[3]} {adc2_data_b_d0[4]} {adc2_data_b_d0[5]} {adc2_data_b_d0[6]} {adc2_data_b_d0[7]} {adc2_data_b_d0[8]} {adc2_data_b_d0[9]} {adc2_data_b_d0[10]} {adc2_data_b_d0[11]}]]
create_debug_core u_ila_2 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_2]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_2]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_2]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_2]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_2]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_2]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_2]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_2]
set_property port_width 1 [get_debug_ports u_ila_2/clk]
connect_debug_port u_ila_2/clk [get_nets [list ps_block/system_i/processing_system7_0/inst/FCLK_CLK0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe0]
set_property port_width 64 [get_debug_ports u_ila_2/probe0]
connect_debug_port u_ila_2/probe0 [get_nets [list {wr_burst_data[0]} {wr_burst_data[1]} {wr_burst_data[2]} {wr_burst_data[3]} {wr_burst_data[4]} {wr_burst_data[5]} {wr_burst_data[6]} {wr_burst_data[7]} {wr_burst_data[8]} {wr_burst_data[9]} {wr_burst_data[10]} {wr_burst_data[11]} {wr_burst_data[12]} {wr_burst_data[13]} {wr_burst_data[14]} {wr_burst_data[15]} {wr_burst_data[16]} {wr_burst_data[17]} {wr_burst_data[18]} {wr_burst_data[19]} {wr_burst_data[20]} {wr_burst_data[21]} {wr_burst_data[22]} {wr_burst_data[23]} {wr_burst_data[24]} {wr_burst_data[25]} {wr_burst_data[26]} {wr_burst_data[27]} {wr_burst_data[28]} {wr_burst_data[29]} {wr_burst_data[30]} {wr_burst_data[31]} {wr_burst_data[32]} {wr_burst_data[33]} {wr_burst_data[34]} {wr_burst_data[35]} {wr_burst_data[36]} {wr_burst_data[37]} {wr_burst_data[38]} {wr_burst_data[39]} {wr_burst_data[40]} {wr_burst_data[41]} {wr_burst_data[42]} {wr_burst_data[43]} {wr_burst_data[44]} {wr_burst_data[45]} {wr_burst_data[46]} {wr_burst_data[47]} {wr_burst_data[48]} {wr_burst_data[49]} {wr_burst_data[50]} {wr_burst_data[51]} {wr_burst_data[52]} {wr_burst_data[53]} {wr_burst_data[54]} {wr_burst_data[55]} {wr_burst_data[56]} {wr_burst_data[57]} {wr_burst_data[58]} {wr_burst_data[59]} {wr_burst_data[60]} {wr_burst_data[61]} {wr_burst_data[62]} {wr_burst_data[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 12 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {adc1_data_b_d0[0]} {adc1_data_b_d0[1]} {adc1_data_b_d0[2]} {adc1_data_b_d0[3]} {adc1_data_b_d0[4]} {adc1_data_b_d0[5]} {adc1_data_b_d0[6]} {adc1_data_b_d0[7]} {adc1_data_b_d0[8]} {adc1_data_b_d0[9]} {adc1_data_b_d0[10]} {adc1_data_b_d0[11]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 12 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list {adc2_data_a_d0[0]} {adc2_data_a_d0[1]} {adc2_data_a_d0[2]} {adc2_data_a_d0[3]} {adc2_data_a_d0[4]} {adc2_data_a_d0[5]} {adc2_data_a_d0[6]} {adc2_data_a_d0[7]} {adc2_data_a_d0[8]} {adc2_data_a_d0[9]} {adc2_data_a_d0[10]} {adc2_data_a_d0[11]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe1]
set_property port_width 32 [get_debug_ports u_ila_2/probe1]
connect_debug_port u_ila_2/probe1 [get_nets [list {wr_burst_addr[0]} {wr_burst_addr[1]} {wr_burst_addr[2]} {wr_burst_addr[3]} {wr_burst_addr[4]} {wr_burst_addr[5]} {wr_burst_addr[6]} {wr_burst_addr[7]} {wr_burst_addr[8]} {wr_burst_addr[9]} {wr_burst_addr[10]} {wr_burst_addr[11]} {wr_burst_addr[12]} {wr_burst_addr[13]} {wr_burst_addr[14]} {wr_burst_addr[15]} {wr_burst_addr[16]} {wr_burst_addr[17]} {wr_burst_addr[18]} {wr_burst_addr[19]} {wr_burst_addr[20]} {wr_burst_addr[21]} {wr_burst_addr[22]} {wr_burst_addr[23]} {wr_burst_addr[24]} {wr_burst_addr[25]} {wr_burst_addr[26]} {wr_burst_addr[27]} {wr_burst_addr[28]} {wr_burst_addr[29]} {wr_burst_addr[30]} {wr_burst_addr[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe2]
set_property port_width 8 [get_debug_ports u_ila_2/probe2]
connect_debug_port u_ila_2/probe2 [get_nets [list {mem_test_m0/wr_cnt[0]} {mem_test_m0/wr_cnt[1]} {mem_test_m0/wr_cnt[2]} {mem_test_m0/wr_cnt[3]} {mem_test_m0/wr_cnt[4]} {mem_test_m0/wr_cnt[5]} {mem_test_m0/wr_cnt[6]} {mem_test_m0/wr_cnt[7]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe3]
set_property port_width 3 [get_debug_ports u_ila_2/probe3]
connect_debug_port u_ila_2/probe3 [get_nets [list {mem_test_m0/state[0]} {mem_test_m0/state[1]} {mem_test_m0/state[2]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe4]
set_property port_width 32 [get_debug_ports u_ila_2/probe4]
connect_debug_port u_ila_2/probe4 [get_nets [list {mem_test_m0/pl_cnt[0]} {mem_test_m0/pl_cnt[1]} {mem_test_m0/pl_cnt[2]} {mem_test_m0/pl_cnt[3]} {mem_test_m0/pl_cnt[4]} {mem_test_m0/pl_cnt[5]} {mem_test_m0/pl_cnt[6]} {mem_test_m0/pl_cnt[7]} {mem_test_m0/pl_cnt[8]} {mem_test_m0/pl_cnt[9]} {mem_test_m0/pl_cnt[10]} {mem_test_m0/pl_cnt[11]} {mem_test_m0/pl_cnt[12]} {mem_test_m0/pl_cnt[13]} {mem_test_m0/pl_cnt[14]} {mem_test_m0/pl_cnt[15]} {mem_test_m0/pl_cnt[16]} {mem_test_m0/pl_cnt[17]} {mem_test_m0/pl_cnt[18]} {mem_test_m0/pl_cnt[19]} {mem_test_m0/pl_cnt[20]} {mem_test_m0/pl_cnt[21]} {mem_test_m0/pl_cnt[22]} {mem_test_m0/pl_cnt[23]} {mem_test_m0/pl_cnt[24]} {mem_test_m0/pl_cnt[25]} {mem_test_m0/pl_cnt[26]} {mem_test_m0/pl_cnt[27]} {mem_test_m0/pl_cnt[28]} {mem_test_m0/pl_cnt[29]} {mem_test_m0/pl_cnt[30]} {mem_test_m0/pl_cnt[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe5]
set_property port_width 12 [get_debug_ports u_ila_2/probe5]
connect_debug_port u_ila_2/probe5 [get_nets [list {mem_test_m0/adc_ltc2271_3[0]} {mem_test_m0/adc_ltc2271_3[1]} {mem_test_m0/adc_ltc2271_3[2]} {mem_test_m0/adc_ltc2271_3[3]} {mem_test_m0/adc_ltc2271_3[4]} {mem_test_m0/adc_ltc2271_3[5]} {mem_test_m0/adc_ltc2271_3[6]} {mem_test_m0/adc_ltc2271_3[7]} {mem_test_m0/adc_ltc2271_3[8]} {mem_test_m0/adc_ltc2271_3[9]} {mem_test_m0/adc_ltc2271_3[10]} {mem_test_m0/adc_ltc2271_3[11]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe6]
set_property port_width 12 [get_debug_ports u_ila_2/probe6]
connect_debug_port u_ila_2/probe6 [get_nets [list {mem_test_m0/adc_ltc2271_2[0]} {mem_test_m0/adc_ltc2271_2[1]} {mem_test_m0/adc_ltc2271_2[2]} {mem_test_m0/adc_ltc2271_2[3]} {mem_test_m0/adc_ltc2271_2[4]} {mem_test_m0/adc_ltc2271_2[5]} {mem_test_m0/adc_ltc2271_2[6]} {mem_test_m0/adc_ltc2271_2[7]} {mem_test_m0/adc_ltc2271_2[8]} {mem_test_m0/adc_ltc2271_2[9]} {mem_test_m0/adc_ltc2271_2[10]} {mem_test_m0/adc_ltc2271_2[11]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe7]
set_property port_width 12 [get_debug_ports u_ila_2/probe7]
connect_debug_port u_ila_2/probe7 [get_nets [list {mem_test_m0/adc_ltc2271_1[0]} {mem_test_m0/adc_ltc2271_1[1]} {mem_test_m0/adc_ltc2271_1[2]} {mem_test_m0/adc_ltc2271_1[3]} {mem_test_m0/adc_ltc2271_1[4]} {mem_test_m0/adc_ltc2271_1[5]} {mem_test_m0/adc_ltc2271_1[6]} {mem_test_m0/adc_ltc2271_1[7]} {mem_test_m0/adc_ltc2271_1[8]} {mem_test_m0/adc_ltc2271_1[9]} {mem_test_m0/adc_ltc2271_1[10]} {mem_test_m0/adc_ltc2271_1[11]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe8]
set_property port_width 12 [get_debug_ports u_ila_2/probe8]
connect_debug_port u_ila_2/probe8 [get_nets [list {mem_test_m0/adc_ltc2271_0[0]} {mem_test_m0/adc_ltc2271_0[1]} {mem_test_m0/adc_ltc2271_0[2]} {mem_test_m0/adc_ltc2271_0[3]} {mem_test_m0/adc_ltc2271_0[4]} {mem_test_m0/adc_ltc2271_0[5]} {mem_test_m0/adc_ltc2271_0[6]} {mem_test_m0/adc_ltc2271_0[7]} {mem_test_m0/adc_ltc2271_0[8]} {mem_test_m0/adc_ltc2271_0[9]} {mem_test_m0/adc_ltc2271_0[10]} {mem_test_m0/adc_ltc2271_0[11]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe9]
set_property port_width 5 [get_debug_ports u_ila_2/probe9]
connect_debug_port u_ila_2/probe9 [get_nets [list {mem_test_m0/adc_cnt[0]} {mem_test_m0/adc_cnt[1]} {mem_test_m0/adc_cnt[2]} {mem_test_m0/adc_cnt[3]} {mem_test_m0/adc_cnt[4]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe10]
set_property port_width 10 [get_debug_ports u_ila_2/probe10]
connect_debug_port u_ila_2/probe10 [get_nets [list {wr_burst_len[0]} {wr_burst_len[1]} {wr_burst_len[2]} {wr_burst_len[3]} {wr_burst_len[4]} {wr_burst_len[5]} {wr_burst_len[6]} {wr_burst_len[7]} {wr_burst_len[8]} {wr_burst_len[9]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe11]
set_property port_width 1 [get_debug_ports u_ila_2/probe11]
connect_debug_port u_ila_2/probe11 [get_nets [list adc2_clk]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe12]
set_property port_width 1 [get_debug_ports u_ila_2/probe12]
connect_debug_port u_ila_2/probe12 [get_nets [list mem_test_m0/adc_clk]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe13]
set_property port_width 1 [get_debug_ports u_ila_2/probe13]
connect_debug_port u_ila_2/probe13 [get_nets [list mem_test_m0/f_clk]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe14]
set_property port_width 1 [get_debug_ports u_ila_2/probe14]
connect_debug_port u_ila_2/probe14 [get_nets [list mem_test_m0/p_clk]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe15]
set_property port_width 1 [get_debug_ports u_ila_2/probe15]
connect_debug_port u_ila_2/probe15 [get_nets [list PL_KEY_IBUF_BUFG]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe16]
set_property port_width 1 [get_debug_ports u_ila_2/probe16]
connect_debug_port u_ila_2/probe16 [get_nets [list wr_burst_data_req]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe17]
set_property port_width 1 [get_debug_ports u_ila_2/probe17]
connect_debug_port u_ila_2/probe17 [get_nets [list wr_burst_finish]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe18]
set_property port_width 1 [get_debug_ports u_ila_2/probe18]
connect_debug_port u_ila_2/probe18 [get_nets [list wr_burst_req]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets M_AXI_ACLK]
