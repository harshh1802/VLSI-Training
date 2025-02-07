`include "ram_defines.sv"

module ram #(
    parameter ADDR_WIDTH = `ADDR_WIDTH,   // Address width (default: 4)
    parameter DATA_WIDTH = `DATA_WIDTH,   // Data width (default: 8)
    parameter DEPTH      = `DEPTH         // Memory depth (default: 16)
) (
    input  logic                   clk,      // Clock signal
    input  logic                   rst,      // Reset signal (active high)
    
    // Write Interface
    input  logic                   we,       // Write Enable (active high)
    input  logic [ADDR_WIDTH-1:0]  wr_addr,     // Write Address
    input  logic [DATA_WIDTH-1:0]  wr_din,      // Data Input
    
    // Read Interface
    input  logic                   re,       // Read Enable (active high)
    input  logic [ADDR_WIDTH-1:0]  rd_addr,  // Read Address
    output logic [DATA_WIDTH-1:0]  rd_dout   // Read Data Output
);

    // Declare the RAM using parameterized width and depth
    logic [DATA_WIDTH-1:0] ram [0:DEPTH-1];

    always_ff @(posedge clk) begin
        if (rst) begin
            // Reset all memory locations to 0
            for (int i = 0; i < DEPTH; i++) begin
                ram[i] <= '0;
            end
            rd_dout <= '0;  // Reset read data output as well
        end
        else begin
            if (we) begin
                // Write operation
                ram[wr_addr] <= wr_din;
            end
            if (re) begin
                // Read operation
                rd_dout <= ram[rd_addr];
            end
        end
    end

endmodule
