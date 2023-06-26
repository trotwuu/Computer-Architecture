// mapped needs this
`include "hazard_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  import cpu_types_pkg::*;  
  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  hazard_unit_if huif ();
  // test program
  test PROG (CLK, huif);
  // DUT
`ifndef MAPPED
  hazard_unit DUT(huif);
`endif

endmodule

program test(input logic CLK, hazard_unit_if.tb huif);
  initial begin
    logic [4:0] tb_ifid_rs, tb_ifid_rt;

    assign      tb_ifid_rs = huif.ifid_instr[25:21];
    assign      tb_ifid_rt = huif.ifid_instr[20:16];

    assign huif.ifid_instr  = {6'b100011, 5'b00101, 21'b0};
    assign huif.idex_rt     = 5'b00101;
    assign huif.dcif_dhit   = 0;
    assign huif.idex_regWr  = 1;
    assign huif.pcsrc = 2'b0;
    

    @(negedge CLK)
    if(huif.ifid_freeze && huif.idex_flush && huif.pc_freeze) begin
      $display("Pass 1");
    end
    else begin
      $display("Fail 1");
    end
    @(negedge CLK)

    @(posedge CLK)
    @(negedge CLK)

    // reset values
    assign huif.ifid_instr  = 32'b0;
    assign huif.idex_rt     = 5'b0;
    assign huif.idex_regWr  = 1;

    // wait for a while
    @(posedge CLK)
    @(negedge CLK)
    @(posedge CLK)
    @(negedge CLK)

    assign huif.pcsrc = 2'b10;

    @(negedge CLK)
    if(huif.ifid_flush && huif.idex_flush && huif.exmem_flush) begin
      $display("Pass 2");
    end
    else begin
      $display("Fail 2");
    end

    // wait for a while
    @(posedge CLK)
    @(negedge CLK)
    @(posedge CLK)
    @(negedge CLK)
    $stop;

  end
endprogram
