`ifndef EX_MEM_IF_VH
`define EX_MEM_IF_VH

`include "cpu_types_pkg.vh"

interface ex_mem_if;
	import cpu_types_pkg::*;

	/*///////////////////////////////////////////////
	Control Unit Signals
	*////////////////////////////////////////////////
	logic	regWr_i, branch_i, mem_write_i, mem_read_i, bne_i, datomic_i, halt_i,
			regWr_o, branch_o, mem_write_o, mem_read_o, bne_o, datomic_o, halt_o;
    
	logic [1:0]	jump_i, mem_to_reg_i,
				jump_o, mem_to_reg_o;

	/*///////////////////////////////////////////////
	Adder, ALU, Wsel MUX Signals
	*////////////////////////////////////////////////
	word_t	branch_addr_i, alu_out_i,
			branch_addr_o, alu_out_o;

	logic	zero_i,
			zero_o;

	regbits_t 	wsel_i,
				wsel_o;

	/*///////////////////////////////////////////////
	ID/EX Signals
	*////////////////////////////////////////////////
	word_t	rdat1_i, rdat2_i, pc_p4_i, up_imm_i, imem_load_i,
			rdat1_o, rdat2_o, pc_p4_o, up_imm_o, imem_load_o; //pass instr
	
	logic [25:0]	jump_addr_i,
					jump_addr_o;

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

	regbits_t	rt_i, rs_i,
				rt_o, rs_o;

	// **********************************************************************
	// modport
	// **********************************************************************
	modport exmem(
	input   regWr_i, branch_i, mem_write_i, mem_read_i, bne_i, datomic_i, jump_i, mem_to_reg_i, halt_i,
			branch_addr_i, alu_out_i, zero_i, wsel_i,
			rdat1_i, rdat2_i, pc_p4_i, up_imm_i, imem_load_i, jump_addr_i,
			flush, en, freeze,
			pc_i, nxt_pc_i, instr_i, funct_i, opcode_i, rt_i, rs_i,

	output	regWr_o, branch_o, mem_write_o, mem_read_o, bne_o, datomic_o, jump_o, mem_to_reg_o, halt_o,
			branch_addr_o, alu_out_o, zero_o, wsel_o,
			rdat1_o, rdat2_o, pc_p4_o, up_imm_o, imem_load_o, jump_addr_o,
			pc_o, nxt_pc_o, instr_o, funct_o, opcode_o, rt_o, rs_o
	); //pass instr

endinterface
`endif
