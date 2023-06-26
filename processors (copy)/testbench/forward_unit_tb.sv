// mapped needs this
`include "forward_unit_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module forward_unit_tb;

  import cpu_types_pkg::*;  
  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  forward_unit_if fuif ();
  // test program
  test PROG (CLK, fuif);
  // DUT
`ifndef MAPPED
  forward_unit_haha DUT(fuif);
`endif

endmodule

program test(input logic CLK, forward_unit_if.tb fuif);
  initial begin
    // logic [4:0] tb_idex_rs, tb_idex_rt, tb_exmem_wsel, tb_memwb_wsel;
    // logic tb_exmem_dmemren, tb_exmem_dmemwen, tb_exmem_regWr, tb_memwb_regWr;
    int test_case_num;
    test_case_num = 0;

    assign fuif.idex_rs = '0;
    assign fuif.idex_rt = '0;
    assign fuif.exmem_wsel = '0;
    assign fuif.memwb_wsel= '0;
    assign fuif.exmem_dmemren = '0;
    assign fuif.exmem_dmemwen = '0;
    assign fuif.exmem_regWr = '0;
    assign fuif.memwb_regWr = '0;

    // test 1 
    test_case_num += 1;
    assign fuif.memwb_regWr = 1;
    assign fuif.memwb_wsel = 5'b10101;
    assign fuif.idex_rs = 5'b10101;

    @(negedge CLK)
    if(fuif.fward_a == 2'b01) begin
      $display("Pass 1");
    end
    else begin
      $display("Fail 1");
    end
    @(negedge CLK)

    @(posedge CLK)
    @(negedge CLK)

    // reset values
    assign fuif.memwb_regWr = 0;
    assign fuif.memwb_wsel = 0;
    assign fuif.idex_rs = 5'b0;

    // wait for a while
    @(posedge CLK)
    @(negedge CLK)
    @(posedge CLK)
    @(negedge CLK)

    // test 2
    test_case_num += 1;
    assign fuif.exmem_regWr = 1;
    assign fuif.exmem_wsel = 5'b01010;
    assign fuif.idex_rt = 5'b01010;

    @(negedge CLK)
    if(fuif.fward_b == 2'b10) begin
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
