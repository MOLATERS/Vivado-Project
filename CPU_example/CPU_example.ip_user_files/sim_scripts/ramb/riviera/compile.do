transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {F:/CPU_design/CPU/CPU.cache/compile_simlib/riviera}
vlib riviera/xpm
vlib riviera/blk_mem_gen_v8_4_6
vlib riviera/xil_defaultlib

vlog -work xpm  -incr -l xpm -l blk_mem_gen_v8_4_6 -l xil_defaultlib \
"I:/VA/Vivado/2023.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"I:/VA/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_4_6  -incr -v2k5 -l xpm -l blk_mem_gen_v8_4_6 -l xil_defaultlib \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 -l xpm -l blk_mem_gen_v8_4_6 -l xil_defaultlib \
"../../../../CPU.gen/sources_1/ip/ramb/sim/ramb.v" \


vlog -work xil_defaultlib \
"glbl.v"

