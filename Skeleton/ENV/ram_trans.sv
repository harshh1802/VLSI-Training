`ifndef RAM_TRANS_SV
`define RAM_TRANS_SV

// `include "ram_defines.sv"
typedef enum bit [1:0] {IDLE, READ, WRITE, SIM_RW} trans_kind_e;

class ram_trans;
    static int read_count;
    static int write_count;

    // TODO: Constraint
    // TODO: Why we can't take addr as rand?


    rand trans_kind_e trans_kind;

    randc bit [`ADDR_WIDTH - 1 : 0] rd_addr;
    randc bit [`ADDR_WIDTH - 1 : 0] wr_addr;
    rand bit [`DATA_WIDTH - 1 : 0] wr_data;
    bit [`DATA_WIDTH - 1 : 0] rd_data; // New non-randomized field for read data

    constraint addr {wr_addr <= 2**`ADDR_WIDTH ; rd_addr <= 2**`ADDR_WIDTH; };

    function void transaction();
        $display("Transaction Type = %s, rd_addr = %b, wr_addr = %b, wr_data = %b, rd_data = %b", 
                 trans_kind, rd_addr, wr_addr, wr_data, rd_data);
    endfunction

    function void prop();
        $display("Read Count = %d, Write Count = %d", read_count, write_count);
    endfunction

    function void post_randomize();
        case (trans_kind)
            READ    :     read_count = read_count + 1;
            WRITE   :     write_count = write_count + 1;
            SIM_RW  :     begin

                            read_count = read_count + 1;
                            write_count = write_count + 1;

                         end
        endcase
    endfunction



endclass

// module trans;

//     ram_trans trans1;

//     initial begin

//         repeat(20) begin
//             trans1 = new();
//             trans1.randomize();
//             trans1.transaction();
            
//         end

//         trans1.prop();



//         #10 $finish;
        
//     end



// endmodule

`endif

