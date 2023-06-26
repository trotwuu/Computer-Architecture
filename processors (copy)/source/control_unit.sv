`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"

module control_unit (control_unit_if.control ctrlif);
    import cpu_types_pkg::*;
    logic [6:0]  opcode_ctrl;
    logic [5:0] funct_ctrl;
    assign opcode_ctrl = ctrlif.instr[31:26];
    assign funct_ctrl = ctrlif.instr[5:0];
    always_comb begin
        ctrlif.aluop = ALU_SLL;
        ctrlif.mem_read = '0;
        ctrlif.mem_to_reg = '0;
        ctrlif.mem_write = '0;
        ctrlif.regWr = '0;
        ctrlif.halt = '0;
        ctrlif.extend = 0;
        ctrlif.reg_dst = '0;
        ctrlif.alu_src = '0;
		ctrlif.branch = '0;
		ctrlif.jump = '0;
		ctrlif.bne = 0;
        ctrlif.datomic = 0;
        
        //R_type
        if (opcode_ctrl == RTYPE)begin
            ctrlif.regWr = 1;
            case (funct_ctrl) 
                ADD: begin
                    ctrlif.aluop = ALU_ADD;
                end
                ADDU: begin
                    ctrlif.aluop = ALU_ADD;
                end
                AND: begin
                    ctrlif.aluop = ALU_AND;
                end
                JR: begin
                    ctrlif.jump = 2'b01; 
                    ctrlif.regWr = 0;
                end
                NOR: begin
                    ctrlif.aluop = ALU_NOR;
                end
                OR: begin
                    ctrlif.aluop = ALU_OR;
                end
                SLT: begin
                    ctrlif.aluop = ALU_SLT;
                end
                SLTU: begin
                    ctrlif.aluop = ALU_SLTU;
                end
                SLLV: begin
                    ctrlif.aluop = ALU_SLL;
                end
                SRLV: begin
                    ctrlif.aluop = ALU_SRL;
                end
                SUBU: begin
                    ctrlif.aluop = ALU_SUB;
                end
                SUB: begin
                    ctrlif.aluop = ALU_SUB;
                end
                XOR: begin
                    ctrlif.aluop = ALU_XOR;
                end
            endcase
        end


        //J type for J and JAL
        else if(opcode_ctrl == J || opcode_ctrl == JAL) begin
            if(opcode_ctrl == J) begin
                ctrlif.extend = 1;
                ctrlif.jump = 2'b10;
            end
            else if(opcode_ctrl == JAL) begin
                ctrlif.jump = 2'b10;
                ctrlif.regWr = 1;
                ctrlif.reg_dst = 2'b11;
                ctrlif.mem_to_reg = 2'b10;
                ctrlif.extend = 1;
            end
        end

        //I type
        else begin
            case (opcode_ctrl) 
                ADDIU: begin
                    ctrlif.alu_src = 1;
                    ctrlif.extend = 1;
                    ctrlif.aluop = ALU_ADD;
                    ctrlif.regWr = 1;
                    ctrlif.reg_dst = 2'b01;
                end
                ADDI: begin
                    ctrlif.alu_src = 1;
                    ctrlif.extend = 1;
                    ctrlif.aluop = ALU_ADD;
                    ctrlif.regWr = 1;
                    ctrlif.reg_dst = 2'b01;
                end
                
                ANDI: begin
                    ctrlif.alu_src = 1;
                    ctrlif.extend = 0;
                    ctrlif.aluop = ALU_AND;
                    ctrlif.regWr = 1;
                    ctrlif.reg_dst = 2'b01;
                end
                BEQ: begin
					ctrlif.bne = 0;
					ctrlif.branch = 1;
                    ctrlif.aluop = ALU_SUB;
                    ctrlif.extend = 1;
                end
                BNE: begin
					ctrlif.bne = 1;
					ctrlif.branch = 1;
                    ctrlif.aluop = ALU_SUB;
                    ctrlif.extend = 1;
                end
                LUI: begin
                    ctrlif.mem_to_reg = 2'b11;
                    ctrlif.regWr = 1;
                    ctrlif.reg_dst = 2'b01;
                end
                LW: begin
                    ctrlif.alu_src = 1;
                    ctrlif.mem_to_reg = 2'b01;
                    ctrlif.extend = 1;
                    ctrlif.regWr = 1;
                    ctrlif.mem_read = 1;
                    ctrlif.aluop = ALU_ADD;
                    ctrlif.reg_dst = 2'b01;
                end
                ORI: begin
                    ctrlif.alu_src = 1;
                    ctrlif.extend = 0;
                    ctrlif.aluop = ALU_OR;
                    ctrlif.regWr = 1;
                    ctrlif.reg_dst = 2'b01;
                end
                SLTI: begin
                    ctrlif.alu_src = 1;
                    ctrlif.extend = 1;
                    ctrlif.aluop = ALU_SLT;
                    ctrlif.regWr = 1;
                    ctrlif.reg_dst = 2'b01;
                end
                SLTIU: begin
                    ctrlif.alu_src = 1;
                    ctrlif.extend = 1;
                    ctrlif.aluop = ALU_SLTU;
                    ctrlif.regWr = 1;
                    ctrlif.reg_dst = 2'b01;
                end
                SW: begin
                    //MEM[$s + offset] = $t; advance_pc (4);
                    ctrlif.alu_src = 1;
                    // rs add offset
                    ctrlif.mem_write = 1;
                    ctrlif.aluop = ALU_ADD;
                    ctrlif.extend = 1;
                    //dmemstore = rdat2(rt)
                end
                XORI: begin
                    ctrlif.alu_src = 1;
                    ctrlif.extend = 0;
                    ctrlif.aluop = ALU_XOR;
                    ctrlif.regWr = 1;
                    ctrlif.reg_dst = 2'b01;
                end
                LL: begin
                    ctrlif.datomic = 1;
                    ctrlif.alu_src = 1;
                    ctrlif.mem_to_reg = 2'b01;
                    ctrlif.extend = 1;
                    ctrlif.regWr = 1;
                    ctrlif.mem_read = 1;
                    ctrlif.aluop = ALU_ADD;
                    ctrlif.reg_dst = 2'b01;

                end
                SC: begin
                    ctrlif.datomic = 1;
                    //MEM[$s + offset] = $t; advance_pc (4);
                    ctrlif.alu_src = 1;
                    // rs add offset
                    ctrlif.mem_write = 1;
                    ctrlif.aluop = ALU_ADD;
                    ctrlif.extend = 1;
                    //dmemstore = rdat2(rt)
                    ctrlif.mem_to_reg = 2'b01;
                    ctrlif.regWr = 1;
                    ctrlif.reg_dst = 2'b01;
                end
                HALT: begin
                    ctrlif.halt = 1;
                end
            endcase
        end
    end

    
    
endmodule