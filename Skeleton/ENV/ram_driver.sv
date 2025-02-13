`ifndef RAM_DRIVER_SV
`define RAM_DRIVER_SV


class ram_driver;

    ram_trans trans;
    mailbox #(ram_trans) mbx;
    virtual ram_interface.MP_DRV vif;



    function void connect(mailbox #(ram_trans) mbx, virtual ram_interface.MP_DRV vif);
        this.mbx = mbx;
        this.vif = vif;
    endfunction

    task run();
        forever begin
	    mbx.get(trans);
        $display("[DRIVER] %4t DIN : %p", $time, trans);
        sent_to_duv(trans);
        end
    endtask

    task sent_to_duv(ram_trans trans);

        @(vif.drv_cb)

         case(trans.trans_kind)
            WRITE: begin
                // Drive write signals
                vif.drv_cb.we <= 1'b1;
                vif.drv_cb.wr_addr <= trans.wr_addr;
                vif.drv_cb.wr_din <= trans.wr_data;
                
                @(vif.drv_cb); // Hold for one cycle
                vif.drv_cb.we <= 1'b0;
                
                $display("[DRIVER] %0t WRITE: Addr=%d Data=%d", 
                         $time,trans.wr_addr, trans.wr_data);
            end

            READ: begin
                // Drive read signals
                vif.drv_cb.re <= 1'b1;
                vif.drv_cb.rd_addr <= trans.rd_addr;

                @(vif.drv_cb); // Hold for one cycle
                vif.drv_cb.re <= 1'b0;
                
                $display("[DRIVER] %0t READ: Addr=%d", $time, trans.rd_addr);

            end

            SIM_RW: begin
                // Simultaneous read and write
                vif.drv_cb.we <= 1'b1;
                vif.drv_cb.re <= 1'b1;
                vif.drv_cb.wr_addr <= trans.wr_addr;
                vif.drv_cb.rd_addr <= trans.rd_addr;
                vif.drv_cb.wr_din <= trans.wr_data;

                 @(vif.drv_cb); // Hold for one cyclea
                vif.drv_cb.we <= 1'b0;
                vif.drv_cb.re <= 1'b0;
                
                $display("[DRIVER] %0t SIM_RW: RdAddr=%d WrAddr=%d WrData=%d", 
                         $time,trans.rd_addr, trans.wr_addr, trans.wr_data);
            
            end

            IDLE : $display("[DRIVER] %0t IDLE", $time);

            default: begin
                $error("[DRIVER] Invalid transaction type received");
            end
        endcase
    endtask

    // Reset task with posedge reset
    task reset();
        // Wait for reset assertion
        @(posedge vif.drv_cb.rst);
        $display("[DRIVER] %0t Reset asserted", $time);
        
        // Clear all control signals during reset
        vif.drv_cb.we   <= 1'b0;
        vif.drv_cb.re   <= 1'b0;
        vif.drv_cb.wr_addr <= '0;
        vif.drv_cb.rd_addr <= '0;
        vif.drv_cb.wr_din  <= '0;
        
        // Wait for reset de-assertion
        @(negedge vif.rst);
        $display("[DRIVER] %0t Reset de-asserted", $time);
        
        // Optional: Add few clock cycles after reset
        // repeat(2) @(vif.drv_cb);
    endtask


endclass

`endif