`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  aluop_t     aluop;
  word_t      instr;
  logic       mem_read, mem_write, regWr, halt, alu_src, extend, branch, bne, datomic;
  logic[1:0]  reg_dst, mem_to_reg, jump;

  modport control(
    input instr,
    output aluop, mem_read, mem_to_reg, mem_write, regWr, halt, extend, 
    reg_dst, alu_src, branch, jump, bne, datomic
  );

  modport tb(
    input aluop, mem_read, mem_to_reg, mem_write, regWr, halt, extend, 
    reg_dst, alu_src, branch, jump, bne, datomic,
    output instr
);

endinterface
`endif //CONTROL_UNIT_IF