`ifndef RAM_GENERATOR_SV
`define RAM_GENERATOR_SV

class ram_generator;

    ram_trans trans, trans_copy;

    mailbox #(ram_trans) mbx;

    function void connect(mailbox #(ram_trans) mbx);
        // $display("[Generator] Connecting mailbox...");
        this.mbx = mbx;
        // $display("[Generator] Mailbox connected");
    endfunction

    task run();
        trans = new();
        // $display("[Generator] Trans class created");

        repeat(25) begin
	    if (!trans.randomize())
            $error("RANDOMIZATION FAILED!");
	    trans_copy = new trans;
	    mbx.put(trans_copy);
        $display("[Generator] %0t DOUT = %p",$time, trans_copy);
        @(item_done_ev);
        // #10;
        end
    endtask

endclass

`endif