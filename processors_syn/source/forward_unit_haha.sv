// `include "cpu_types_pkg.vh"
`include "forward_unit_if.vh"

module forward_unit_haha (forward_unit_if.fu fuif);
   always_comb begin
        fuif.fward_a = '0; 
        fuif.fward_b = '0;
        if(fuif.memwb_regWr == 1)begin
            if(fuif.memwb_wsel != 0)begin
                if(fuif.memwb_wsel == fuif.idex_rs)begin
                    fuif.fward_a = 2'b01;
                end
                if(fuif.memwb_wsel == fuif.idex_rt)begin
                    fuif.fward_b = 2'b01;
                end
            end
        end

        if (fuif.exmem_regWr == 1) begin
            if (fuif.exmem_wsel != 0)begin
                if(fuif.exmem_wsel == fuif.idex_rs)begin 
                    fuif.fward_a = 2'b10;
                end
                if(fuif.exmem_wsel == fuif.idex_rt)begin
                    fuif.fward_b = 2'b10;
                end
            end
        end
    end
    
endmodule