# system clock J14 直接链接到50M的晶振
set_property PACKAGE_PIN J14 [get_ports clk_50M]
set_property IOSTANDARD LVCMOS18 [get_ports clk_50M]

# PL_KEY4
#set_property PACKAGE_PIN J8 [get_ports PL_KEY]
#set_property IOSTANDARD LVCMOS15 [get_ports PL_KEY]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets PL_KEY_IBUF]

#set_property PACKAGE_PIN AE22 [get_ports mosi]
set_property PACKAGE_PIN AB21 [get_ports mosi]
set_property PACKAGE_PIN AB22 [get_ports sclk]
set_property PACKAGE_PIN AE22 [get_ports SDO]
set_property PACKAGE_PIN AD19 [get_ports A0]
set_property PACKAGE_PIN AD18 [get_ports A1]

#########################################################
#==== 1MHz的方波 ====#
# RST.SIG-CTR-1-2
set_property PACKAGE_PIN AE18 [get_ports RST_SIG_CTR]

#==== RPhi1-CTR-1-2
set_property PACKAGE_PIN AF18 [get_ports RPHI1_CTR]

# RPhi2-CTR-1-2
set_property PACKAGE_PIN AB25 [get_ports RPHI2_CTR]

#==== RPhi3-CTR-1-2
set_property PACKAGE_PIN AA25 [get_ports RPHI3_CTR]
#########################################################

# AD9106 trigger
set_property PACKAGE_PIN AC21 [get_ports TRIG]
set_property PACKAGE_PIN AF22 [get_ports CLKP]

set_property PACKAGE_PIN AC22 [get_ports ENC]
set_property PACKAGE_PIN AF24 [get_ports PD]
set_property PACKAGE_PIN AF25 [get_ports IV_5K_CTR]
set_property PACKAGE_PIN AE25 [get_ports ADG772_CTR]
set_property PACKAGE_PIN AE26 [get_ports DUMPOUT]

set_property PACKAGE_PIN AD15 [get_ports EOUT_N]
set_property PACKAGE_PIN AD16 [get_ports EOUT_P]
set_property PACKAGE_PIN AF10 [get_ports FOUT_N]
set_property PACKAGE_PIN AE11 [get_ports FOUT_P]
set_property PACKAGE_PIN AB16 [get_ports GOUT_N]
set_property PACKAGE_PIN AB17 [get_ports GOUT_P]
set_property PACKAGE_PIN AE15 [get_ports HOUT_N]
set_property PACKAGE_PIN AE16 [get_ports HOUT_P]

set_property PACKAGE_PIN AC11 [get_ports EF_FR_N]
set_property PACKAGE_PIN AB12 [get_ports EF_FR_P]
set_property PACKAGE_PIN Y11 [get_ports GH_FR_N]
set_property PACKAGE_PIN Y12 [get_ports GH_FR_P]
set_property PACKAGE_PIN AF13 [get_ports EF_DCO_N]
set_property PACKAGE_PIN AE13 [get_ports EF_DCO_P]
set_property PACKAGE_PIN Y13 [get_ports GH_DCO_N]
set_property PACKAGE_PIN W13 [get_ports GH_DCO_P]


set_property IOSTANDARD LVCMOS25 [get_ports mosi]
set_property IOSTANDARD LVCMOS25 [get_ports sclk]
set_property IOSTANDARD LVCMOS25 [get_ports SDO]
set_property IOSTANDARD LVCMOS25 [get_ports A0]
set_property IOSTANDARD LVCMOS25 [get_ports A1]

set_property IOSTANDARD LVCMOS25 [get_ports RST_SIG_CTR]
set_property IOSTANDARD LVCMOS25 [get_ports RPHI1_CTR]
set_property IOSTANDARD LVCMOS25 [get_ports RPHI2_CTR]
set_property IOSTANDARD LVCMOS25 [get_ports RPHI3_CTR]

#  AD9106
set_property IOSTANDARD LVCMOS25 [get_ports TRIG]
set_property IOSTANDARD LVCMOS25 [get_ports CLKP]


set_property IOSTANDARD LVCMOS25 [get_ports ENC]
set_property IOSTANDARD LVCMOS25 [get_ports PD]
set_property IOSTANDARD LVCMOS25 [get_ports IV_5K_CTR]
set_property IOSTANDARD LVCMOS25 [get_ports ADG772_CTR]
set_property IOSTANDARD LVCMOS25 [get_ports DUMPOUT]

set_property IOSTANDARD LVDS_25 [get_ports EOUT_P]
set_property IOSTANDARD LVDS_25 [get_ports EOUT_N]
set_property IOSTANDARD LVDS_25 [get_ports FOUT_P]
set_property IOSTANDARD LVDS_25 [get_ports FOUT_N]
set_property IOSTANDARD LVDS_25 [get_ports GOUT_P]
set_property IOSTANDARD LVDS_25 [get_ports GOUT_N]
set_property IOSTANDARD LVDS_25 [get_ports HOUT_P]
set_property IOSTANDARD LVDS_25 [get_ports HOUT_N]

set_property IOSTANDARD LVDS_25 [get_ports EF_FR_P]
set_property IOSTANDARD LVDS_25 [get_ports EF_FR_N]
set_property IOSTANDARD LVDS_25 [get_ports GH_FR_P]
set_property IOSTANDARD LVDS_25 [get_ports GH_FR_N]
set_property IOSTANDARD LVDS_25 [get_ports EF_DCO_P]
set_property IOSTANDARD LVDS_25 [get_ports EF_DCO_N]
set_property IOSTANDARD LVDS_25 [get_ports GH_DCO_P]
set_property IOSTANDARD LVDS_25 [get_ports GH_DCO_N]


#create_clock -period 5.000 -name sys_clk -waveform {0.000 10.000} [get_ports sys_clk]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets EF_FR_P_IBUF]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets EF_DCO_N_IBUF]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets IBUFDS_EF_DCO_n_0_BUFG_inst_n_0]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets IBUFDS_EF_FR_n_0_BUFG_inst_n_0]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets IBUFDS_GH_DCO_n_0_BUFG_inst_n_0]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets IBUFDS_GH_FR_n_0_BUFG_inst_n_0]



set_property SLEW FAST [get_ports ENC]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_150M]
