`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"

module request_unit (input logic CLK, input logic nRST, request_unit_if.request_port rq);
    import cpu_types_pkg::*;

    always_ff @( posedge CLK, negedge nRST ) 
    begin
        if(!nRST)begin
            rq.dmemREN <= '0;
            rq.dmemWEN <= '0;
        end
        else begin
            if(rq.dhit == 1) begin
                rq.dmemREN <= 0;
                rq.dmemWEN <= 0;
            end
            else if (rq.ihit == 1) begin
                rq.dmemREN <= rq.mem_read;
                rq.dmemWEN <= rq.mem_write;
            end 
        end
    end

    assign rq.imemREN = 1;

endmodule