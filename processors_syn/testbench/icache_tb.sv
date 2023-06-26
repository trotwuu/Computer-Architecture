// mapped needs this
`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module icache_tb;

  parameter PERIOD = 10;
  parameter FF_SETUP_TIME = 2;
  parameter CHECK_DELAY = PERIOD - FF_SETUP_TIME;

  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dcif();
  caches_if cif();
  
  // test program
  test PROG (CLK, nRST, dcif, cif);
  // DUT
`ifndef MAPPED
  icache DUT(CLK, nRST, dcif, cif);
`endif

endmodule

program test(input logic CLK, output logic nRST, datapath_cache_if dcif, caches_if cif);
  integer       tb_test_num;
  logic [3:0]   tb_index;
  integer  i;
  logic [25:0] tb_tag;

  initial begin
    import cpu_types_pkg::*;

    nRST = 0;
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);

    // ******
    // test 1, compulsory missis
    // ******
    tb_test_num = 1;
    dcif.imemREN = 1;
    tb_index = '0;

    for (i=0; i<16; i++) begin
        dcif.imemaddr = {26'b0, tb_index, 2'b0};
        
        // go in to load state
        @(posedge CLK);
        cif.iwait = 1;
        @(posedge CLK);
        @(posedge CLK);

        cif.iwait = 0;
        cif.iload = 32'h00001111;
        
        // go back to idle
        @(posedge CLK);
        tb_index = tb_index + 1;
    end


    // ******
    // test 2, hit test
    // ******
    @(posedge CLK);
    tb_test_num = 2;
    dcif.imemREN = 1;
    tb_index = '0;

    for (i=0; i<16; i++) begin
        dcif.imemaddr = {26'b0, tb_index, 2'b0};

        @(posedge CLK);
        tb_index = tb_index + 1;
    end

    // ******
    // test 3, override test
    // ******
    @(posedge CLK);
    tb_test_num = 3;
    dcif.imemREN = 1;
    tb_index = '0;
    tb_tag = '1;

    for (i=0; i<16; i++) begin
        dcif.imemaddr = {tb_tag, tb_index, 2'b0};

        @(posedge CLK);
        cif.iwait = 1;
        @(posedge CLK);
        @(posedge CLK);

        cif.iwait = 0;
        cif.iload = 32'h12345678;
        @(posedge CLK);
        tb_index = tb_index + 1;
    end
  $stop;
  end
endprogram