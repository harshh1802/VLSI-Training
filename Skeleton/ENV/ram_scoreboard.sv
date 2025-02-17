`ifndef RAM_SCOREBOARD
`define RAM_SCOREBOARD


class ram_scoreboard;

    ram_trans act_trans, exp_trans;  // Actual and expected transactions
  
    mailbox #(ram_trans) mon2scb; // Monitor to reference model
    mailbox #(ram_trans) ref2scb; //Reference model to scoreboard

    // Counters for tracking results
    int total_cmps;       // Total comparisons
    int passed_cmps;      // Passed comparisons
    int failed_cmps;      // Failed comparisons

    function void connect(mailbox  #(ram_trans) mon2scb, mailbox #(ram_trans) ref2scb);
        this.mon2scb = mon2scb;
        this.ref2scb = ref2scb;

        // Initialize counters
        total_cmps = 0;
        passed_cmps = 0;
        failed_cmps = 0;

    endfunction
  
  
    task run();
        forever begin
            // Get transactions from both monitor and reference model
            mon2scb.get(act_trans);
            ref2scb.get(exp_trans);
            
            // Compare transactions
            check_data(act_trans, exp_trans);
        end
    endtask
    
    task check_data(ram_trans act_trans, ram_trans exp_trans);
        bit comparison_passed = 1;
        string mismatch_details = "";
        total_cmps++;
        
        // Compare based on transaction type
        case(act_trans.trans_kind)
            READ: begin
                // For read operations, compare read data
                if(act_trans.rd_data !== exp_trans.rd_data) begin
                    comparison_passed = 0;
                    mismatch_details = $sformatf("Read Data Mismatch: Expected=%0h, Actual=%0h", 
                                                exp_trans.rd_data, act_trans.rd_data);
                end
            end
            
            SIM_RW: begin
                // For simultaneous read/write, compare read data
                if(act_trans.rd_data !== exp_trans.rd_data) begin
                    comparison_passed = 0;
                    mismatch_details = $sformatf("SIM_RW Read Data Mismatch: Expected=%0h, Actual=%0h", 
                                                exp_trans.rd_data, act_trans.rd_data);
                end
            end
            
            WRITE: begin
                // For write operations, no comparison needed
                // Just verify transaction types match
                if(act_trans.trans_kind !== exp_trans.trans_kind) begin
                    comparison_passed = 0;
                    mismatch_details = "Transaction type mismatch for WRITE operation";
                end
            end
            
            IDLE: begin
                // For idle operations, just verify transaction types match
                if(act_trans.trans_kind !== exp_trans.trans_kind) begin
                    comparison_passed = 0;
                    mismatch_details = "Transaction type mismatch for IDLE operation";
                end
            end
        endcase
        
        // Update counters and display results
        if(comparison_passed) begin
            passed_cmps++;
            $display("[SCOREBOARD] %0t PASS: Transaction type=%s", $time, act_trans.trans_kind);
        end else begin
            failed_cmps++;
            $error("[SCOREBOARD] %0t FAIL: Transaction type=%s\n%s", 
                   $time, act_trans.trans_kind, mismatch_details);
        end
    endtask
    
    // Task to display final results
    task display_results();
        $display("\n[SCOREBOARD] Final Results:");
        $display("Total Comparisons: %0d", total_cmps);
        $display("Passed: %0d", passed_cmps);
        $display("Failed: %0d", failed_cmps);
        $display("Pass Rate: %0.2f%%\n", (passed_cmps * 100.0) / total_cmps);
        
        if(failed_cmps == 0)
            $display("[SCOREBOARD] Test PASSED - All comparisons successful!");
        else
            $error("[SCOREBOARD] Test FAILED - %0d comparisons failed!", failed_cmps);
    endtask
  
 endclass

`endif 