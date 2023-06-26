`ifndef FORWARD_UNIT_IF_VH
`define FORWARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface forward_unit_if;
	import cpu_types_pkg::*;

    // word_t 	dcif_dmem_load_i, memwb_dmem_load_i,
	// 		dcif_dmem_load_o;

    // word_t  exmem_alu_out_i, memwb_alu_out_i,
    //         exmem_alu_out_o, memwb_alu_out_o;

    // logic [1:0] fward_a, fward_b;


    regbits_t idex_rs, idex_rt, exmem_wsel, memwb_wsel;
    logic [1:0] fward_a, fward_b;
    logic exmem_dmemren, exmem_dmemwen, exmem_regWr, memwb_regWr;


modport fu(
    output fward_a, fward_b,
    input idex_rs, idex_rt, exmem_wsel, memwb_wsel,
          exmem_dmemren, exmem_dmemwen, exmem_regWr, memwb_regWr //, exmem_mem_to_reg //, memwb_mem_to_reg
);

modport tb(
    input fward_a, fward_b,
    output idex_rs, idex_rt, exmem_wsel, memwb_wsel,
           exmem_dmemren, exmem_dmemwen, exmem_regWr, memwb_regWr //, exmem_mem_to_reg //, memwb_mem_to_reg
);

endinterface
`endif