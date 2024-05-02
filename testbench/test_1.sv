// program parecido al module pero tiene caracteristicas 
// que evitan race conditions, pero parecido a un modulo 
program testcase(intf_cnt intf);
  environment env = new(intf);
         
  initial
    begin
    env.drvr.reset();
    env.drvr.addition(1);
//     env.drvr.substraction(1);
//     env.drvr.multiplication(1);
//     env.drvr.division(1);
    
      #100; $finish;
    end
endprogram
