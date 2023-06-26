/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(input logic CLK, output logic nRST, register_file_if.tb testif);
  initial begin
    //Test Case: Async Reset
    $display("Start Test Case Async Reset");
    nRST = 0;
    @(posedge CLK)
    @(negedge CLK)
    nRST = 1;
    testif.WEN = 0;
    for (int i = 0; i < 32; i++) begin
      testif.rsel1 = i;
      testif.rsel2 = i;
      @(negedge CLK);
      if (testif.rdat1 == '0 && testif.rdat2 == '0) begin
        $display("Correct reset value for %d register", i);
      end 
      else begin
        $error("Incorrect reset value for %d register", i);
      end
    end

    // Test Case: Write
    $display("Start Test Case Write");
    nRST = 0;
    @(posedge CLK)
    @(negedge CLK)
    nRST = 1;
    testif.WEN = 1;
    for (int i = 0; i < 32; i++) begin
      testif.wsel = i;
      testif.wdat = i + 1;
      testif.rsel1 = i;
      testif.rsel2 = i;
      @(negedge CLK);
      if (testif.rdat1 == i + 1 && testif.rdat2 == i + 1) begin
        $display("Correct write/read value for %d register", i);
      end 
      else begin
        if (testif.wsel == 0 && testif.rdat1 == 0 && testif.rdat2 == 0) begin
          $display("Correct write/read value for %d register", i);
        end 
        else begin
          $display("Incorrect write/read value for %d register", i);
        end
      end
    end

    
  end
endprogram
