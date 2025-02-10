module ram_tb_top();

  import ram_pkg::*;

  bit clk;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  //take instance of actual interface

  ram_interface rif(clk);
  
  
  //take intance of test class
  ram_base_test ram_test;
  
  
  // //instantiate design
  // ram DUT (.clk(clk),
  //          .rst(inf.rst),
	// 	   .wr_enb(inf.we)
  
  // //
  // initial
  //   //create test
	// //call require test methods and finaly call $finish
	// :

endmodule