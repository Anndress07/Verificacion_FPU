module top();
  reg clk = 0;
  initial // clock generator
  forever #5 clk = ~clk;
   
  // Interface
  intf_cnt intf(clk);
  
  // DUT connection	
//   sync_fifo dut (
//     .clk   (clk), 
//     .rst   (intf.rst),
//     .wr_cs  (intf.wr_cs),
//     .rd_cs  (intf.rd_cs),
//     .data_in (intf.data_in),
//     .rd_en  (intf.rd_en),
//     .wr_en  (intf.wr_en),
//     .data_out (intf.data_out),
//     .empty  (intf.empty),
//     .full   (intf.full) 
//   );
  
  fpu uut(.clk(clk), 
          .rmode      (intf.rmode), 
          .fpu_op     (intf.fpu_op),
          .opa        (intf.opa), 
          .opb        (intf.opb), 
          .out        (intf.out), 
          .inf        (intf.inf),
          .snan       (intf.snan),
          .qnan       (intf.qnan), 
          .ine        (intf.ine),
          .overflow   (intf.overflow),
          .underflow  (intf.underflow),
          .zero       (intf.zero),
          .div_by_zero(intf.div_by_zero));

  initial begin
    $dumpfile("verilog.vcd");
    $dumpvars(0);
  end

  //Test case
  testcase test(intf);

endmodule
