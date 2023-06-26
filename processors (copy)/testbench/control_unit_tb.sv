// mapped needs this
`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface 
  control_unit_if tbcuif();
  // test program
  test PROG (CLK, tbcuif);
  // DUT
  `ifndef MAPPED
  control_unit DUT(tbcuif);
  `endif

endmodule

program test(input logic CLK, control_unit_if.tb testif);
  initial begin
    import cpu_types_pkg::*;

    //R_type
    testif.instr = 32'b000000_10101_00101_01000_00000100000; // ADD TEST
    @(negedge CLK);
    $display("TEST CASE: ADD");
    if(testif.aluop != ALU_ADD)begin
      $display ("Error: aluop");
    end
    else if (testif.mem_read != 0)begin
      $display("Error: mem_read");
    end
    else if (testif.mem_to_reg != 0)begin
      $display ("Error: mem_to_reg");
    end
    else if (testif.mem_write != 0)begin
      $display ("Error: mem_write");
    end
    else if(testif.regWr != 1)begin
      $display("Error: regWr");
    end
    else if(testif.halt != 0)begin
      $display ("Error: halt");
    end
    else if(testif.extend != 0)begin
      $display ("Error: extend");
    end
    else if (testif.reg_dst != '0)begin
      $display ("Error: reg_dst");
    end
    else if (testif.pcSrc != 2'b00)begin
      $display("Error: pcSrc");
    end
    else if(testif.alu_src != 0)begin
      $display("Error: alu_src");
    end
    else begin
      $display ("ADD Test pass");
    end

    //J type 
    testif.instr = 32'b000010_10101_00101_01000_00000100000; // J TEST
    @(negedge CLK);
    $display("TEST CASE: J");
    if(testif.aluop != ALU_SLL)begin
      $display ("Error: aluop");
    end
    else if (testif.mem_read != 0)begin
      $display("Error: mem_read");
    end
    else if (testif.mem_to_reg != 0)begin
      $display ("Error: mem_to_reg");
    end
    else if (testif.mem_write != 0)begin
      $display ("Error: mem_write");
    end
    else if(testif.regWr != 0)begin
      $display("Error: regWr");
    end
    else if(testif.halt != 0)begin
      $display ("Error: halt");
    end
    else if(testif.extend != 0)begin
      $display ("Error: extend");
    end
    else if (testif.reg_dst != '0)begin
      $display ("Error: reg_dst");
    end
    else if (testif.pcSrc != 2'b10)begin
      $display("Error: pcSrc");
    end
    else if(testif.alu_src != 0)begin
      $display("Error: alu_src");
    end
    else begin
      $display ("J Test pass");
    end

    //J type 
    testif.instr = 32'b000011_10101_00101_01000_00000100000; // JAL TEST
    @(negedge CLK);
    $display("TEST CASE: JAL");
    if(testif.aluop != ALU_SLL)begin
      $display ("Error: aluop");
    end
    else if (testif.mem_read != 0)begin
      $display("Error: mem_read");
    end
    else if (testif.mem_to_reg != 2'b10)begin
      $display ("Error: mem_to_reg");
    end
    else if (testif.mem_write != 0)begin
      $display ("Error: mem_write");
    end
    else if(testif.regWr != 1)begin
      $display("Error: regWr");
    end
    else if(testif.halt != 0)begin
      $display ("Error: halt");
    end
    else if(testif.extend != 0)begin
      $display ("Error: extend");
    end
    else if (testif.reg_dst != 2'b11)begin
      $display ("Error: reg_dst");
    end
    else if (testif.pcSrc != 2'b10)begin
      $display("Error: pcSrc");
    end
    else if(testif.alu_src != 0)begin
      $display("Error: alu_src");
    end
    else begin
      $display ("JAL Test pass");
    end

  
    //I_type
    testif.instr = 32'b001001_10101_00101_01000_00000100000; // ADDI TEST
    @(negedge CLK);
    $display("TEST CASE: ADDI");
    if(testif.aluop != ALU_ADD)begin
      $display ("Error: aluop");
    end
    else if (testif.mem_read != 0)begin
      $display("Error: mem_read");
    end
    else if (testif.mem_to_reg != 0)begin
      $display ("Error: mem_to_reg");
    end
    else if (testif.mem_write != 0)begin
      $display ("Error: mem_write");
    end
    else if(testif.regWr != 1)begin
      $display("Error: regWr");
    end
    else if(testif.halt != 0)begin
      $display ("Error: halt");
    end
    else if(testif.extend != 1)begin
      $display ("Error: extend");
    end
    else if (testif.reg_dst != 2'b01)begin
      $display ("Error: reg_dst");
    end
    else if (testif.pcSrc != 2'b00)begin
      $display("Error: pcSrc");
    end
    else if(testif.alu_src != 1)begin
      $display("Error: alu_src");
    end
    else begin
      $display ("ADDI Test pass");
    end

    //I_type
    testif.instr = 32'b000100_10101_00101_01000_00000100000; // BEQ TEST
    testif.zero = 1;
    @(negedge CLK);
    $display("TEST CASE: BEQ");
    if(testif.aluop != ALU_SUB)begin
      $display ("Error: aluop");
    end
    else if (testif.mem_read != 0)begin
      $display("Error: mem_read");
    end
    else if (testif.mem_to_reg != 0)begin
      $display ("Error: mem_to_reg");
    end
    else if (testif.mem_write != 0)begin
      $display ("Error: mem_write");
    end
    else if(testif.regWr != 0)begin
      $display("Error: regWr");
    end
    else if(testif.halt != 0)begin
      $display ("Error: halt");
    end
    else if(testif.extend != 0)begin
      $display ("Error: extend");
    end
    else if (testif.reg_dst != 2'b00)begin
      $display ("Error: reg_dst");
    end
    else if (testif.pcSrc != 2'b11)begin
      $display("Error: pcSrc");
    end
    else if(testif.alu_src != 0)begin
      $display("Error: alu_src");
    end
    else begin
      $display ("BEQ Taken Test pass");
    end

    //I_type
    testif.instr = 32'b000100_10101_00101_01000_00000100000; // BEQ TEST
    testif.zero = 0;
    @(negedge CLK);
    $display("TEST CASE: BEQ");
    if(testif.aluop != ALU_SUB)begin
      $display ("Error: aluop");
    end
    else if (testif.mem_read != 0)begin
      $display("Error: mem_read");
    end
    else if (testif.mem_to_reg != 0)begin
      $display ("Error: mem_to_reg");
    end
    else if (testif.mem_write != 0)begin
      $display ("Error: mem_write");
    end
    else if(testif.regWr != 0)begin
      $display("Error: regWr");
    end
    else if(testif.halt != 0)begin
      $display ("Error: halt");
    end
    else if(testif.extend != 0)begin
      $display ("Error: extend");
    end
    else if (testif.reg_dst != 2'b00)begin
      $display ("Error: reg_dst");
    end
    else if (testif.pcSrc != 2'b00)begin
      $display("Error: pcSrc");
    end
    else if(testif.alu_src != 0)begin
      $display("Error: alu_src");
    end
    else begin
      $display ("BEQ Not Taken Test pass");
    end

    //I_type
    testif.instr = 32'b001111_10101_00101_01000_00000100000; // LUI TEST
    testif.zero = 0;
    @(negedge CLK);
    $display("TEST CASE: LUI");
    if(testif.aluop != ALU_SLL)begin
      $display ("Error: aluop");
    end
    else if (testif.mem_read != 0)begin
      $display("Error: mem_read");
    end
    else if (testif.mem_to_reg != 2'b11)begin
      $display ("Error: mem_to_reg");
    end
    else if (testif.mem_write != 0)begin
      $display ("Error: mem_write");
    end
    else if(testif.regWr != 1)begin
      $display("Error: regWr");
    end
    else if(testif.halt != 0)begin
      $display ("Error: halt");
    end
    else if(testif.extend != 0)begin
      $display ("Error: extend");
    end
    else if (testif.reg_dst != 2'b01)begin
      $display ("Error: reg_dst");
    end
    else if (testif.pcSrc != 2'b00)begin
      $display("Error: pcSrc");
    end
    else if(testif.alu_src != 0)begin
      $display("Error: alu_src");
    end
    else begin
      $display ("LUI Test pass");
    end

     //I_type
    testif.instr = 32'b100011_10101_00101_01000_00000100000; // LW TEST
    testif.zero = 0;
    @(negedge CLK);
    $display("TEST CASE: LW");
    if(testif.aluop != ALU_ADD)begin
      $display ("Error: aluop");
    end
    else if (testif.mem_read != 1)begin
      $display("Error: mem_read");
    end
    else if (testif.mem_to_reg != 2'b01)begin
      $display ("Error: mem_to_reg");
    end
    else if (testif.mem_write != 0)begin
      $display ("Error: mem_write");
    end
    else if(testif.regWr != 1)begin
      $display("Error: regWr");
    end
    else if(testif.halt != 0)begin
      $display ("Error: halt");
    end
    else if(testif.extend != 1)begin
      $display ("Error: extend");
    end
    else if (testif.reg_dst != 2'b01)begin
      $display ("Error: reg_dst");
    end
    else if (testif.pcSrc != 2'b00)begin
      $display("Error: pcSrc");
    end
    else if(testif.alu_src != 1)begin
      $display("Error: alu_src");
    end
    else begin
      $display ("LW Test pass");
    end

    //I_type
    testif.instr = 32'b101011_10101_00101_01000_00000100000; // SW TEST
    testif.zero = 0;
    @(negedge CLK);
    $display("TEST CASE: SW");
    if(testif.aluop != ALU_ADD)begin
      $display ("Error: aluop");
    end
    else if (testif.mem_read != 0)begin
      $display("Error: mem_read");
    end
    else if (testif.mem_to_reg != 2'b00)begin
      $display ("Error: mem_to_reg");
    end
    else if (testif.mem_write != 1)begin
      $display ("Error: mem_write");
    end
    else if(testif.regWr != 0)begin
      $display("Error: regWr");
    end
    else if(testif.halt != 0)begin
      $display ("Error: halt");
    end
    else if(testif.extend != 1)begin
      $display ("Error: extend");
    end
    else if (testif.reg_dst != 2'b00)begin
      $display ("Error: reg_dst");
    end
    else if (testif.pcSrc != 2'b00)begin
      $display("Error: pcSrc");
    end
    else if(testif.alu_src != 1)begin
      $display("Error: alu_src");
    end
    else begin
      $display ("SW Test pass");
    end

    //HALT
    testif.instr = 32'b111111_10101_00101_01000_00000100000; // HALT TEST
    testif.zero = 0;
    @(negedge CLK);
    $display("TEST CASE: SW");
    if(testif.halt != 1)begin
      $display ("Error: aluop");
    end
    else begin
      $display ("HALT Test pass");
    end

  end

endprogram
