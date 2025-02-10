`ifndef RAM_GENERATOR_SV
`define RAM_GENERATOR_SV

class ram_generator;

    ram_trans trans, trans_copy;

    mailbox #(ram_trans) mbx;

    function void connect(mailbox #(ram_trans) mbx);
        this.mbx = mbx;
    endfunction

    task run();
        trans = new();
        repeat(10) begin
	    
	    if (!trans.randomize())
            $error("RANDOMIZATION FAILED!");
	    trans_copy = new trans;
	    mbx.put(trans_copy);
        $display("RAM GENERATOR DATA OUT = %p", trans_copy);
        #1;
        end
    endtask

endclass

`endif