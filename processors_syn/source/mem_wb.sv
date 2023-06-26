`include "mem_wb_if.vh"
import cpu_types_pkg::*;
module mem_wb (input logic CLK, input logic nRST, mem_wb_if.memwb memwbif);
    always_ff @( posedge CLK, negedge nRST ) begin : MEM_WB_BLOCK
        if(!nRST)begin
            memwbif.regWr_o         <= '0;
            memwbif.halt_o          <= '0;
            memwbif.mem_to_reg_o    <= '0;
            memwbif.dmem_load_o     <= '0;
            memwbif.alu_out_o       <= '0;
            memwbif.pc_p4_o         <= '0;
            memwbif.up_imm_o        <= '0;
            memwbif.imem_load_o     <= '0; //pass instr
            memwbif.wsel_o          <= '0;
            memwbif.pc_o            <= '0;
            memwbif.nxt_pc_o        <= '0;
            memwbif.instr_o         <= '0;
            memwbif.branch_addr_o   <= '0;
            memwbif.funct_o         <= funct_t'('0);
            memwbif.opcode_o        <= opcode_t'('0); 
            memwbif.rt_o            <= '0;
            memwbif.rs_o            <= '0;
        end
        else begin
            if(memwbif.flush)begin
                memwbif.regWr_o         <= '0;
                memwbif.halt_o          <= '0;
                memwbif.mem_to_reg_o    <= '0;
                memwbif.dmem_load_o     <= '0;
                memwbif.alu_out_o       <= '0;
                memwbif.pc_p4_o         <= '0;
                memwbif.up_imm_o        <= '0;
                memwbif.imem_load_o     <= '0; //pass instr
                memwbif.wsel_o          <= '0;
                memwbif.pc_o            <= '0;
                memwbif.nxt_pc_o        <= '0;
                memwbif.instr_o         <= '0;
                memwbif.branch_addr_o   <= '0;
                memwbif.funct_o         <= funct_t'('0);
                memwbif.opcode_o        <= opcode_t'('0); 
                memwbif.rt_o            <= '0;
                memwbif.rs_o            <= '0;
            end
            else if(memwbif.freeze) begin
                memwbif.regWr_o         <= memwbif.regWr_o;
                memwbif.halt_o          <= memwbif.halt_o;
                memwbif.mem_to_reg_o    <= memwbif.mem_to_reg_o;
                memwbif.dmem_load_o      <= memwbif.dmem_load_o;
                memwbif.alu_out_o       <= memwbif.alu_out_o;
                memwbif.pc_p4_o         <= memwbif.pc_p4_o;
                memwbif.up_imm_o        <= memwbif.up_imm_o;
                memwbif.imem_load_o     <= memwbif.imem_load_o; //pass instr
                memwbif.wsel_o          <= memwbif.wsel_o;
                memwbif.pc_o            <= memwbif.pc_o;
                memwbif.nxt_pc_o        <= memwbif.nxt_pc_o;
                memwbif.instr_o         <= memwbif.instr_o;
                memwbif.branch_addr_o   <= memwbif.branch_addr_o;
                memwbif.funct_o         <= memwbif.funct_o;
                memwbif.opcode_o        <= memwbif.opcode_o;
                memwbif.rt_o            <= memwbif.rt_o;
                memwbif.rs_o            <= memwbif.rs_o;
            end
            else begin
                memwbif.regWr_o         <= memwbif.regWr_i;
                memwbif.halt_o          <= memwbif.halt_i;
                memwbif.mem_to_reg_o    <= memwbif.mem_to_reg_i;
                memwbif.dmem_load_o     <= memwbif.dmem_load_i;
                memwbif.alu_out_o       <= memwbif.alu_out_i;
                memwbif.pc_p4_o         <= memwbif.pc_p4_i;
                memwbif.up_imm_o        <= memwbif.up_imm_i;
                memwbif.imem_load_o     <= memwbif.imem_load_i; //pass instr
                memwbif.wsel_o          <= memwbif.wsel_i;
                memwbif.pc_o            <= memwbif.pc_i;
                memwbif.nxt_pc_o        <= memwbif.nxt_pc_i;
                memwbif.instr_o         <= memwbif.instr_i;
                memwbif.branch_addr_o   <= memwbif.branch_addr_i;
                memwbif.funct_o         <= memwbif.funct_i;
                memwbif.opcode_o        <= memwbif.opcode_i;
                memwbif.rt_o            <= memwbif.rt_i;
                memwbif.rs_o            <= memwbif.rs_i;
            end
        end
    end
endmodule