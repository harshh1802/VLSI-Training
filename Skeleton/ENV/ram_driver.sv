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
        repeat(10) begin
	    mbx.get(trans);
        $display("RAM DRIVER DATA IN : %p", trans);
        sent_to_duv(trans);
        end
    endtask

    task sent_to_duv(ram_trans trans);

         case(trans.trans_type)
            WRITE: begin
                // Drive write signals
                vif.drv_cb.we <= 1'b1;
                vif.drv_cb.wr_addr <= trans.wr_addr;
                vif.drv_cb.wr_din <= trans.wr_data;
                
                // @(vif.drv_cb); // Hold for one cycle
                // vif.drv_cb.we <= 1'b0;
                
                $display("[DRIVER] Write operation: Addr=%d Data=%d", 
                         trans.wr_addr, trans.wr_data);
            end

            READ: begin
                // Drive read signals
                vif.drv_cb.re <= 1'b1;
                vif.drv_cb.rd_addr <= trans.rd_addr;
                
                // @(vif.drv_cb); // Hold for one cycle
                // vif.drv_cb.re <= 1'b0;
                
                $display("[DRIVER] Read operation: Addr=%d", trans.rd_addr);
            end

            SIM_RW: begin
                // Simultaneous read and write
                vif.drv_cb.we <= 1'b1;
                vif.drv_cb.re <= 1'b1;
                vif.drv_cb.wr_addr <= trans.wr_addr;
                vif.drv_cb.rd_addr <= trans.rd_addr;
                vif.drv_cb.wr_din <= trans.wr_data;
                
                // @(vif.drv_cb); // Hold for one cycle
                // vif.drv_cb.we <= 1'b0;
                // vif.drv_cb.re <= 1'b0;
                
                $display("[DRIVER] Simultaneous R/W: RdAddr=%d WrAddr=%d WrData=%d", 
                         trans.rd_addr, trans.wr_addr, trans.wr_data);
            end

            default: begin
                $error("[DRIVER] Invalid transaction type received");
            end
        endcase
    endtask

endclass

`endif