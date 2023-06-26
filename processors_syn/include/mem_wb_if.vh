`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

`include "cpu_types_pkg.vh"

interface mem_wb_if;
	import cpu_types_pkg::*;

	/*///////////////////////////////////////////////
	Control Unit Signals
	*////////////////////////////////////////////////
	logic	regWr_i, halt_i,
		  	regWr_o, halt_o;
    
	logic [1:0] mem_to_reg_i,
				mem_to_reg_o;

	/*///////////////////////////////////////////////
	Memory Signals
	*////////////////////////////////////////////////
	word_t 	dmem_load_i,
			dmem_load_o;

	/*///////////////////////////////////////////////
	EX/MEM Signals
	*////////////////////////////////////////////////
	word_t	alu_out_i, pc_p4_i, up_imm_i, imem_load_i,
			alu_out_o, pc_p4_o, up_imm_o, imem_load_o; //pass instr
	
	regbits_t 	wsel_i,
				wsel_o;

	/*///////////////////////////////////////////////
	CPU Signals and Hazard Unit
	*////////////////////////////////////////////////
	logic flush, en, freeze;

	/*///////////////////////////////////////////////
	CPU tracker signals only
	*////////////////////////////////////////////////
	word_t	pc_i, nxt_pc_i, instr_i, branch_addr_i,
			pc_o, nxt_pc_o, instr_o, branch_addr_o;

	funct_t funct_i, 
		    funct_o;

	opcode_t opcode_i,
			 opcode_o;

	regbits_t	rt_i, rs_i, rdat2_i,
				rt_o, rs_o, rdat2_o;

	// **********************************************************************
	// modport
	// **********************************************************************
	modport memwb(
	input	regWr_i, mem_to_reg_i, halt_i,
		    dmem_load_i,
			alu_out_i, pc_p4_i, up_imm_i, imem_load_i, wsel_i,
			flush, en, freeze,
			pc_i, nxt_pc_i, instr_i, branch_addr_i, funct_i, opcode_i, rt_i, rs_i, //pass instr

	output	regWr_o, mem_to_reg_o, halt_o,
		    dmem_load_o,
			alu_out_o, pc_p4_o, up_imm_o, imem_load_o, wsel_o,
			pc_o, nxt_pc_o, instr_o, branch_addr_o, funct_o, opcode_o, rt_o, rs_o //pass instr
	);

endinterface
`endif
