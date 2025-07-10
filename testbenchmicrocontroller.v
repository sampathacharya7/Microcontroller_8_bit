timescale 1ns / 1ps

module microcontroller_module_tb;

`ifdef MUT_ALU
    reg [7:0] Operand1, Operand2;
    reg [3:0] Mode;
    reg E;
    wire [7:0] Out;
    wire [3:0] CFlags;
    wire Flags;

    ALU uut (
        .Operand1(Operand1),
        .Operand2(Operand2),
        .Mode(Mode),
        .E(E),
        .Out(Out),
        .CFlags(CFlags),
        .Flags(Flags)
    );

`elsif MUT_ADDER
    reg [7:0] in1;
    wire [7:0] sum;

    adder uut (
        .in1(in1),
        .sum(sum)
    );

`elsif MUT_MUX1
    reg sel;
    reg [7:0] in0, in1_mux;
    wire [7:0] out;

    MUX1 uut (
        .sel(sel),
        .in0(in0),
        .in1(in1_mux),
        .out(out)
    );

`else
    initial begin
        $display(" ERROR: No MUT selected! Use +define+MUT_ALU, +define+MUT_ADDER, or +define+MUT_MUX1");
        $finish;
    end
`endif

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, mcu_module_tb);

`ifdef MUT_ALU
    Operand1 = 8'd12;
    Operand2 = 8'd5;
    Mode = 4'b0000; E = 1'b1; #20;
    $display("ALU Out = %d CFlags = %b Flags = %b", Out, CFlags, Flags);

    Mode = 4'b0001; #20;
    $display("ALU Out = %d CFlags = %b Flags = %b", Out, CFlags, Flags);

    Mode = 4'b0010; #20;
    $display("ALU Out = %d CFlags = %b Flags = %b", Out, CFlags, Flags);

`elsif MUT_ADDER
    in1 = 8'd15; in2 = 8'd10; #20;
    $display("Adder sum = %d", sum);
    in1 = 8'd100; in2 = 8'd55; #20;
    $display("Adder sum = %d", sum);

`elsif MUT_MUX1
    in0 = 8'd8; in1_mux = 8'd20; sel = 0; #20;
    $display("MUX1 out (sel=0) = %d", out);
    sel = 1; #20;
    $display("MUX1 out (sel=1) = %d", out);

`endif

    #10 $finish;
end

endmodule
