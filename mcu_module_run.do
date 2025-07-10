# =============================================
# MCU module universal simulation runner
# Usage (inside ModelSim console):
#   do mcu_module_run.do MUT_ALU
#   do mcu_module_run.do MUT_ADDER
#   do mcu_module_run.do MUT_MUX1
# =============================================

set module_to_test $1

# Create and map work library
vlib work
vmap work work

# Compile source modules
vlog alu.v
vlog adder.v


# Compile universal testbench with selected module define
puts ">> Compiling testbench with +define+$module_to_test"
vlog +define+$module_to_test mcu_module_run.v

# Simulate
vsim mcu_module_tb

# Add all signals to waveform
add wave -r *

# Run simulation for 500 ns
run 50 ns


