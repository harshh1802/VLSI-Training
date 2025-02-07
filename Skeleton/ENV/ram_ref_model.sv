`ifndef RAM_REFERENCE_MODEL
`define RAM_REFERENCE_MODEL


class ram_ref_model;

  ram_trans trans;
  
  mailbox #(ram_trans) mon2ref; // Monitor to reference model
  mailbox #(ram_trans) ref2scb; //Reference model to scoreboard

  function void connect(mailbox #(mailbox #(ram_trans) mon2ref, mailbox #(ram_trans) ref2scb);
        this.mon2ref = mon2ref;
        this.ref2scb = ref2scb;
    endfunction
  
  
  task run();
   repeat(10) begin
    //collect data from mailbox
	// predict_exp_rd_data(trans_h);
	//put transaction for scoboard
   end
  endtask
    
//   //description
//  task predict_exp_rd_data(ram_trans trans_h);
  
//  endtask
  
 endclass



`endif 