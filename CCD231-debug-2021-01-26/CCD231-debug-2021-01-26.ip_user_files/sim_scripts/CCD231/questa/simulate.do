onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib CCD231_opt

do {wave.do}

view wave
view structure
view signals

do {CCD231.udo}

run -all

quit -force
