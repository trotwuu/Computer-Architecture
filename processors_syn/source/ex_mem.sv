`include "ex_mem_if.vh"
import cpu_types_pkg::*;
module ex_mem (input logic CLK, input logic nRST, ex_mem_if.exmem exmemif);
    always_ff @( posedge CLK, negedge nRST ) begin : EX_MEM_BLOCK
        if(!nRST)begin
            exmemif.regWr_o         <= '0;
            exmemif.branch_o        <= '0;
            exmemif.mem_write_o     <= '0;
            exmemif.mem_read_o      <= '0;
            exmemif.bne_o           <= '0;
            exmemif.datomic_o       <= '0;
            exmemif.halt_o          <= '0;
            exmemif.jump_o          <= '0;
            exmemif.mem_to_reg_o    <= '0;
            exmemif.branch_addr_o   <= '0;
            exmemif.alu_out_o       <= '0; 
            exmemif.zero_o          <= '0;
            exmemif.wsel_o          <= '0;
            exmemif.rdat1_o         <= '0;
            exmemif.rdat2_o         <= '0;
            exmemif.pc_p4_o         <= '0;
            exmemif.up_imm_o        <= '0;
            exmemif.imem_load_o     <= '0; //pass instr
            exmemif.jump_addr_o     <= '0;
            exmemif.pc_o            <= '0;
            exmemif.nxt_pc_o        <= '0;
            exmemif.instr_o         <= '0;
            exmemif.funct_o         <= funct_t'('0);
            exmemif.opcode_o        <= opcode_t'('0);
            exmemif.rt_o            <= '0;
            exmemif.rs_o            <= '0;
        end
        else begin
            if(exmemif.flush)begin
                exmemif.regWr_o         <= '0;
                exmemif.branch_o        <= '0;
                exmemif.mem_write_o     <= '0;
                exmemif.mem_read_o      <= '0;
                exmemif.bne_o           <= '0;
                exmemif.datomic_o       <= '0;
                exmemif.halt_o          <= '0;
                exmemif.jump_o          <= '0;
                exmemif.mem_to_reg_o    <= '0;
                exmemif.branch_addr_o   <= '0;
                exmemif.alu_out_o       <= '0; 
                exmemif.zero_o          <= '0;
                exmemif.wsel_o          <= '0;
                exmemif.rdat1_o         <= '0;
                exmemif.rdat2_o         <= '0;
                exmemif.pc_p4_o         <= '0;
                exmemif.up_imm_o        <= '0;
                exmemif.imem_load_o     <= '0; //pass instr
                exmemif.jump_addr_o     <= '0;
                exmemif.pc_o            <= '0;
                exmemif.nxt_pc_o        <= '0;
                exmemif.instr_o         <= '0;
                exmemif.funct_o         <= funct_t'('0);
                exmemif.opcode_o        <= opcode_t'('0);
                exmemif.rt_o            <= '0;
                exmemif.rs_o            <= '0;
            end
            
            else if (exmemif.freeze)begin
                exmemif.regWr_o         <= exmemif.regWr_o;
                exmemif.branch_o        <= exmemif.branch_o;
                exmemif.mem_write_o     <= exmemif.mem_write_o;
                exmemif.mem_read_o      <= exmemif.mem_read_o;
                exmemif.bne_o           <= exmemif.bne_o;
                exmemif.datomic_o       <= exmemif.datomic_o;
                exmemif.halt_o          <= exmemif.halt_o;
                exmemif.jump_o          <= exmemif.jump_o;
                exmemif.mem_to_reg_o    <= exmemif.mem_to_reg_o;
                exmemif.branch_addr_o   <= exmemif.branch_addr_o;
                exmemif.alu_out_o       <= exmemif.alu_out_o;
                exmemif.zero_o          <= exmemif.zero_o;
                exmemif.wsel_o          <= exmemif.wsel_o;
                exmemif.rdat1_o         <= exmemif.rdat1_o;
                exmemif.rdat2_o         <= exmemif.rdat2_o;
                exmemif.pc_p4_o         <= exmemif.pc_p4_o;
                exmemif.up_imm_o        <= exmemif.up_imm_o;
                exmemif.imem_load_o     <= exmemif.imem_load_o; //pass instr
                exmemif.jump_addr_o     <= exmemif.jump_addr_o;
                exmemif.pc_o            <= exmemif.pc_o;
                exmemif.nxt_pc_o        <= exmemif.nxt_pc_o;
                exmemif.instr_o         <= exmemif.instr_o;
                exmemif.funct_o         <= exmemif.funct_o;
                exmemif.opcode_o        <= exmemif.opcode_o;
                exmemif.rt_o            <= exmemif.rt_o;
                exmemif.rs_o            <= exmemif.rs_o;
            end
            else begin
                exmemif.regWr_o         <= exmemif.regWr_i;
                exmemif.branch_o        <= exmemif.branch_i;
                exmemif.mem_write_o     <= exmemif.mem_write_i;
                exmemif.mem_read_o      <= exmemif.mem_read_i;
                exmemif.bne_o           <= exmemif.bne_i;
                exmemif.datomic_o       <= exmemif.datomic_i;
                exmemif.halt_o          <= exmemif.halt_i;
                exmemif.jump_o          <= exmemif.jump_i;
                exmemif.mem_to_reg_o    <= exmemif.mem_to_reg_i;
                exmemif.branch_addr_o   <= exmemif.branch_addr_i;
                exmemif.alu_out_o       <= exmemif.alu_out_i;
                exmemif.zero_o          <= exmemif.zero_i;
                exmemif.wsel_o          <= exmemif.wsel_i;
                exmemif.rdat1_o         <= exmemif.rdat1_i;
                exmemif.rdat2_o         <= exmemif.rdat2_i;
                exmemif.pc_p4_o         <= exmemif.pc_p4_i;
                exmemif.up_imm_o        <= exmemif.up_imm_i;
                exmemif.imem_load_o     <= exmemif.imem_load_i; //pass instr
                exmemif.jump_addr_o     <= exmemif.jump_addr_i;
                exmemif.pc_o            <= exmemif.pc_i;
                exmemif.nxt_pc_o        <= exmemif.nxt_pc_i;
                exmemif.instr_o         <= exmemif.instr_i;
                exmemif.funct_o         <= exmemif.funct_i;
                exmemif.opcode_o        <= exmemif.opcode_i;
                exmemif.rt_o            <= exmemif.rt_i;
                exmemif.rs_o            <= exmemif.rs_i;
            end
        end
    end
endmodule