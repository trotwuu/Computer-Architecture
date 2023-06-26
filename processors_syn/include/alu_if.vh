/*
  ALU interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  logic     negative, overflow, zero;
  aluop_t aluop;
  word_t    port_a, port_b, outport;

  // alu ports
  modport alu (
    input   aluop, port_a, port_b,
    output  negative, overflow, zero, outport
  );
  // alutb
  modport tb (
    input   negative, overflow, zero, outport,
    output  aluop, port_a, port_b
  );
endinterface

`endif //ALU_IF_VH