onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+my_clk_generator -L xil_defaultlib -L xpm -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.my_clk_generator xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {my_clk_generator.udo}

run -all

endsim

quit -force
