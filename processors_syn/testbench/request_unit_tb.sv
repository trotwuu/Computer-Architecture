// mapped needs this
`include "request_unit_if.vh"
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  request_unit_if rqif ();
  // test program
  test PROG (CLK, nRST, rqif);
  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST,rqif);
`else
  request_unit DUT(
    .\rqif.ihit (rqif.ihit),
    .\rqif.dhit (rqif.dhit),
    .\rqif.mem_write (rqif.mem_write),
    .\rqif.mem_read (rqif.mem_read),
    .\rqif.dmemREN (rqif.dmemREN),
    .\rqif.dmemWEN (rqif.dmemWEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(input logic CLK, output logic nRST, request_unit_if.tb testif);
initial begin
    nRST = 0;
    @(posedge CLK);
    nRST = 1;
    $display("TEST: dhit high ");
    testif.mem_write = 0;
    testif.mem_read = 1;
    testif.dhit = 1;
    testif.ihit = 0;
    @(posedge CLK);
    if(testif.imemREN == 1 && testif.dmemWEN == 0 && testif.dmemREN == 0)begin
        $display("dhit high pass");
    end
    else begin
        $display("dhit fail");
    end

    $display("TEST: ihit high ");
    testif.mem_write = 1;
    testif.mem_read = 0;
    testif.dhit = 0;
    testif.ihit = 1;
    
    @(posedge CLK);
    if(testif.imemREN == 1 && testif.dmemWEN == 1 && testif.dmemREN == 0)begin
        $display("ihit high pass");
    end
    else begin
        $display("ihit high fail");
    end

    $display("TEST: ihit, dhit high ");
    testif.mem_write = 1;
    testif.mem_read = 1;
    testif.dhit = 1;
    testif.ihit = 1;
    
    @(posedge CLK);
    if(testif.imemREN == 1 && testif.dmemWEN == 0 && testif.dmemREN == 0)begin
        $display("ihit, dhit high pass");
    end
    else begin
        $display("ihit, dhit high pass");
    end
  end

    
endprogram
