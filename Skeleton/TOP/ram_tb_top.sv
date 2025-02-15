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
  ram DUT (.clk(clk), .rst(rif.rst), .we(rif.we), .wr_addr(rif.wr_addr), .wr_din(rif.wr_din),.re(rif.re), .rd_addr(rif.rd_addr), .rd_dout(rif.rd_dout));
  
  //
  // Main test flow
  initial begin
    // Initial reset
    rif.rst <= 1'b0;      // Initialize reset to inactive
    #10;                  // Wait for some time
    rif.rst <= 1'b1;      // Assert reset
    #20;                  // Hold reset
    rif.rst <= 1'b0;      // De-assert reset
    
    // Start the test
    ram_test = new();
    ram_test.build();
    ram_test.connect(rif);  
    ram_test.run();
  end
  // initial begin

  //   drv_cb
  //   ram_test = new();
  //   ram_test.build();
  //   ram_test.connect(rif);
  //   // Initial reset
  //   rif.rst <= 1'b0;      // Initialize reset to inactive
  //   #10;                  // Wait for some time
  //   rif.rst <= 1'b1;      // Assert reset
  //   #20;                  // Hold reset
  //   rif.rst <= 1'b0;   

  //   ram_test.run();
  //   //create test
	// //call require test methods and finaly call $finish
  // end


  initial begin

    forever @(rif.mntr_cb)
    // Monitor relevant signals
        $monitor("[Interface MON CB] Time=%0t | rst=%d | we=%d | wr_addr=%d | wr_din=%d | re=%d | rd_addr=%d | rd_dout=%d",
              $time, rif.mntr_cb.rst, rif.mntr_cb.we, rif.mntr_cb.wr_addr,
              rif.mntr_cb.wr_din, rif.mntr_cb.re, rif.mntr_cb.rd_addr, rif.mntr_cb.rd_dout);
  end

  initial begin

    forever @(rif.mntr_cb)
    // Monitor relevant signals
        $monitor("[Interface] Time=%0t | rst=%d | we=%d | wr_addr=%d | wr_din=%d | re=%d | rd_addr=%d | rd_dout=%d",
              $time, rif.rst, rif.we, rif.wr_addr,
              rif.wr_din, rif.re, rif.rd_addr, rif.rd_dout);
  end


endmodule