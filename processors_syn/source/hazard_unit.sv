`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"

module hazard_unit (hazard_unit_if.hu huif);
    import cpu_types_pkg::*;
    logic [4:0] ifid_rs, ifid_rt;
    
    assign      ifid_rs = huif.ifid_instr[25:21];
    assign      ifid_rt = huif.ifid_instr[20:16];

    always_comb begin 
        huif.ifid_flush     = 0;
        huif.idex_flush     = 0;
        huif.exmem_flush    = 0;
        huif.memwb_flush    = 0;
        huif.ifid_freeze    = 0;
        huif.idex_freeze    = 0;
        huif.exmem_freeze   = 0;
        huif.memwb_freeze   = 0;
        huif.pc_freeze      = 0;
        huif.pc_en_bj       = 0;

        // // lw condition
        // if((huif.ifid_instr[31:26] == 6'b100011) && ((huif.idex_rt == ifid_rs) || (huif.idex_rt == ifid_rt)) && (huif.dcif_dhit != 1) && (huif.idex_regWr == 1)) 
        // begin
        //     huif.ifid_freeze    = 1;
        //     huif.idex_flush     = 1;
        //     huif.pc_freeze      = 1;
        // end
        // jump and branch
        if((huif.pcsrc > 0)) begin
            huif.ifid_flush     = 1;
            huif.idex_flush     = 1;
            huif.exmem_flush    = 1;
            huif.pc_en_bj       = 1; //special case for j&b for in the midle of a memfetch
        end
        // mem access
        if (huif.exmem_memrw == 1 && huif.dcif_dhit != 1) begin
            huif.pc_freeze      = 1;
            huif.ifid_freeze    = 1;
            huif.idex_freeze    = 1;
            huif.exmem_freeze   = 1;
            huif.memwb_freeze    = 1;
        end

        if (huif.idex_halt == 1) begin
            huif.idex_flush = 1;
            huif.ifid_flush = 1;
        end
    end
    
endmodule