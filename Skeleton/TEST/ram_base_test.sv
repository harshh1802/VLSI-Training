`ifndef RAM_BASE_TEST_SV
`define RAM_BASE_TEST_SV


class ram_base_test;

  ram_environment ram_env
  
  virtual ram_interface rif;
   
   //create environment and call its methods here as needed
   function void build();

      ram_env = new();

   function
   
   function void connect(virtual ram_interface rif);

      this.rif = rif

   function
   
   task run();
    :
   endtask
     
  
endclass

`endif