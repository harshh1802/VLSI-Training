`ifndef RAM_MONITER_SV
`define RAM_MONITER_SV


class ram_monitor;

  ram_trans trans;

  mailbox #(ram_trans) mon2ref; // Monitor to reference model
  mailbox #(ram_trans) mon2scb; //Monitor to scoreboard

  virtual ram_interface.MP_MON vif;
  
  function void connect(mailbox #(ram_trans) mon2ref, mailbox #(ram_trans) mon2scb, virtual ram_interface.MP_MON vif);
        this.mon2ref = mon2ref;
        this.mon2scb = mon2scb;
        this.vif = vif;
    endfunction

  //discription
task run();
    forever begin
      @(vif.mntr_cb);
      if (!vif.mntr_cb.rst) begin  // Only monitor when not in reset
        if (vif.mntr_cb.we || vif.mntr_cb.re) begin  // If there's a write or read operation
          // $display("[Monitor] time = %0t,  we = %d , wr_addr = %d, wr_din = %d, re = %d, rd_addr = %d, rd_dout = %d",
          //             $time, vif.mntr_cb.we, vif.mntr_cb.wr_addr, vif.mntr_cb.wr_din, vif.mntr_cb.re, vif.mntr_cb.rd_addr, vif.mntr_cb.rd_dout);
          monitor();
        end
      end
    end
  endtask

  
  task monitor();
        trans = new();
        
        // Determine transaction type based on control signals
        if (vif.mntr_cb.we && vif.mntr_cb.re) begin
            trans.trans_kind = SIM_RW;
            trans.wr_addr = vif.mntr_cb.wr_addr;
            trans.rd_addr = vif.mntr_cb.rd_addr;
            trans.wr_data = vif.mntr_cb.wr_din;
            
            // Wait one clock cycle to capture read data
            @(vif.mntr_cb);
            
            $display("[MONITOR] %0t SIM_RW: RdAddr=%0h WrAddr=%0h WrData=%0h RdData=%0h",
                     $time, trans.rd_addr, trans.wr_addr, trans.wr_data, vif.mntr_cb.rd_dout);
                     
        end else if (vif.mntr_cb.we) begin
            trans.trans_kind = WRITE;
            trans.wr_addr = vif.mntr_cb.wr_addr;
            trans.wr_data = vif.mntr_cb.wr_din;
            
            $display("[MONITOR] %0t WRITE: Addr=%0h Data=%0h",
                     $time, trans.wr_addr, trans.wr_data);
                     
        end else if (vif.mntr_cb.re) begin
            trans.trans_kind = READ;
            trans.rd_addr = vif.mntr_cb.rd_addr;
            
            // Wait one clock cycle to capture read data
            @(vif.mntr_cb);
            
            $display("[MONITOR] %0t READ: Addr=%0h Data=%0h",
                     $time, trans.rd_addr, vif.mntr_cb.rd_dout);
                     
        end else begin
            trans.trans_kind = IDLE;
            $display("[MONITOR] %0t IDLE", $time);
        end
        
        // Send transaction to reference model and scoreboard
        mon2ref.put(trans);
        mon2scb.put(trans);
    endtask
 
endclass
`endif