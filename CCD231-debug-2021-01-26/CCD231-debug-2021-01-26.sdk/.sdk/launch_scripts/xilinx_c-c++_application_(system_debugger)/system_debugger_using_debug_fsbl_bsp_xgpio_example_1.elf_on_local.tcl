connect -url tcp:127.0.0.1:3121
source /home/xyh/NFS_Alinx/VivadoProjects/CCD231-debug-2021-01-26/CCD231-debug-2021-01-26.sdk/TOP_hw_platform_0/ps7_init.tcl
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-HS1 210249854792" && level==0} -index 1
fpga -file /home/xyh/NFS_Alinx/VivadoProjects/CCD231-debug-2021-01-26/CCD231-debug-2021-01-26.sdk/TOP_hw_platform_0/TOP.bit
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS1 210249854792"} -index 0
loadhw -hw /home/xyh/NFS_Alinx/VivadoProjects/CCD231-debug-2021-01-26/CCD231-debug-2021-01-26.sdk/TOP_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS1 210249854792"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-HS1 210249854792"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-HS1 210249854792"} -index 0
dow /home/xyh/NFS_Alinx/VivadoProjects/CCD231-debug-2021-01-26/CCD231-debug-2021-01-26.sdk/fsbl_bsp_xgpio_example_1/Debug/fsbl_bsp_xgpio_example_1.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-HS1 210249854792"} -index 0
con
