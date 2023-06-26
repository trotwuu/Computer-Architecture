`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module dcache (
  input logic CLK, nRST,
  datapath_cache_if.dcache dcif,
  caches_if.dcache cif
);

typedef enum logic [3:0] {  IDLE, 
                            RMEM0, RMEM1, WMEM0, WMEM1,
                            HITCOUNT, DIRTY, FLUSH0,FLUSH00, FLUSH1,FLUSH11, HALT, SNOOPCHECK, SNOOP_SHARE1, SNOOP_SHARE2 } stateType;
stateType state, nxt_state;

dcache_frame [7:0] frame_left, nxt_frame_left;
dcache_frame [7:0] frame_right, nxt_frame_right;

dcachef_t addr;
assign addr = dcachef_t'(dcif.dmemaddr);

word_t hit_count, nxt_hit_count, miss, nxt_miss;

logic [4:0] row_count, nxt_row_count;

logic [7:0] LRU, nxt_LRU; 

logic [2:0] flag;

//snop stuff
logic [25:0] snooptag; //
logic [2:0] snoopidx;
assign snooptag = cif.ccsnoopaddr[31:6];
assign snoopidx = cif.ccsnoopaddr[5:3];

// link register
word_t linkreg, nxt_linkreg;
logic  linkval, nxt_linkval;

logic lefttagmatch, righttagmatch,leftvalid,rightvalid,leftdirty,rightdirty,snooptagmatch_left,snooptagmatch_right;
logic[2:0] row_count_tmp;
logic nxt_dcif_halt, dcif_halt;


assign lefttagmatch = (frame_left[addr.idx].tag == addr.tag);
assign righttagmatch = (frame_right[addr.idx].tag == addr.tag);
assign leftvalid = frame_left[addr.idx].valid;
assign rightvalid = frame_right[addr.idx].valid;
assign leftdirty = frame_left[addr.idx].dirty;
assign rightdirty = frame_right[addr.idx].dirty;

assign snooptagmatch_left = snooptag == frame_left[snoopidx].tag;
assign snooptagmatch_right = snooptag == frame_right[snoopidx].tag;


always_comb begin
        nxt_dcif_halt = dcif_halt;
        if (dcif.halt)
            nxt_dcif_halt = 1;
    end

// state logic
always_comb begin
    nxt_state = state;

    nxt_linkreg = linkreg;
    nxt_linkval = linkval;

    nxt_frame_left[addr.idx].valid = frame_left[addr.idx].valid;
    nxt_frame_left[addr.idx].tag = frame_left[addr.idx].tag;
    nxt_frame_left[addr.idx].data = frame_left[addr.idx].data;

    nxt_frame_right[addr.idx].valid = frame_right[addr.idx].valid;
    nxt_frame_right[addr.idx].tag = frame_right[addr.idx].tag;
    nxt_frame_right[addr.idx].data = frame_right[addr.idx].data;

    nxt_frame_left = frame_left;
    nxt_frame_right = frame_right;
    nxt_LRU = LRU;

    nxt_row_count = row_count;

    dcif.dhit = '0;
    dcif.dmemload = '0;
    dcif.flushed = '0;

    cif.dREN = '0;
    cif.dWEN = '0;
    cif.daddr = '0;
    cif.dstore = 32'hf1f1f1f1;

    cif.cctrans  = '0;
    cif.ccwrite = dcif.dmemWEN;

    row_count_tmp = row_count[2:0];

    case (state)
        IDLE: begin
            if(dcif_halt) begin
                nxt_state = DIRTY;
            end
            else if (cif.ccwait) begin
                nxt_state = SNOOPCHECK;
            end 
            else begin
                if (dcif.dmemREN) begin
                    // LL
                    if(dcif.datomic) begin
                        nxt_linkreg = dcif.dmemaddr;
                        nxt_linkval = 1;
                    end

                    if (lefttagmatch && leftvalid) begin
                        dcif.dhit = 1;
                        nxt_LRU[addr.idx] = 1;
                        dcif.dmemload = frame_left[addr.idx].data[addr.blkoff];
                    end 
                    else if (righttagmatch && rightvalid) begin
                        dcif.dhit = 1;
                        nxt_LRU[addr.idx] = 0;
                        dcif.dmemload = frame_right[addr.idx].data[addr.blkoff];
                    end 
                    else if (LRU[addr.idx] == 0 && leftvalid && leftdirty) begin
                        nxt_state = WMEM0;
                    end
                    else if (LRU[addr.idx] == 1 && rightvalid & rightdirty) begin
                        nxt_state = WMEM0;
                    end 
                    else begin
                        nxt_state = RMEM0;
                    end

                end
                // write with sc
                else if(dcif.dmemWEN && dcif.datomic) begin
                    if(dcif.dmemaddr == linkreg && linkval) begin // test pass
                        if(lefttagmatch && leftvalid && leftdirty) begin
                            dcif.dhit = 1;
                            nxt_linkreg = '0;
                            nxt_linkval = 0;

                            nxt_frame_left[addr.idx].dirty = 1; // already dirty no need to set again
                            nxt_LRU[addr.idx] = 1;
                            nxt_frame_left[addr.idx].data[addr.blkoff] = dcif.dmemstore;
                            dcif.dmemload = 1;

                        end
                        else if(righttagmatch && rightvalid && rightdirty) begin
                            dcif.dhit = 1;
                            nxt_linkreg = '0;
                            nxt_linkval = 0;

                            nxt_frame_right[addr.idx].dirty = 1; // already dirty no need to set again
                            nxt_LRU[addr.idx] = 0;
                            nxt_frame_right[addr.idx].data[addr.blkoff] = dcif.dmemstore;
                            dcif.dmemload = 1;
                        end
                        else if(lefttagmatch && leftvalid) begin
                            nxt_LRU[addr.idx] = 0;
                            nxt_state = RMEM0;
                        end
                        else if(righttagmatch && rightvalid) begin
                            nxt_LRU[addr.idx] = 1;
                            nxt_state = RMEM0;
                        end
                        else if (LRU[addr.idx] == 0 && leftvalid && leftdirty) begin
                            nxt_state = WMEM0;
                        end
                        else if (LRU[addr.idx] == 1 && rightvalid & rightdirty) begin
                            nxt_state = WMEM0;
                        end  
                        else begin
                            nxt_state = RMEM0;
                        end

                    end
                    else begin // test fail
                        dcif.dmemload = 0;
                        dcif.dhit = 1;
                    end
                end
                else if (dcif.dmemWEN) begin
                    if(dcif.dmemaddr == linkreg && linkval) begin // test pass
                        nxt_linkreg = '0;
                        nxt_linkval = 0;
                    end
                    if(lefttagmatch && leftvalid && leftdirty) begin
                        dcif.dhit = 1;
                        nxt_linkreg = '0;
                        nxt_linkval = 0;
                        nxt_frame_left[addr.idx].dirty = 1; // already dirty no need to set again
                        nxt_LRU[addr.idx] = 1;
                        nxt_frame_left[addr.idx].data[addr.blkoff] = dcif.dmemstore;
                    end
                    else if(righttagmatch && rightvalid && rightdirty) begin
                        dcif.dhit = 1;
                        nxt_linkreg = '0;
                        nxt_linkval = 0;
                        nxt_frame_right[addr.idx].dirty = 1; // already dirty no need to set again
                        nxt_LRU[addr.idx] = 0;
                        nxt_frame_right[addr.idx].data[addr.blkoff] = dcif.dmemstore;
                    end
                    else if(lefttagmatch && leftvalid) begin
                        nxt_LRU[addr.idx] = 0;
                        nxt_state = RMEM0;
                    end
                    else if(righttagmatch && rightvalid) begin
                        nxt_LRU[addr.idx] = 1;
                        nxt_state = RMEM0;
                    end
                    else if (LRU[addr.idx] == 0 && leftvalid && leftdirty) begin
                        nxt_state = WMEM0;
                    end
                    else if (LRU[addr.idx] == 1 && rightvalid & rightdirty) begin
                        nxt_state = WMEM0;
                    end  
                    else begin
                        nxt_state = RMEM0;
                    end
                end
            end
        end
        
        RMEM0: begin
            // Request data[0] to Bus
            cif.dREN = 1;
            cif.daddr = {addr.tag, addr.idx, 3'b000};
            if (cif.ccwait) // For two cache request RMEM at the same time
                nxt_state = SNOOPCHECK;
            else if (cif.dwait == 0) begin
                nxt_state = RMEM1;
                if(LRU[addr.idx] == 0) begin            // Replace left frame
                    nxt_frame_left[addr.idx].valid = 0;
                    nxt_frame_left[addr.idx].data[0] = cif.dload;
                end
                else if(LRU[addr.idx] == 1) begin       // Replace right frame
                    nxt_frame_right[addr.idx].valid = 0;
                    nxt_frame_right[addr.idx].data[0] = cif.dload;
                end
            end
        end
        
        RMEM1: begin
            // Request data[1] to Bus
            cif.dREN = 1;
            cif.daddr = {addr.tag, addr.idx, 3'b100};
            if(cif.dwait == 0) begin
                nxt_state = IDLE;
                if(LRU[addr.idx] == 0) begin            // Replace left frame
                    nxt_frame_left[addr.idx].tag = addr.tag;
                    nxt_frame_left[addr.idx].valid = 1;
                    nxt_frame_left[addr.idx].dirty = (dcif.dmemWEN)? 1:0;
                    nxt_frame_left[addr.idx].data[1] = cif.dload;
                end
                else if(LRU[addr.idx] == 1) begin       // Replace right frame
                    nxt_frame_right[addr.idx].tag = addr.tag;
                    nxt_frame_right[addr.idx].valid = 1;
                    nxt_frame_right[addr.idx].dirty = (dcif.dmemWEN)? 1:0;
                    nxt_frame_right[addr.idx].data[1] = cif.dload;
                end
            end
        end

        WMEM0: begin
            if(cif.dwait == 0)
                nxt_state = WMEM1;
            if (cif.ccwait) // For requester in RMEM and the responder stuck at WMEM0
                nxt_state = SNOOPCHECK;
            cif.dWEN = 1;

            if(LRU[addr.idx] == 0 && leftvalid & leftdirty) begin            // Replace left frame add LRU check only replace relevent side
                cif.daddr = {frame_left[addr.idx].tag, addr.idx, 3'b0};
                cif.dstore = frame_left[addr.idx].data[0];
            end
            else if(LRU[addr.idx] == 1 && rightvalid & rightdirty) begin       // Replace right frame add LRU check 
                cif.daddr = {frame_right[addr.idx].tag, addr.idx, 3'b0};
                cif.dstore = frame_right[addr.idx].data[0];
            end
        end

        WMEM1: begin
            if(cif.dwait == 0)
                nxt_state = RMEM0;

            cif.dWEN = 1;

            if(LRU[addr.idx] == 0 && leftvalid & leftdirty) begin            // Replace left frame
                cif.daddr = {frame_left[addr.idx].tag, addr.idx, 3'b100};
                cif.dstore = frame_left[addr.idx].data[1];
                if (cif.dwait == 0) begin
                    nxt_frame_left[addr.idx].dirty = 0;
                    nxt_frame_left[addr.idx].valid = 0;
                end
                
            end
            else if(LRU[addr.idx] == 1 && rightvalid & rightdirty) begin       // Replace right frame
                cif.daddr = {frame_right[addr.idx].tag, addr.idx, 3'b100};
                cif.dstore = frame_right[addr.idx].data[1];
                if (cif.dwait == 0) begin
                    nxt_frame_right[addr.idx].dirty = 0;
                    nxt_frame_right[addr.idx].valid = 0;
                end
                
            end
        end
        
        HITCOUNT: begin

                nxt_state = DIRTY;
            
        end

        DIRTY: begin
            
            if (row_count < 8) begin
                if(frame_left[row_count[2:0]].dirty && frame_left[row_count[2:0]].valid) begin
                    nxt_state = FLUSH0;
                end else begin
                    nxt_row_count = row_count + 1;
                end
            end else begin
                if(frame_right[row_count[2:0]].dirty && frame_right[row_count[2:0]].valid) begin
                    nxt_state = FLUSH0;
                end else begin
                    nxt_row_count = row_count + 1;
                end
            end
            
            if (cif.ccwait) begin
                nxt_state = SNOOPCHECK;
            end 

            if(row_count >= 16) begin
                nxt_state = HALT;
            end
        end

        FLUSH0: begin
            if(cif.dwait == 0) begin
                nxt_state = FLUSH1;
            end
            if (cif.ccwait) begin
                nxt_state = SNOOPCHECK;
            end 

            cif.dWEN = 1;
            if (row_count < 8) begin
                cif.daddr = {frame_left[row_count_tmp].tag, row_count_tmp, 3'b0};
                cif.dstore = frame_left[row_count_tmp].data[0];
            end else begin
                cif.daddr = {frame_right[row_count_tmp].tag, row_count_tmp, 3'b0};
                cif.dstore = frame_right[row_count_tmp].data[0];
            end
        end

        FLUSH1: begin
            if(cif.dwait == 0) begin
                nxt_state = DIRTY;
                nxt_row_count = row_count + 1;
            end

            cif.dWEN = 1;
            if (row_count < 8) begin
                cif.daddr = {frame_left[row_count_tmp].tag, row_count_tmp, 3'b100};
                cif.dstore = frame_left[row_count_tmp].data[1];
                if (cif.dwait == 0) begin
                    nxt_frame_left[row_count_tmp].dirty = 0;
                    nxt_frame_left[row_count_tmp].valid = 0;
                end
            end else begin
                cif.daddr = {frame_right[row_count_tmp].tag, row_count_tmp, 3'b100};
                cif.dstore = frame_right[row_count_tmp].data[1];
                if (cif.dwait == 0) begin
                    nxt_frame_right[row_count_tmp].dirty = 0;
                    nxt_frame_right[row_count_tmp].valid = 0;
                end
            end
        end

        HALT: begin
            dcif.flushed = 1;
        end

        SNOOPCHECK:begin
            if (linkreg == cif.ccsnoopaddr) begin
                nxt_linkval = 0;
                nxt_linkreg = '0;
            end

            if (snooptag == frame_right[snoopidx].tag)begin
                if (frame_right[snoopidx].dirty)begin
                    nxt_state = SNOOP_SHARE1;
                    cif.cctrans = 1;
                end
                else if (cif.ccinv && !frame_right[snoopidx].dirty)begin
                    nxt_state = IDLE; 
                    nxt_frame_right[snoopidx].tag = '0;
                    nxt_frame_right[snoopidx].valid = 0;
                    nxt_frame_right[snoopidx].dirty = 0;
                    nxt_frame_right[snoopidx].data[0] = '0;
                    nxt_frame_right[snoopidx].data[1] = '0;
                end else begin
                    nxt_state = IDLE;
                end
            end
            else if (snooptag == frame_left[snoopidx].tag)begin
                if (frame_left[snoopidx].dirty)begin
                    nxt_state = SNOOP_SHARE1;
                    cif.cctrans = 1;
                end
                else if (cif.ccinv && !frame_left[snoopidx].dirty)begin
                    nxt_state = IDLE; 
                    nxt_frame_left[snoopidx].tag = '0;
                    nxt_frame_left[snoopidx].valid = 0;
                    nxt_frame_left[snoopidx].dirty = 0;
                    nxt_frame_left[snoopidx].data[0] = '0;
                    nxt_frame_left[snoopidx].data[1] = '0;
                end else begin
                    nxt_state = IDLE;
                end
            end
            else begin
                nxt_state = IDLE;
            end
        end

        SNOOP_SHARE1:begin
            if (cif.dwait == 0)begin
                nxt_state = SNOOP_SHARE2;
            end

            if (snooptagmatch_left)begin
                cif.dstore = frame_left[snoopidx].data[0];
                cif.daddr = {frame_left[snoopidx].tag, snoopidx,3'b000};
            end
            else if (snooptagmatch_right)begin
                cif.dstore = frame_right[snoopidx].data[0];
                cif.daddr = {frame_right[snoopidx].tag, snoopidx,3'b000};
            end
        end

        SNOOP_SHARE2:begin
            if (cif.dwait == 0)begin
                nxt_state = IDLE;
            end

            if (snooptagmatch_left)begin
                cif.dstore = frame_left[snoopidx].data[1];
                cif.daddr = {frame_left[snoopidx].tag, snoopidx,1'b1,2'b00};
                nxt_frame_left[snoopidx].dirty = 0;
                if ((cif.dwait == 0) && cif.ccinv)begin
                    nxt_frame_left[snoopidx].tag = '0;
                    nxt_frame_left[snoopidx].valid = 0;
                    nxt_frame_left[snoopidx].dirty = 0;
                    nxt_frame_left[snoopidx].data[0] = '0;
                    nxt_frame_left[snoopidx].data[1] = '0;
                end
            end
            else if (snooptagmatch_right)begin
                cif.dstore = frame_right[snoopidx].data[1];
                cif.daddr = {frame_right[snoopidx].tag, snoopidx,1'b1,2'b00};
                nxt_frame_right[snoopidx].dirty = 0;
                if ((cif.dwait == 0) && cif.ccinv)begin
                    nxt_frame_right[snoopidx].tag = '0;
                    nxt_frame_right[snoopidx].valid = 0;
                    nxt_frame_right[snoopidx].dirty = 0;
                    nxt_frame_right[snoopidx].data[0] = '0;
                    nxt_frame_right[snoopidx].data[1] = '0;
                end
            end
        end
    endcase
end

always_ff @( posedge CLK, negedge nRST ) begin
    if(!nRST) begin
        state <= IDLE;
        hit_count <= '0;
        miss <= '0;
        row_count <= '0;
        LRU <= '0;
        for(int i=0; i<8; i++) begin
            frame_left[i] <= '0;
            frame_right[i] <= '0;
        end
        linkreg <= '0;
        linkval <= 0;
        dcif_halt <= '0;
    end
    else begin
        state <= nxt_state;
        hit_count <= nxt_hit_count;
        miss <= nxt_miss;
        row_count <= nxt_row_count;
        LRU <= nxt_LRU;
        frame_left <= nxt_frame_left;
        frame_right <= nxt_frame_right;
        linkreg <= nxt_linkreg;
        linkval <= nxt_linkval;
        dcif_halt <= nxt_dcif_halt;
    end
end
    
endmodule
