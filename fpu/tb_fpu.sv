`include "except.v"
`include "post_norm.v"
`include "pre_norm.v"
`include "pre_norm_fmul.v"
`include "primitives.v"




module tb_fpu;

    logic clk;
    logic [1:0] rmode;
    logic [2:0] fpu_op;
    logic [31:0] opa, opb;
    wire [31:0] out;
    wire  inf, snan, qnan, ine, overflow, zero,
        div_by_zero;

    fpu uut(.clk(clk), .rmode(rmode), .fpu_op(fpu_op),
             .opa(opa), .opb(opb), .out(out), 
             .inf(inf), .snan(snan), .qnan(qnan), 
             .ine(ine), .overflow(overflow), .zero(zero),
             .div_by_zero);

    initial begin
        $dumpfile("fpu.vcd");
        $dumpvars(0, tb_fpu);
        // suma
        clk = 0;                        // float 3.5        
        #10 fpu_op = 0; rmode = 0; opa = 32'h40600000; opb = 32'h40600000;
        
        // resta                   // float 1.12
        #100; fpu_op = 1;  opb = 32'h3f8f5c29 ;#100
        rmode = 2;
        // mult
        #100; fpu_op = 2;

        // div
        #100; fpu_op = 3;



        
        #100; 
        $finish;

    end

    always begin
        clk = !clk; #5;
    end
endmodule
