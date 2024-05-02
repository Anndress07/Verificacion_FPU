class driver;
  stimulus sti;
  scoreboard sb;
 
  virtual intf_cnt intf;
        
  function new(virtual intf_cnt intf,scoreboard sb);
    this.intf = intf;
    this.sb = sb;
  endfunction
        
  task reset();  // Reset method
    $display("Executing reset\n");
    @ (posedge intf.clk);
    //intf.out = 0;
    intf.opa = 0;
    intf.opb = 0;
    intf.rmode = 0;
    intf.fpu_op = 0;
  endtask
  
  task addition(input integer iteration);
    repeat(iteration)
    begin
      sti = new();
      @ (posedge intf.clk); // sincronizacion, no es un  "always"
      if(sti.randomize()) // Generate stimulus Se pone 'if' por que el randomize 							puede fallar si tiene constraints que no cumple
        $display("Executing addition\n");
        $display("Driving 0x%h valueA in the DUT\n", sti.valueA);
        $display("Driving 0x%h valueB in the DUT\n", sti.valueB);
        intf.rmode = 0;
       	intf.fpu_op = 0;
        intf.opa = sti.valueA;
        intf.opb = sti.valueB;
      sb.store.push_front(sti.valueA);// Cal exp value and store in Scoreboard

    end
  endtask
  
  
  task substraction(input integer iteration);
      repeat(iteration)
      begin
        sti = new();
        @ (posedge intf.clk);
        if(sti.randomize()) 
      $display("Executing subtraction\n");        
        $display("Driving 0x%h valueA in the DUT\n", sti.valueA);
        $display("Driving 0x%h valueB in the DUT\n", sti.valueB);
          intf.fpu_op = 1;
      intf.rmode = 2;
          intf.opa = sti.valueA; 
          intf.opb = sti.valueB;
          sb.store.push_front(sti.valueA);
      end
    endtask
  
  
  task multiplication(input integer iteration);
    
    repeat(iteration)
    begin
      sti = new();
      @ (posedge intf.clk); 
      if(sti.randomize()) 
        $display("Executing multiplication\n");
      	$display("Driving 0x%h valueA in the DUT\n", sti.valueA);
        $display("Driving 0x%h valueB in the DUT\n", sti.valueB);
      	intf.fpu_op = 2;
        intf.opa = sti.valueA; 
        intf.opb = sti.valueB; 
        sb.store.push_front(sti.valueA);
    end
  endtask
      
  task division(input integer iteration);
      repeat(iteration) begin
        sti = new();

        @ (posedge intf.clk); 

        if(sti.randomize()) 
          $display("Executing division\n");
          $display("Driving 0x%h valueA in the DUT\n", sti.valueA);
          $display("Driving 0x%h valueB in the DUT\n", sti.valueB);
          intf.fpu_op = 3;
          intf.opa = sti.valueA; 
          sb.store.push_front(sti.valueA);
      end
  endtask
  
//   task read(input integer iteration);
//     repeat(iteration)
//     begin
//        @ (negedge intf.clk);
//        intf.rd_en = 1;
//        //intf.rd_cs = 1;
//     end
//     @ (negedge intf.clk);
//     intf.rd_en = 0; // 1 flanco despues se baja el read enable
//     //intf.rd_cs = 0;
//   endtask

endclass
