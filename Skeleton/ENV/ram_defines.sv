///////////////////////////////////
//
//      HEADER (ram_defines.sv, Harsh, module/intreface/class name,
//              discription, version, date, time
//   FILE_NAME : ram_defines.sv
//
/////////////////////////////////////

//Gaurd Statment to avoid multiple compilation of a file
`ifndef RAM_DEFINES_SV
`define RAM_DEFINES_SV
//typedef RAM_DEFINES_SV

`define ADDR_WIDTH 4
`define DATA_WIDTH 8
`define DEPTH 16
typedef enum bit [1:0] {IDLE, READ, WRITE, SIM_RW} trans_kind;

`endif