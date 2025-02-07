`ifndef RAM_MONITER_SV
`define RAM_MONITER_SV


class ram_monitor;

  ram_trans trans;

  mailbox #(ram_trans) mon2ref; // Monitor to reference model
  mailbox #(ram_trans) mon2scb; //Monitor to scoreboard

  virtual ram_interface.MP_MON vif;
  
  function void connect(mailbox #(mailbox #(ram_trans) mon2ref, mailbox #(ram_trans) mon2scb, virtual ram_interface.MP_MON vif);
        this.mon2ref = mon2ref;
        this.mon2scb = mon2scb;
        this.vif = vif;
    endfunction
  
  //discription
  task run();
    //sample/monitor the data from interface as per protocol and put it in
	//the mailbox to further use by other component
	//keep separte task for monitoring
  endtask
  
  //discription
  task monitor();
   //sample data from design
   //create trans_h
   //trans_h.wr_addr = vif.wmon_cb.wr_addr;
   //trans_h.kind_e = kind'{vif.wmon_cb.wr_enb,vif.wmon_cb.rd_enb};
   //$cast(trans_h.kind_e,{vif.wmon_cb.wr_enb,vif.wmon_cb.rd_enb});
   
  endtask
 
endclass
`endif macro