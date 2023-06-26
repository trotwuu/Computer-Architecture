`include "register_file_if.vh"
`include "cpu_types_pkg.vh"

module register_file (
    input logic CLK, nRST,
    register_file_if.rf rfif
);
    import cpu_types_pkg::*;
    word_t [31:0] registers;
    word_t [31:0] nxt_registers;

    // READ LOGIC
    assign rfif.rdat1 = registers[rfif.rsel1];
    assign rfif.rdat2 = registers[rfif.rsel2];
    // WRITE LOGIC

    always_comb begin : blockName
        nxt_registers = registers;
        if (rfif.WEN == 1'b1) begin
            if (rfif.wsel != '0) begin
                nxt_registers[rfif.wsel] = rfif.wdat;
            end
            else begin
                nxt_registers[rfif.wsel] = '0;
            end
        end 
    end

    always_ff @( negedge CLK, negedge nRST ) begin
        if (!nRST)
        begin
            registers <= '0;
        end
        else begin
            registers <= nxt_registers;
        end
    end
    
endmodule