`ifndef IF_ID_IF_VH
`define IF_ID_IF_VH

`include "cpu_types_pkg.vh"

interface if_id_if;
	import cpu_types_pkg::*;

	/*///////////////////////////////////////////////
	Adder Signals
	*////////////////////////////////////////////////
	word_t	pc_p4_i,
			pc_p4_o;
	
	/*///////////////////////////////////////////////
	Memory Signals
	*////////////////////////////////////////////////
	word_t 	imem_load_i,
			imem_load_o;

	/*///////////////////////////////////////////////
	CPU Signals and Hazard Unit
	*////////////////////////////////////////////////
	logic flush, ihit, freeze;

	/*///////////////////////////////////////////////
	CPU tracker only
	*////////////////////////////////////////////////
	word_t	pc_i, nxt_pc_i,
			pc_o, nxt_pc_o;

	// **********************************************************************
	// modport
	// **********************************************************************
	modport ifid(
	input	pc_p4_i,
			imem_load_i,
			flush, ihit, freeze,
			pc_i, nxt_pc_i,
		
	output  pc_p4_o,
			imem_load_o,
			pc_o, nxt_pc_o
	);

endinterface
`endif
