`ifndef RAM_PKG_SV
`define RAM_PKG_SV

// `include "ram_defines.sv"


package ram_pkg;

    event item_done_ev;

        `include "ram_defines.sv"
        `include "ram_trans.sv"
        `include "ram_generator.sv"
        `include "ram_driver.sv"
        `include "ram_monitor.sv"
        `include "ram_ref_model.sv"
        `include "ram_scoreboard.sv"
        `include "ram_environment.sv"
        `include "ram_base_test.sv"

  //add all file till test, don't miss the order
  
endpackage

`include "ram_interface.sv"

`endif