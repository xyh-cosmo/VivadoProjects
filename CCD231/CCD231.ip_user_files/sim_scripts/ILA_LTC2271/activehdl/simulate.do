onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ILA_LTC2271 -L xil_defaultlib -L xpm -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ILA_LTC2271 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ILA_LTC2271.udo}

run -all

endsim

quit -force
