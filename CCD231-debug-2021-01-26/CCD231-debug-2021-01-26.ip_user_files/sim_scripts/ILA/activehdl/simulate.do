onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ILA -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ILA xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ILA.udo}

run -all

endsim

quit -force
