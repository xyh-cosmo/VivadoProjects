onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ILA_LTC2271_opt

do {wave.do}

view wave
view structure
view signals

do {ILA_LTC2271.udo}

run -all

quit -force
