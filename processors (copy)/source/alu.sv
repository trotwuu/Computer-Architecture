`include "cpu_types_pkg.vh"
`include "alu_if.vh"

module alu (alu_if.alu aluif);
    import cpu_types_pkg::*;
    always_comb 
    begin
        aluif.outport = '0;
        aluif.overflow = '0;
        
        casez (aluif.aluop)
            ALU_SLL:
            begin
                aluif.outport = aluif.port_b << aluif.port_a[4:0];
            end
            ALU_SRL: 
            begin
                aluif.outport = aluif.port_b >> aluif.port_a[4:0];
            end
            ALU_ADD: 
            begin
                aluif.outport = $signed(aluif.port_a) + $signed(aluif.port_b);
                aluif.overflow = aluif.port_a[31] ~^ aluif.port_b[31] && aluif.outport[31] ^ aluif.port_a[31];
            end
            ALU_SUB:begin
                aluif.outport = $signed(aluif.port_a) - $signed(aluif.port_b);
                aluif.overflow = aluif.port_a[31] ~^ aluif.port_b[31] && aluif.outport[31] ^ aluif.port_a[31];
            end
            ALU_AND: begin
               aluif.outport = aluif.port_a & aluif.port_b;
            end
            ALU_OR: begin
                aluif.outport = aluif.port_a | aluif.port_b;
            end
            ALU_XOR: begin
                aluif.outport = aluif.port_a ^ aluif.port_b;
            end
            ALU_NOR: begin
                aluif.outport = ~(aluif.port_a | aluif.port_b);
            end
            ALU_SLT: begin
                aluif.outport = ($signed(aluif.port_a) < $signed(aluif.port_b)? 32'b1 : 32'b0);
            end
            ALU_SLTU: begin
                aluif.outport = aluif.port_a < aluif.port_b ? 32'b1 : 32'b0;
            end
            

        endcase

        if (aluif.outport == '0) 
        begin
            aluif.zero = 1;
        end 
        else begin
            aluif.zero = 0;
        end

        if (aluif.outport[31] == 1) 
        begin
            aluif.negative = 1;
        end 
        else begin
            aluif.negative = 0;
        end
    end

endmodule