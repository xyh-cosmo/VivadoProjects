onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ILA_opt

do {wave.do}

view wave
view structure
view signals

do {ILA.udo}

run -all

quit -force
