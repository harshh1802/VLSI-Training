`ifndef RAM_SCOREBOARD
`define RAM_SCOREBOARD


class ram_scoreboard;

    ram_trans trans;
  
    mailbox #(ram_trans) mon2scb; // Monitor to reference model
    mailbox #(ram_trans) ref2scb; //Reference model to scoreboard

    function void connect(mailbox  #(ram_trans) mon2scb, mailbox #(ram_trans) ref2scb);
        this.mon2scb = mon2scb;
        this.ref2scb = ref2scb;
    endfunction
  
  
    task run();
        repeat(10) begin
        //collect data from all mailboxs
        //compare act and exp and log the results
        end
    endtask
    
    //description
    task check_data(ram_trans act_trans, ram_trans exp_trans);
    
    endtask
  
 endclass



`endif 