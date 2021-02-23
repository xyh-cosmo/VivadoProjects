onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ILA_XYH_opt

do {wave.do}

view wave
view structure
view signals

do {ILA_XYH.udo}

run -all

quit -force
