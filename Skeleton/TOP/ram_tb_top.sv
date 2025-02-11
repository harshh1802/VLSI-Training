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
  
  //instantiate design
  ram DUT (.clk(clk), .rst(rif.rst), .we(rif.we), .wr_addr(rif.wr_addr), .wr_din(wr_din),.re(rif.re), .rd_addr(rif.rd_addr), .wr_dout(wr_dout));
  
  //
  initial begin
    ram_test = new();
    //create test
	//call require test methods and finaly call $finish
  end


endmodule