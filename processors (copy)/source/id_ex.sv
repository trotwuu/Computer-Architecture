`include "id_ex_if.vh"
`include "control_unit_if.vh"
module id_ex (input logic CLK, input logic nRST, id_ex_if.idex idexif);
import cpu_types_pkg::*;
    always_ff @( posedge CLK, negedge nRST ) begin : ID_EX_PIPELINE
        if(!nRST)begin
            idexif.regWr_o          <= '0;
            idexif.branch_o         <= '0;
            idexif.mem_write_o      <= '0;
            idexif.mem_read_o       <= '0;
            idexif.aluop_o          <= aluop_t'('0);
            idexif.reg_dst_o        <= '0;
            idexif.alu_src_o        <= '0;
            idexif.bne_o            <= '0;
            idexif.datomic_o        <= '0;
            idexif.halt_o           <= '0;
            idexif.jump_o           <= '0;
            idexif.mem_to_reg_o     <= '0;
            idexif.rdat1_o          <= '0;
            idexif.rdat2_o          <= '0;
            idexif.signout_o        <= '0;
            idexif.up_imm_o         <= '0;
            idexif.pc_p4_o          <= '0;
            idexif.imem_load_o      <= '0; //pass instr
            idexif.jump_addr_o      <= '0;
            idexif.rt_o             <= '0;
            idexif.rd_o             <= '0;
            idexif.pc_o             <= '0;
            idexif.nxt_pc_o         <= '0;
            idexif.instr_o          <= '0;
            idexif.funct_o          <= funct_t'('0);
            idexif.opcode_o         <= opcode_t'('0);
            idexif.rs_o             <= '0;
        end
        else begin
            if ((idexif.flush))begin
                idexif.regWr_o          <= '0;
                idexif.branch_o         <= '0;
                idexif.mem_write_o      <= '0;
                idexif.mem_read_o       <= '0;
                idexif.aluop_o          <= aluop_t'('0);
                idexif.reg_dst_o        <= '0;
                idexif.alu_src_o        <= '0;
                idexif.bne_o            <= '0;
                idexif.datomic_o        <= '0;
                idexif.halt_o           <= '0;
                idexif.jump_o           <= '0;
                idexif.mem_to_reg_o     <= '0;
                idexif.rdat1_o          <= '0;
                idexif.rdat2_o          <= '0;
                idexif.signout_o        <= '0;
                idexif.up_imm_o         <= '0;
                idexif.pc_p4_o          <= '0;
                idexif.imem_load_o      <= '0; //pass instr
                idexif.jump_addr_o      <= '0;
                idexif.rt_o             <= '0;
                idexif.rd_o             <= '0;
                idexif.pc_o             <= '0;
                idexif.nxt_pc_o         <= '0;
                idexif.instr_o          <= '0;
                idexif.funct_o          <= funct_t'('0);
                idexif.opcode_o         <= opcode_t'('0);
                idexif.rs_o             <= '0;
            end
            
            else if (idexif.freeze) begin
                idexif.regWr_o          <= idexif.regWr_o;
                idexif.branch_o         <= idexif.branch_o;
                idexif.mem_write_o      <= idexif.mem_write_o;
                idexif.mem_read_o       <= idexif.mem_read_o;
                idexif.aluop_o          <= idexif.aluop_o;
                idexif.reg_dst_o        <= idexif.reg_dst_o;
                idexif.alu_src_o        <= idexif.alu_src_o;
                idexif.bne_o            <= idexif.bne_o;
                idexif.datomic_o        <= idexif.datomic_o;
                idexif.halt_o           <= idexif.halt_o; 
                idexif.jump_o           <= idexif.jump_o;
                idexif.mem_to_reg_o     <= idexif.mem_to_reg_o;
                idexif.rdat1_o          <= idexif.rdat1_o;
                idexif.rdat2_o          <= idexif.rdat2_o;
                idexif.signout_o        <= idexif.signout_o;
                idexif.up_imm_o         <= idexif.up_imm_o;
                idexif.pc_p4_o          <= idexif.pc_p4_o;
                idexif.imem_load_o      <= idexif.imem_load_o; //pass instr
                idexif.jump_addr_o      <= idexif.jump_addr_o;
                idexif.rt_o             <= idexif.rt_o;
                idexif.rd_o             <= idexif.rd_o;
                idexif.pc_o             <= idexif.pc_o;
                idexif.nxt_pc_o         <= idexif.nxt_pc_o;
                idexif.instr_o          <= idexif.instr_o;
                idexif.funct_o          <= idexif.funct_o;
                idexif.opcode_o         <= idexif.opcode_o;
                idexif.rs_o             <= idexif.rs_o;
            end
            else if(idexif.en)begin
                idexif.regWr_o          <= idexif.regWr_i;
                idexif.branch_o         <= idexif.branch_i;
                idexif.mem_write_o      <= idexif.mem_write_i;
                idexif.mem_read_o       <= idexif.mem_read_i;
                idexif.aluop_o          <= idexif.aluop_i;
                idexif.reg_dst_o        <= idexif.reg_dst_i;
                idexif.alu_src_o        <= idexif.alu_src_i;
                idexif.bne_o            <= idexif.bne_i;
                idexif.datomic_o        <= idexif.datomic_i;
                idexif.halt_o           <= idexif.halt_i;
                idexif.jump_o           <= idexif.jump_i;
                idexif.mem_to_reg_o     <= idexif.mem_to_reg_i;
                idexif.rdat1_o          <= idexif.rdat1_i;
                idexif.rdat2_o          <= idexif.rdat2_i;
                idexif.signout_o        <= idexif.signout_i;
                idexif.up_imm_o         <= idexif.up_imm_i;
                idexif.pc_p4_o          <= idexif.pc_p4_i;
                idexif.imem_load_o      <= idexif.imem_load_i; //pass instr
                idexif.jump_addr_o      <= idexif.jump_addr_i;
                idexif.rt_o             <= idexif.rt_i;
                idexif.rd_o             <= idexif.rd_i;
                idexif.pc_o             <= idexif.pc_i;
                idexif.nxt_pc_o         <= idexif.nxt_pc_i;
                idexif.instr_o          <= idexif.instr_i;
                idexif.funct_o          <= idexif.funct_i;
                idexif.opcode_o         <= idexif.opcode_i; 
                idexif.rs_o             <= idexif.rs_i; 
            end
        end
    end
    
endmodule