`include "ram_driver.sv"
`include "ram_generator.sv"


module exp;

    bit clk = 0;

    ram_trans trans;

    ram_generator rg;
    ram_driver rd;

    mailbox #(ram_trans) mbx;

    ram_interface rvif(clk);

    // always@(posedge clk)
    //     if (rvif.we || rvif.re) 
    //         $display("[Interface] we = %d , wr_addr = %d , re = %d, rd_addr = %d", rvif.we, rvif.wr_addr, rvif.re, rvif.wr_addr);


    initial begin
        mbx = new();
        rg = new();
        rd = new();
        rg.connect(mbx);
        rd.connect(mbx, rvif);
        fork
            forever begin
                #5 clk = ~clk;
            end

            rd.run();
            rg.run();

        join_none
            #200 $finish;
    end


endmodule