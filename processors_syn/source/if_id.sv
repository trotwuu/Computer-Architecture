`include "if_id_if.vh"
module if_id (input logic CLK, input logic nRST, if_id_if.ifid ifidif);
    always_ff @( posedge CLK, negedge nRST ) begin : IF_ID_PIPELINE
        if(!nRST)begin
            ifidif.imem_load_o <= '0;
            ifidif.pc_p4_o <= '0;
            ifidif.pc_o <= '0;
            ifidif.nxt_pc_o <= '0;
        end
        else begin
            if (ifidif.freeze)begin
                ifidif.imem_load_o <= ifidif.imem_load_o;
                ifidif.pc_p4_o <= ifidif.pc_p4_o;
                ifidif.pc_o <= ifidif.pc_o;
                ifidif.nxt_pc_o <= ifidif.nxt_pc_o;
            end
            else if (ifidif.flush) begin //higher priority than ihit for jump and branch
                ifidif.imem_load_o <= '0;
                ifidif.pc_p4_o <= '0;
                ifidif.pc_o <= '0;
                ifidif.nxt_pc_o <= '0;
            end
            else if (ifidif.ihit)begin
                ifidif.imem_load_o <= ifidif.imem_load_i;
                ifidif.pc_p4_o <= ifidif.pc_p4_i;
                ifidif.pc_o <= ifidif.pc_i;
                ifidif.nxt_pc_o <= ifidif.nxt_pc_i;
            end
            else begin
                ifidif.imem_load_o <= '0;
                ifidif.pc_p4_o <= '0;
                ifidif.pc_o <= '0;
                ifidif.nxt_pc_o <= '0;
            end
        end
    end
endmodule