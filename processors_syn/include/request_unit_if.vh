`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic ihit, dhit, mem_write, mem_read;
  logic dmemREN, dmemWEN, imemREN;

  modport request_port (
      input ihit, dhit, mem_write, mem_read,
      output dmemREN, dmemWEN, imemREN
  );
  modport tb(
      input dmemREN, dmemWEN, imemREN,
      output ihit, dhit, mem_write, mem_read
  );

endinterface
`endif //Request unit interface