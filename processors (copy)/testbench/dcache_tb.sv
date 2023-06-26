/*
  dcache test bench
*/

// mapped needs this
`include "datapath_cache_if.vh"
`include "cpu_ram_if.vh"
`include "caches_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;

  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  caches_if cif0();
  caches_if cif1();
  cpu_ram_if crif();
  cache_control_if #(.CPUS(2)) ccif(cif0, cif1);
  datapath_cache_if dcif0();
  datapath_cache_if dcif1();

  // test program
  test PROG (CLK, nRST, dcif0, dcif1);
  // cache0 instantiation
`ifndef MAPPED
  caches C1(CLK, nRST, dcif0, cif0);
`else
  caches C1(
  .\CLK (CLK),
  .\nRST (nRST),
  .\cif0.dwait (cif0.dwait),
  .\cif0.dload (cif0.dload),
  .\cif0.ccwait (cif0.ccwait),
  .\cif0.ccinv (cif0.ccinv),
  .\cif0.ccsnoopaddr (cif0.ccsnoopaddr),
  .\cif0.iwait (cif0.iwait),
  .\cif0.iload (cif0.iload),
  .\cif0.dREN (cif0.dREN),
  .\cif0.dWEN (cif0.dWEN),
  .\cif0.daddr (cif0.daddr),
  .\cif0.dstore (cif0.dstore),
  .\cif0.ccwrite (cif0.ccwrite),
  .\cif0.cctrans (cif0.cctrans),
  .\cif0.iREN (cif0.iREN),
	.\cif0.iaddr (cif0.iaddr),
  );
`endif

assign cif0.dwait = ccif.cif0.dwait;
assign cif0.dload = ccif.cif0.dload;
assign cif0.ccwait = ccif.cif0.ccwait;
assign cif0.ccinv = ccif.cif0.ccinv;
assign cif0.ccsnoopaddr = ccif.cif0.ccsnoopaddr;
assign cif0.iwait = ccif.cif0.iwait;
assign cif0.iload = ccif.cif0.iload;
assign ccif.cif0.dREN = cif0.dREN;
assign ccif.cif0.dREN = cif0.dREN;
 

// cache1 instantiation
`ifndef MAPPED
  caches C2(CLK, nRST, dcif1, cif1);
`else
  caches C2(
  .\CLK (CLK),
  .\nRST (nRST),
  .\cif1.dwait (cif1.dwait),
  .\cif1.dload (cif1.dload),
  .\cif1.ccwait (cif1.ccwait),
  .\cif1.ccinv (cif1.ccinv),
  .\cif1.ccsnoopaddr (cif1.ccsnoopaddr),
  .\cif1.iwait (cif1.iwait),
  .\cif1.iload (cif1.iload),
  .\cif1.dREN (cif1.dREN),
  .\cif1.dWEN (cif1.dWEN),
  .\cif1.daddr (cif1.daddr),
  .\cif1.dstore (cif1.dstore),
  .\cif1.ccwrite (cif1.ccwrite),
  .\cif1.cctrans (cif1.cctrans),
  .\cif1.iREN (cif1.iREN),
	.\cif1.iaddr (cif1.iaddr),
  );
`endif

assign cif1.dwait = ccif.cif1.dwait;
assign cif1.dload = ccif.cif1.dload;
assign cif1.ccwait = ccif.cif1.ccwait;
assign cif1.ccinv = ccif.cif1.ccinv;
assign cif1.ccsnoopaddr = ccif.cif1.ccsnoopaddr;
assign cif1.iwait = ccif.cif1.iwait;
assign cif1.iload = ccif.cif1.iload;
assign ccif.cif1.dREN = cif1.dREN;
assign ccif.cif1.dREN = cif1.dREN;

// MEMBUS
`ifndef MAPPED
  memory_control MEMBUS(CLK, nRST, ccif);
`else
  memory_control MEMBUS(
  .\CLK (CLK),
  .\nRST (nRST),
  .\ccif.iREN (ccif.iREN),
	.\ccif.dREN (ccif.dREN),
	.\ccif.dWEN (ccif.dWEN),
	.\ccif.dstore (ccif.dstore),
	.\ccif.iaddr (ccif.iaddr),
	.\ccif.daddr (ccif.daddr),
	.\ccif.ramload (ccif.ramload),
	.\ccif.ramstate (ccif.ramstate),
	.\ccif.iwait (ccif.iwait),
	.\ccif.dwait (ccif.dwait),
	.\ccif.iload (ccif.iload),
	.\ccif.dload (ccif.dload),
	.\ccif.ramstore (ccif.ramstore),
	.\ccif.ramaddr (ccif.ramaddr),
	.\ccif.ramWEN (ccif.ramWEN),
	.\ccif.ramREN (ccif.ramREN)
  );
`endif

`ifndef MAPPED
  ram RAM(CLK, nRST, crif);
`else
  ram RAM(
  .\CLK (CLK),
  .\nRST (nRST),
	.\crif.ramaddr (crif.ramaddr),
  .\crif.ramstore (crif.ramstore),
	.\crif.ramREN (crif.ramREN),
  .\crif.ramWEN (crif.ramWEN),
	.\crif.ramstate (crif.ramstate),
  .\crif.ramload (crif.ramload)
  );
`endif

assign ccif.ramload = crif.ramload;
assign ccif.ramstate = crif.ramstate;
assign crif.ramstore = ccif.ramstore;
assign crif.ramaddr = ccif.ramaddr;
assign crif.ramWEN = ccif.ramWEN;
assign crif.ramREN = ccif.ramREN;

endmodule

program test(input logic CLK, output logic nRST, datapath_cache_if dcif0, datapath_cache_if dcif1);
initial begin
  // declare testbench signals
  integer test_num;
  string test_name;
  integer i;
  
  // reset test case
  nRST = 0;
  @(posedge CLK);
  @(posedge CLK);
  nRST = 1;
  dcif.halt = 0;
  @(posedge CLK);
  @(posedge CLK);

  // ********************************************************************************************************
  // Testcase 1: C0 I -> S
  // ********************************************************************************************************
  test_num = test_num + 1;
  test_name = "C0 I -> S";

  dcif0.dmemREN = 1;
  dcif0.dmemaddr = 32'h400;

  wait(dcif.cif0.dhit);
  wait(dcif.cif0.dhit);
  dcif0.dmemREN = 0;

  dcif0.dmemaddr = '0;

  @(posedge CLK);

  // ********************************************************************************************************
  // Testcase 2: C0 S -> M
  // ********************************************************************************************************
  test_num = test_num + 1;
  test_name = "C0 S -> M";

  dcif0.dmemWEN = 1;
  dcif0.daddr = 32'h00000400;
  dcif0.dstore = 32'h11111111;

  wait(dcif.cif0.dhit);
  wait(dcif.cif0.dhit);

  dcif0.dmemWEN = 0;
  @(posedge CLK);


  // ********************************************************************************************************
  // Testcase 3: C0 I -> M
  // ********************************************************************************************************
  test_num = test_num + 1;
  test_name = "C0 I -> M";

  // reset c0 to I by writing to c1
  dcif1.dmemWEN = 1;
  dcif1.daddr = 32'h3fc;
  dcif1.dstore = 32'h22222222;
  wait(dcif.cif1.dhit);
  dcif1.dmemWEN = 0;
  // now c1 is in M so c0 is in I

  // now do c0 I -> M
  dcif0.dmemWEN = 1;
  dcif0.daddr = 32'h000003f8;
  dcif0.dstore = 32'h33333333;

  wait(dcif.cif0.dhit);

  dcif0.dmemWEN = 0;
  @(posedge CLK);


  // ********************************************************************************************************
  // Testcase 4: C1 I -> M while C0 in M
  // ********************************************************************************************************
  test_num = test_num + 1;
  test_name = "C1 I -> M while C0 in M";

  // C0 is in M already from previous testcase
  dcif1.dmemWEN = 1;
  dcif1.dstore = 32'h55555555;
  dcif1.daddr = 32'h000003f8;

  wait(dcif.cif1.dhit);

  dcif1.dmemWEN = 0;
  @(posedge CLK);

  // ********************************************************************************************************
  // Testcase 5: C0 I -> S while C1 in M
  // ********************************************************************************************************
  test_num = test_num + 1;
  test_name = "C0 I -> M while C1 in M";

  // C0 already in I, since in prev testcase c1 Invalidate c0
  // C1 is in M already from previous testcase
  dcif0.dmemREN = 1;
  dcif0.daddr = 32'h000003f8; // should read 5555555 from c1

  wait(dcif.cif0.dhit);

  dcif0.dmemREN = 0;
  @(posedge CLK);

  end
endprogram 