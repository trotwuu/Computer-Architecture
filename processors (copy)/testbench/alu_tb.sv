/*
  alu test bench
*/

// mapped needs this
`include "alu_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if aluif ();
  // test program
  test PROG (CLK, aluif);
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.aluop (aluif.aluop),
    .\aluif.port_a (aluif.port_a),
    .\aluif.port_b (aluif.port_b),
    .\aluif.outport (aluif.outport),
    .\aluif.zero (aluif.zero),
    .\aluif.negative (aluif.negative),
    .\aluif.overflow (aluif.overflow)
  );
`endif

endmodule

program test(input logic CLK, alu_if.tb testif);
  initial begin
    import cpu_types_pkg::*;
    word_t value_a;
    word_t value_b;
    word_t expected_output;
    // Test SLL
    for (int i = 0; i < 10; i++) begin
        value_a = $urandom();
        value_b = $urandom();
        expected_output = value_b << value_a[4:0];
        testif.aluop = ALU_SLL;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test SLL pass");
        end else begin
            $display("Test SLL fail");
        end
    end

    // Test SRL
    for (int i = 0; i < 10; i++) begin
        value_a = $urandom();
        value_b = $urandom();
        expected_output = value_b >> value_a[4:0];
        testif.aluop = ALU_SRL;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test SRL pass");
        end else begin
            $display("Test SRL fail");
        end
    end

    // Test ADD
    for (int i = 0; i < 10; i++) begin
        value_a = $random();
        value_b = $random();
        expected_output = value_b + value_a;
        testif.aluop = ALU_ADD;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test ADD pass");
        end else begin
            $display("Test ADD fail");
        end
        if (testif.overflow == 1) begin
            $display("Test ADD overflow tested");
        end 
        if (expected_output != 0 && testif.zero == 1) begin
            $display("ERROR! Test ADD zero fail");
        end 
    end

    // Test ADD ZERO
    for (int i = 0; i < 10; i++) begin
        value_a = $random();
        value_b = $random();
        expected_output = value_b + value_a;
        testif.aluop = ALU_ADD;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test ADD Zero pass");
        end else begin
            $display("Test ADD fail");
        end
        if (testif.overflow == 1) begin
            $display("Test ADD overflow tested");
        end 
        if (expected_output < 0 && testif.negative == 1) begin
            $display("Test ADD overflow tested");
        end 
        if (expected_output != 0 && testif.zero == 1) begin
            $display("ERROR! Test ADD zero fail");
        end 
    end

    // Test SUB
    for (int i = 0; i < 10; i++) begin
        value_a = $random();
        value_b = $random();
        expected_output = value_a - value_b;
        testif.aluop = ALU_SUB;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test SUB pass");
        end else begin
            $display("Test SUB fail");
        end
        if (testif.overflow == 1) begin
            $display("Test SUB overflow tested");
        end 
        if (expected_output != 0 && testif.zero == 1) begin
            $display("ERROR! Test ADD zero fail");
        end 
    end

    // Test AND
    for (int i = 0; i < 10; i++) begin
        value_a = $random();
        value_b = $random();
        expected_output = value_a & value_b;
        testif.aluop = ALU_AND;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test AND pass");
        end else begin
            $display("Test AND fail");
        end
    end

    // Test OR
    for (int i = 0; i < 10; i++) begin
        value_a = $random();
        value_b = $random();
        expected_output = value_a | value_b;
        testif.aluop = ALU_OR;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test OR pass");
        end else begin
            $display("Test OR fail");
        end
    end

    // Test XOR
    for (int i = 0; i < 10; i++) begin
        value_a = $random();
        value_b = $random();
        expected_output = value_a ^ value_b;
        testif.aluop = ALU_XOR;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test XOR pass");
        end else begin
            $display("Test XOR fail");
        end
    end

    // Test NOR
    for (int i = 0; i < 10; i++) begin
        value_a = $random();
        value_b = $random();
        expected_output = ~ (value_a | value_b);
        testif.aluop = ALU_NOR;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test NOR pass");
        end else begin
            $display("Test NOR fail");
        end
    end

    // Test SLT
    for (int i = 0; i < 10; i++) begin
        value_a = $random();
        value_b = $random();
        expected_output = $signed(value_a) < $signed(value_b) ? 1 : 0;
        testif.aluop = ALU_SLT;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test SLT pass");
        end else begin
            $display("Test SLT fail");
        end
    end

    // Test SLTU
    for (int i = 0; i < 10; i++) begin
        value_a = $urandom();
        value_b = $urandom();
        expected_output = value_a < value_b ? 1 : 0;
        testif.aluop = ALU_SLTU;
        testif.port_a = value_a;
        testif.port_b = value_b;
        @(negedge CLK)
        if (testif.outport == expected_output) begin
            $display("Test SLTU pass");
        end else begin
            $display("Test SLTU fail");
        end
    end
  end
endprogram