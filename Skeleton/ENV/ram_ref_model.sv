`ifndef RAM_REFERENCE_MODEL
`define RAM_REFERENCE_MODEL

class ram_ref_model;
    ram_trans trans;
    
    mailbox #(ram_trans) mon2ref; // Monitor to reference model
    mailbox #(ram_trans) ref2scb; //Reference model to scoreboard
    
    // Memory array to store data
    bit [`DATA_WIDTH-1:0] mem [`DEPTH];
    
    function void connect(mailbox #(ram_trans) mon2ref, mailbox #(ram_trans) ref2scb);
        this.mon2ref = mon2ref;
        this.ref2scb = ref2scb;
        // Initialize memory array
        foreach(mem[i]) mem[i] = '0;
    endfunction
    
    task run();
        forever begin
            ram_trans ref_trans;
            
            // Get transaction from monitor
            mon2ref.get(trans);
            
            // Create new transaction for reference model
            ref_trans = new();
            
            // Copy original transaction
            ref_trans.trans_kind = trans.trans_kind;
            ref_trans.rd_addr = trans.rd_addr;
            ref_trans.wr_addr = trans.wr_addr;
            ref_trans.wr_data = trans.wr_data;
            
            // Predict expected read data
            predict_exp_rd_data(ref_trans);
        end
    endtask
    
    task predict_exp_rd_data(ram_trans ref_trans);
        // Model RAM behavior based on transaction type
        case(ref_trans.trans_kind)
            WRITE: begin
                // Update memory array
                mem[ref_trans.wr_addr] = ref_trans.wr_data;
                $display("[REF_MODEL] %0t WRITE: Addr=%0d Data=%0d", 
                         $time, ref_trans.wr_addr, ref_trans.wr_data);
            end
            
            READ: begin
                // Read from memory array into rd_data field
                ref_trans.rd_data = mem[ref_trans.rd_addr];
                $display("[REF_MODEL] %0t READ: Addr=%0d Expected Data=%0d", 
                         $time, ref_trans.rd_addr, ref_trans.rd_data);
            end
            
            SIM_RW: begin
                // Handle simultaneous read and write
                // First capture read data (before potential write to same address)
                ref_trans.rd_data = mem[ref_trans.rd_addr];
                
                // Then perform write
                mem[ref_trans.wr_addr] = ref_trans.wr_data;
                
                $display("[REF_MODEL] %0t SIM_RW: RdAddr=%0d ExpectedRdData=%0d WrAddr=%0d WrData=%0d",
                         $time, ref_trans.rd_addr, ref_trans.rd_data, ref_trans.wr_addr, ref_trans.wr_data);
            end
            
            IDLE: begin
                $display("[REF_MODEL] %0t IDLE", $time);
            end
        endcase
        
        // Send reference transaction to scoreboard
        ref2scb.put(ref_trans);
    endtask
    
    // Task to dump memory contents (useful for debug)
    task dump_memory();
        $display("[REF_MODEL] Memory Contents:");
        foreach(mem[i]) begin
            $display("Addr %0d: Data %0d", i, mem[i]);
        end
    endtask
    
endclass

`endif