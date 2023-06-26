// mapped needs this
`include "cpu_ram_if.vh"
`include "caches_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;
  parameter PERIOD = 10;
  parameter FF_SETUP_TIME = 2;
  parameter CHECK_DELAY = PERIOD - FF_SETUP_TIME;

  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  caches_if cif0();
  caches_if cif1();
  cpu_ram_if crif();
  cache_control_if #(.CPUS(2)) ccif(cif0, cif1);

  // test program
  test PROG (CLK, nRST, ccif);
  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
`else
  memory_control DUT(
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

program test(input logic CLK, output logic nRST, cache_control_if ccif);
  import cpu_types_pkg::*;
  initial begin
    // declare testbench signals
    integer test_num;
    string test_name;
    integer i;

    nRST = 0;
    test_num = 0;
    test_name = "Test bench initialization";
    // wait some time before starting first test case
    #(5);
    
    // // instantiate ram side signal  
    // ccif.ramload = '0;
    // ccif.ramstate = FREE;

    // instantiate cache0 signals
    ccif.cif0.iREN = 0;
    ccif.cif0.dREN = 0;
    ccif.cif0.dWEN = 0;
    ccif.cif0.dstore = 32'h0;
    ccif.cif0.iaddr = '0;
    ccif.cif0.daddr = '0;
    ccif.cif0.ccwrite = '0;
    ccif.cif0.cctrans = '0;

    // instantiate cache1 signals
    ccif.cif1.iREN = 0;
    ccif.cif1.dREN = 0;
    ccif.cif1.dWEN = 0;
    ccif.cif1.dstore = 32'h0;
    ccif.cif1.iaddr = '0;
    ccif.cif1.daddr = '0;
    ccif.cif1.ccwrite = '0;
    ccif.cif1.cctrans = '0;


    // ********************************************************************************************************
    // Testcase 1: Memeory write back
    // ********************************************************************************************************
    test_num = test_num + 1;
    test_name = "memory write back";

    nRST = 1;
    
    ccif.cif0.dWEN = 1;
    ccif.cif0.dstore = 32'h0123abcd;
    ccif.cif0.daddr = 32'h00008000;
    @(posedge CLK);
    @(posedge CLK);
    @(posedge CLK);
    @(posedge CLK);
    ccif.cif0.dWEN = 0;
    @(posedge CLK);
    

    // ********************************************************************************************************
    // Testcase 2: Load from memory, no other cache is transitioning
    // ********************************************************************************************************
    test_num = test_num + 1;
    test_name = "Load from memory";
    
    // IDLE
    ccif.cif0.dREN = 1;
    ccif.cif0.cctrans = 1;
    @(posedge CLK);
    // ARBTR
    ccif.cif0.dREN = 1;
    @(posedge CLK);
    // SNOP
    ccif.cif1.cctrans = 0;
    // put in whatever addr in meminit and multiply that by 4 to get the data in ramload
    ccif.cif0.daddr = 32'h400;
    @(posedge CLK);
    // LMEM0
    @(posedge CLK);
    @(posedge CLK);
    // LMEM1
    @(posedge CLK);
    // IDLE
    ccif.cif0.dstore = '0;
    ccif.cif0.cctrans = 0;
    ccif.cif0.dREN = 0;
    @(posedge CLK);

    // ********************************************************************************************************
    // Testcase 3: Load from other cache
    // ********************************************************************************************************
    test_num = test_num + 1;
    test_name = "Load form other cache";
    
    // IDLE
    ccif.cif1.dREN = 1;
    ccif.cif1.cctrans = 1;
    @(posedge CLK);
    // ARBTR
    ccif.cif1.dREN = 1;
    @(posedge CLK);
    // SNOP
    ccif.cif0.cctrans = 1;
    ccif.cif1.daddr = 32'h00010000;
    @(posedge CLK);
    // LDC0
    ccif.cif0.dstore = 32'h11111111;
    @(posedge CLK);
    @(posedge CLK);
    // LDC1
    ccif.cif0.dstore = 32'h22222222;
    @(posedge CLK);
    // IDLE
    ccif.cif0.cctrans = 0;
    ccif.cif1.cctrans = 0;
    ccif.cif1.dREN = 0;
    ccif.cif1.daddr = '0;
    @(posedge CLK);

    // ********************************************************************************************************
    // Testcase 4: Read icache
    // ********************************************************************************************************
    test_num = test_num + 1;
    test_name = "Read icache";

    ccif.cif0.iREN = 1;
    ccif.cif1.iREN = 1;
    ccif.cif0.iaddr = 32'h0;
    ccif.cif1.iaddr = 32'h0;
    for (i = 0; i< 5; i++) begin
      // @(posedge CLK);
      ccif.cif0.iaddr = ccif.cif0.iaddr + 4;
      ccif.cif1.iaddr = ccif.cif1.iaddr + 4;
    
      @(posedge CLK);
      @(posedge CLK);
      @(posedge CLK);
    end
    ccif.cif0.iREN = 0;
    ccif.cif1.iREN = 0;
    @(posedge CLK);


    // ********************************************************************************************************
    // Testcase 5: Write data into memory while reading instr
    // ********************************************************************************************************
    test_num = test_num + 1;
    test_name = "Write Data while ICONET";

    ccif.cif0.iREN = 1;
    ccif.cif1.iREN = 1;
    ccif.cif0.iaddr = 32'h0;
    ccif.cif1.iaddr = 32'h0;
      
    ccif.cif0.iaddr = 32'h00000400;
    ccif.cif1.iaddr = 32'h00000400;
    
    @(posedge CLK);
    @(posedge CLK);
    ccif.cif0.dWEN = 1;
    @(posedge CLK);
    @(posedge CLK);
    @(posedge CLK);
    
    cif0.iREN = 0;
    cif1.iREN = 0;
    ccif.cif0.dWEN = 0;
    @(posedge CLK);


    // ********************************************************************************************************
    // Testcase 6: CCtrans while reading instr
    // ********************************************************************************************************
    test_num = test_num + 1;
    test_name = "CCtrans while ICONET";

    ccif.cif0.iREN = 1;
    ccif.cif1.iREN = 1;
    ccif.cif0.iaddr = 32'h0;
    ccif.cif1.iaddr = 32'h0;
      
    ccif.cif0.iaddr = 32'h00000400;
    ccif.cif1.iaddr = 32'h00000400;
    
    @(posedge CLK);
    // ICONET
    ccif.cif1.cctrans = 1;
    @(posedge CLK);
    ccif.cif1.dREN = 1;
    @(posedge CLK);
    // ARBITR
    @(posedge CLK);
    // SNOP
    cif0.iREN = 0;
    cif1.iREN = 0;
    @(posedge CLK);
    // LMEM0
    ccif.cif0.cctrans = 1;
    ccif.cif1.daddr = 32'h00010000;
    @(posedge CLK);
    ccif.cif0.dstore = 32'h11111111;
    @(posedge CLK);
    // LMEM1
    @(posedge CLK);
    // IDLE
    ccif.cif0.dstore = 32'h22222222;
    ccif.cif0.cctrans = 0;
    ccif.cif1.cctrans = 0;
    ccif.cif1.dREN = 0;
    ccif.cif1.daddr = '0;
    @(posedge CLK);
    @(posedge CLK);
    @(posedge CLK);
    
  
  end
endprogram


