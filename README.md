# Microcontroller_8_bit

This project implements a simple microcontroller in Verilog and verifies it using ModelSim.

📁 Project Files
File	Description
MicroController.v	Top-level microcontroller integrating PC, ALU, control logic, memories, MUXes.
Control_Logic.v	Generates control signals for each module based on IR and state machine.
ALU.v	Arithmetic and logic unit (ADD, SUB, AND, OR, etc).
adder.v	Simple 8-bit adder for PC increment.
MUX1.v	Multiplexer to select PC next value or ALU operand.
DMem.v	Data Memory (RAM) for load/store.
PMem.v	Program Memory (ROM) storing instruction words.
microcontroller_tb.v	Testbench for simulating MicroController.v.
mcu_module_run.v	Testbench that supports module-wise verification using preprocessor defines.
mcu_module_run.do	ModelSim script for building, simulating, and adding waveforms.
🚀 How to Run in ModelSim
1️⃣ Open ModelSim 2️⃣ Change to your project directory:

cd path/to/your/project
3️⃣ Run the main simulation:

do mcu_module_run.do
⚡ Run Module-Wise Test
To simulate specific module testbenches using mcu_module_run.v:

Example commands:
do mcu_module_run.do +define+MUT_ALU
➡ Tests the ALU module.

do mcu_module_run.do +define+MUT_adder
➡ Tests the adder module.

do mcu_module_run.do +define+MUT_MUX1
➡ Tests the MUX1 module.

do mcu_module_run.do +define+MUT_DMem
➡ Tests the DMem module.

🧠 Microcontroller Operation
PC (Program Counter): Holds the address of the current instruction.
IR (Instruction Register): Stores the instruction fetched from program memory.
DR (Data Register): Temporary register to hold data read from or to be written to data memory.
SR (Status Register): Stores status flags — Zero (Z), Carry (C), Sign (S), Overflow (O).
Acc (Accumulator): Main register used in arithmetic/logic operations.
📝 Example Program (program_mem.dat)
Example program loaded into PMem:

0000_0000_0000  // NOP
1011_0000_0001  // Load Acc = 00000001
0010_0010_0000  // Store Acc -> DMem[2]
1011_0000_0000  // Load Acc = 00000000
0011_0011_0000  // Load Acc <- DMem[3]
0001_0000_0101  // Add 00000101 to Acc
0000_0000_0000  // NOP
0000_0000_0000  // NOP
0000_0000_0000  // NOP
0000_0000_0000  // NOP
Meaning of instructions:
Instruction	Function
0000 0000 0000	NOP (No Operation)
1011 dddd dddd	Load Accumulator with literal dddd dddd
0010 aaaa dddd	Store Accumulator to data memory at address aaaa
0011 aaaa dddd	Load Accumulator from data memory at address aaaa
0001 dddd dddd	ADD literal dddd dddd to Accumulator
🌟 Notes
✅ Modify program_mem.dat to create your own instruction sequence. ✅ Use ModelSim waveforms to observe internal signals (PC, Acc, SR, DR, IR, etc). ✅ The .do file handles compilation, simulation, and waveform setup.

🏁Command Summary
do mcu_module_run.do                    # Run full microcontroller test
do mcu_module_run.do +define+MUT_ALU     # Run ALU module test
do mcu_module_run.do +define+MUT_adder   # Run adder module test
do mcu_module_run.do +define+MUT_MUX1    # Run MUX1 module test
do mcu_module_run.do +define+MUT_DMem    # Run DMem module test
💡 Example Waveform Command in ModelSim
add wave -r *
run 500ps
Or adjust simulation time as needed.
