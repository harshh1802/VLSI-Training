`ifndef RAM_INTERFACE_SV
`define RAM_INTERFACE_SV

interface ram_interface(input clk);

    logic rst;      // Reset signal (active high)

    logic we;       // Write Enable (active high)
    logic [`ADDR_WIDTH-1:0] wr_addr;     // Write Address
    logic [`DATA_WIDTH-1:0] wr_din;     // Data Input
    
    // Read Interface
    logic re;       // Read Enable (active high)
    logic [`ADDR_WIDTH-1:0] rd_addr;  // Read Address
    logic [`DATA_WIDTH-1:0] rd_dout;  // Read Data Output


    clocking drv_cb @(posedge clk);

        default input #1 output #1;
        input rst, rd_dout;
        output we, wr_addr, wr_din, re , rd_addr;


    endclocking

    clocking mntr_cb @(posedge clk);

        default input #1 output #1;
        input rst;
        input we, wr_addr, wr_din, re , rd_addr, rd_dout;


    endclocking

    modport MP_DRV (clocking drv_cb, input rst);
    modport MP_MON (clocking mntr_cb);

    
endinterface //rame_interface


`endif
