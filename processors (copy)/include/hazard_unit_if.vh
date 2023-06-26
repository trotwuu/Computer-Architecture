`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface hazard_unit_if;
	import cpu_types_pkg::*;

    regbits_t   idex_rt;

    word_t  ifid_instr;

    logic   [2:0] pcsrc;

    logic   dcif_dhit, pc_en_bj;

    logic   idex_regWr, exmem_memrw;

    logic   idex_halt;

    logic   ifid_flush, idex_flush, exmem_flush, memwb_flush,
            ifid_freeze, idex_freeze, exmem_freeze, memwb_freeze, pc_freeze;


    modport hu(
        input   idex_rt, ifid_instr, dcif_dhit, pcsrc, idex_regWr, exmem_memrw,
        output  ifid_flush, idex_flush, exmem_flush, memwb_flush,
                ifid_freeze, idex_freeze, exmem_freeze, memwb_freeze, pc_freeze, pc_en_bj, idex_halt
    );

    modport tb(
        input   ifid_flush, idex_flush, exmem_flush, memwb_flush,
                ifid_freeze, idex_freeze, exmem_freeze, memwb_freeze, pc_freeze, pc_en_bj, idex_halt,
        output  idex_rt, ifid_instr, dcif_dhit, pcsrc, idex_regWr, exmem_memrw
    );


endinterface
`endif