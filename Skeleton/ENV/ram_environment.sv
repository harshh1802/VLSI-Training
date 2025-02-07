'ifndef RAM_ENVIRONMENT_SV
'define RAM_ENVIRONMENT_SV

class ram_environment;

  ram_trans trans;
  ram_generator ram_gen;
  ram_driver ram_dri;
  ram_monitor ram_mon;
  ram_ref_model ram_ref_m;
  ram_scoreboard ram_sb;
  
  //declare all mailboxs
  mailbox #(ram_trans) gen2drv;
  mailbox #(ram_trans) mon2ref;
  mailbox #(ram_trans) mon2scb;
  mailbox #(ram_trans) ref2scb;
  
  //declare all interface
  virtual ram_interface rif;
   
   //create all the component in this method
   function void build();

      ram_gen = new();
      ram_dri = new();
      ram_mon = new();
      ram_ref_m = new();
      ram_sb = new();

      gen2drv = new();
      mon2ref = new();
      mon2scb = new();
      ref2scb = new();


   endfunction
  
     //call all verif sub component connect method here
  function void connect(virtual ram_interface rif);

      this.rif = rif;

      ram_gen.connect(gen2drv);
      ram_dri.connect(gen2drv, inf_drv);
      ram_mon.connect(mon2ref, mon2scb, inf_drv);
      ram_ref_m.connect(mon2ref, ref2scb);
      ram_sb.connect(mon2scb, ref2scb);



  endfunction
  
  //call all verif sub component run task in parallel
  task run();
  :
  endtask
  
endclass

'endif