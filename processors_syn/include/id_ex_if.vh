`ifndef ID_EX_IF_VH
`define ID_EX_IF_VH

`include "cpu_types_pkg.vh"

interface id_ex_if;
	import cpu_types_pkg::*;

	/*///////////////////////////////////////////////
	Control unit Signals
	*////////////////////////////////////////////////
	logic	regWr_i, branch_i, mem_write_i, mem_read_i, alu_src_i, bne_i, datomic_i, halt_i,
			regWr_o, branch_o, mem_write_o, mem_read_o, alu_src_o, bne_o, datomic_o, halt_o;
    
	logic [1:0] jump_i, mem_to_reg_i, reg_dst_i,
				jump_o, mem_to_reg_o, reg_dst_o;

	aluop_t		aluop_i,
				aluop_o;

	/*///////////////////////////////////////////////
	Register File, Sign Extender, Load Upper Imm Signals
	*////////////////////////////////////////////////
	word_t rdat1_i, rdat2_i, signout_i, up_imm_i,
		   rdat1_o, rdat2_o, signout_o, up_imm_o;
	
	/*///////////////////////////////////////////////
	IF/ID Signals
	*////////////////////////////////////////////////
	word_t 	pc_p4_i, imem_load_i,
	       	pc_p4_o, imem_load_o; //pass instr

	logic [25:0]	jump_addr_i,
		        	jump_addr_o;
	
	logic [4:0] rt_i, rd_i, rs_i,
		   		rt_o, rd_o, rs_o;

	/*///////////////////////////////////////////////
	CPU Signals and Hazard Unit
	*////////////////////////////////////////////////
	logic flush, en, freeze;

	/*///////////////////////////////////////////////
	CPU tracker signals only
	*////////////////////////////////////////////////
	word_t	pc_i, nxt_pc_i, instr_i,
			pc_o, nxt_pc_o, instr_o;

	funct_t funct_i, 
		    funct_o;

	opcode_t opcode_i,
			 opcode_o;
	

	// **********************************************************************
	// modport
	// **********************************************************************
	modport idex(
	input 	regWr_i, branch_i, mem_write_i, mem_read_i, aluop_i, reg_dst_i, alu_src_i, jump_i, mem_to_reg_i, bne_i, datomic_i, halt_i,
			rdat1_i, rdat2_i, signout_i, up_imm_i,
			pc_p4_i, imem_load_i, jump_addr_i, rt_i, rd_i, rs_i,
			flush, en, freeze,
			pc_i, nxt_pc_i, instr_i, funct_i, opcode_i, 

	output  regWr_o, branch_o, mem_write_o, mem_read_o, aluop_o, reg_dst_o, alu_src_o, jump_o, mem_to_reg_o, bne_o, datomic_o, halt_o,
			rdat1_o, rdat2_o, signout_o, up_imm_o,
			pc_p4_o, imem_load_o, jump_addr_o, rt_o, rd_o, rs_o,
			pc_o, nxt_pc_o, instr_o, funct_o, opcode_o
	); //pass instr

endinterface
`endif
