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
                            SNPCHK, SNPSHR0, SNPSHR1,
                            HITCOUNT, FLUSH0, FLUSH1, HALT } stateType;
stateType state, nxt_state;

dcache_frame [7:0] frame_left, nxt_frame_left;
dcache_frame [7:0] frame_right, nxt_frame_right;

dcachef_t addr;
assign addr = dcachef_t'(dcif.dmemaddr);

logic hit_left, hit_right;
word_t hit_count, nxt_hit_count, miss, nxt_miss;

logic [4:0] row_count, nxt_row_count;

logic [7:0] LRU, nxt_LRU; 

logic [2:0] flag;

logic cache_dhit;
//snop stuff
logic [25:0] snooptag;
logic [2:0] snoopidx;
assign snooptag = cif.ccsnoopaddr[31:6];
assign snoopidx = cif.ccsnoopaddr[5:3];

// link register
word_t linkreg, nxt_linkreg;
logic  linkval, nxt_linkval;
logic nxt_dcif_halt, dcif_halt;
always_comb begin
        nxt_dcif_halt = dcif_halt;
        if (dcif.halt)
            nxt_dcif_halt = 1;
    end

// state logic
always_comb begin
    nxt_state = state;
    flag = '0;

    cif.cctrans  = '0;
    cif.ccwrite = dcif.dmemWEN;

    nxt_linkreg = linkreg;
    nxt_linkval = linkval;

    case (state)
        IDLE: begin
            if(dcif_halt) begin
                nxt_state = FLUSH0;
            end
            else if (cif.ccwait) begin
                nxt_state = SNPCHK;
            end
            else begin
                // read 
                if(dcif.dmemREN) begin
                    // LL
                    if(dcif.datomic) begin
                        nxt_linkreg = dcif.dmemaddr;
                        nxt_linkval = 1;
                    end
                    
                    // regular read
                    if((frame_left[addr.idx].tag == addr.tag) && frame_left[addr.idx].valid) begin
                        flag = 3'd1;
                    end
                    else if((frame_right[addr.idx].tag == addr.tag) && frame_right[addr.idx].valid) begin
                        flag = 3'd2;
                    end
                    else begin
                        flag = 3'd5;
                        if(LRU[addr.idx] == 0) begin
                            nxt_state = frame_left[addr.idx].dirty ? WMEM0:RMEM0;
                            // cif.cctrans = frame_left[addr.idx].dirty ? 0:1;
                        end
                        else begin
                            nxt_state = frame_right[addr.idx].dirty ? WMEM0:RMEM0;
                            // cif.cctrans = frame_right[addr.idx].dirty ? 0:1;
                        end
                    end
                end

                // write with sc
                else if(dcif.dmemWEN && dcif.datomic) begin
                    if(dcif.dmemaddr == linkreg && linkval) begin // test pass
                        if(frame_left[addr.idx].tag == addr.tag) begin
                            flag = 3'd3;
                            nxt_linkreg = '0;
                            nxt_linkval = 0;
                        end
                        else if(frame_right[addr.idx].tag == addr.tag) begin
                            flag = 3'd4;
                            nxt_linkreg = '0;
                            nxt_linkval = 0;
                        end
                        else begin
                            flag = 3'd5;
                            if(LRU[addr.idx] == 0) begin
                                nxt_state = frame_left[addr.idx].dirty ? WMEM0:RMEM0;
                                // cif.cctrans = frame_left[addr.idx].dirty ? 0:1;
                            end
                            else begin
                                nxt_state = frame_right[addr.idx].dirty ? WMEM0:RMEM0;
                                // cif.cctrans = frame_right[addr.idx].dirty ? 0:1;
                            end
                        end
                    end
                    else begin // test fail
                        flag = 3'd6;
                    end
                end
                // regular write
                else if(dcif.dmemWEN) begin
                    if(dcif.dmemaddr == linkreg && linkval) begin // test pass
                        nxt_linkreg = '0;
                        nxt_linkval = 0;
                    end
                    if(frame_left[addr.idx].tag == addr.tag) begin
                        flag = 3'd3;
                    end
                    else if(frame_right[addr.idx].tag == addr.tag) begin
                        flag = 3'd4;
                    end
                    else begin
                        flag = 3'd5;
                        if(LRU[addr.idx] == 0) begin
                            nxt_state = frame_left[addr.idx].dirty ? WMEM0:RMEM0;
                            // cif.cctrans = frame_left[addr.idx].dirty ? 0:1;
                        end
                        else begin
                            nxt_state = frame_right[addr.idx].dirty ? WMEM0:RMEM0;
                            // cif.cctrans = frame_right[addr.idx].dirty ? 0:1;
                        end
                    end
                end
            end
        end
        
        RMEM0: begin
            if(cif.dwait == 0)
                nxt_state = RMEM1;
            if (cif.ccwait)
                nxt_state = SNPCHK;
            // cif.cctrans = !cif.ccwait;
        end
        
        RMEM1: begin
            if(cif.dwait == 0)
                nxt_state = IDLE;
        end

        WMEM0: begin
            if(cif.dwait == 0)
                nxt_state = WMEM1;
        end

        WMEM1: begin
            if(cif.dwait == 0)
                nxt_state = RMEM0;
        end
        
        HITCOUNT: begin
                nxt_state = FLUSH0;
        end

        FLUSH0: begin
            if(nxt_row_count >= 5'b10000 && cif.dWEN == 0)
                nxt_state = HALT;
            else if(cif.dWEN == 1 && cif.dwait == 1)
                nxt_state = FLUSH0;
            else
                nxt_state = FLUSH1;
        end

        FLUSH1: begin
            if(nxt_row_count >= 5'b10000 && cif.dWEN == 0)
                nxt_state = HALT;
            else if(cif.dWEN == 1 && cif.dwait == 1)
                nxt_state = FLUSH1;
            else
                nxt_state = FLUSH0;
        end

        SNPCHK: begin

            if (linkreg == cif.ccsnoopaddr) begin
                nxt_linkval = 0;
                nxt_linkreg = '0;
            end

            if (cif.ccwait && snooptag == frame_right[snoopidx].tag)begin
                if (frame_right[snoopidx].dirty)begin
                    nxt_state = SNPSHR0;
                    cif.cctrans = 1;
                end
                else if (cif.ccinv && !frame_right[snoopidx].dirty)begin
                    nxt_state = SNPCHK; 
                end
            end
            else if (cif.ccwait && snooptag == frame_left[snoopidx].tag)begin
                if (frame_left[snoopidx].dirty)begin
                    nxt_state = SNPSHR0;
                    cif.cctrans = 1;
                end
                else if (cif.ccinv && !frame_left[snoopidx].dirty)begin
                    nxt_state = SNPCHK; 
                end
            end

            else if (cif.ccwait) begin
                cif.cctrans = 0;
                nxt_state = SNPCHK;
            end 
            else begin
                nxt_state = IDLE;
            end
        end

        SNPSHR0:begin
            if (~cif.dwait)begin
                nxt_state = SNPSHR1;
            end
        end

        SNPSHR1:begin
            if (~cif.dwait)begin
                nxt_state = IDLE;
            end
        end
    endcase
end

// output logic
always_comb begin : output_logic
    dcif.dhit = '0;
    dcif.dmemload = '0;
    dcif.flushed = '0;

    cif.dREN = '0;
    cif.dWEN = '0;
    cif.daddr = '0;
    cif.dstore = '0;
    
    hit_left = '0;
    hit_right = '0;
    nxt_hit_count = hit_count;
    nxt_miss = miss;
    nxt_row_count = row_count;

    nxt_frame_left = frame_left;
    nxt_frame_right = frame_right;

    nxt_LRU = LRU;
    cache_dhit = 0;

    case (state)
        IDLE: begin
            // LRU logic
            if(hit_left)
                nxt_LRU[addr.idx] = 1;
            else if(hit_right)
                nxt_LRU[addr.idx] = 0;

            case (flag)
                3'd1: begin
                    dcif.dhit = 1;
					dcif.dmemload = addr.blkoff ? frame_left[addr.idx].data[1] : frame_left[addr.idx].data[0];
					nxt_LRU[addr.idx] = 1;
					nxt_hit_count = hit_count + 1;
                end
                3'd2: begin
                    dcif.dhit = 1;
					dcif.dmemload = addr.blkoff ? frame_right[addr.idx].data[1] : frame_right[addr.idx].data[0];
					nxt_LRU[addr.idx] = 0;
					nxt_hit_count = hit_count + 1;
                end
                3'd3: begin
                    dcif.dhit = 1;
                    nxt_frame_left[addr.idx].dirty = 1;
                    nxt_LRU[addr.idx] = 1;
					nxt_hit_count = hit_count + 1;

                    if(addr.blkoff == 0) begin
                        nxt_frame_left[addr.idx].data[0] = dcif.dmemstore;
                    end
                    else if(addr.blkoff == 1) begin
                        nxt_frame_left[addr.idx].data[1] = dcif.dmemstore;
                    end

                    dcif.dmemload = 1;
                end
                3'd4: begin
                    dcif.dhit = 1;
                    nxt_frame_right[addr.idx].dirty = 1;
                    nxt_LRU[addr.idx] = 0;
					nxt_hit_count = hit_count + 1;

                    if(addr.blkoff == 0) begin
                        nxt_frame_right[addr.idx].data[0] = dcif.dmemstore;
                    end
                    else if(addr.blkoff == 1) begin
                        nxt_frame_right[addr.idx].data[1] = dcif.dmemstore;
                    end

                    dcif.dmemload = 1;
                end
                3'd5: begin
                    nxt_hit_count = hit_count - 1;
                end
                3'd6: begin
                    dcif.dmemload = 0;
                    dcif.dhit = 1;
                end
            endcase
        end

        RMEM0: begin
            if(LRU[addr.idx] == 0) begin            // use left set
                nxt_frame_left[addr.idx].valid = 0;
            end
            else if(LRU[addr.idx] == 1) begin       // use right set
                nxt_frame_right[addr.idx].valid = 0;
            end

            cif.dREN = 1;
            cif.daddr = {addr.tag, addr.idx, 3'b000};
            // replace data[0]
            if(LRU[addr.idx] == 0) begin            // use left set
                nxt_frame_left[addr.idx].data[0] = cif.dload;
            end
            else if(LRU[addr.idx] == 1) begin       // use right set
                nxt_frame_right[addr.idx].data[0] = cif.dload;
            end
        end

        RMEM1: begin
            cif.dREN = 1;
            cif.daddr = {addr.tag, addr.idx, 3'b100};
            nxt_miss = miss + 1;
            // replace data[1]
            if(LRU[addr.idx] == 0) begin            // use left set
                nxt_frame_left[addr.idx].tag = addr.tag;
                nxt_frame_left[addr.idx].valid = 1;
                nxt_frame_left[addr.idx].dirty = 0;
                nxt_frame_left[addr.idx].data[1] = cif.dload;
            end
            else if(LRU[addr.idx] == 1) begin       // use right set
                nxt_frame_right[addr.idx].tag = addr.tag;
                nxt_frame_right[addr.idx].valid = 1;
                nxt_frame_right[addr.idx].dirty = 0;
                nxt_frame_right[addr.idx].data[1] = cif.dload;
            end
        end

        WMEM0: begin
            cif.dWEN = 1;

            if(LRU[addr.idx] == 0) begin            // use left set
                cif.daddr = {frame_left[addr.idx].tag, addr.idx, 3'b0};
                cif.dstore = frame_left[addr.idx].data[0];
            end
            else if(LRU[addr.idx] == 1) begin       // use right set
                cif.daddr = {frame_right[addr.idx].tag, addr.idx, 3'b0};
                cif.dstore = frame_right[addr.idx].data[0];
            end
        end

        WMEM1: begin
            cif.dWEN = 1;

            if(LRU[addr.idx] == 0) begin            // use left set
                cif.daddr = {frame_left[addr.idx].tag, addr.idx, 3'b100};
                cif.dstore = frame_left[addr.idx].data[1];
                nxt_frame_left[addr.idx].dirty = 0;
                nxt_frame_left[addr.idx].valid = 0;
            end
            else if(LRU[addr.idx] == 1) begin       // use right set
                cif.daddr = {frame_right[addr.idx].tag, addr.idx, 3'b100};
                cif.dstore = frame_right[addr.idx].data[1];
                nxt_frame_right[addr.idx].dirty = 0;
                nxt_frame_right[addr.idx].valid = 0;
            end
        end

        HITCOUNT: begin
            // do nothing since no need to hitcount
        end

        FLUSH0: begin
            if(frame_left[row_count[3:1]].dirty && !row_count[0]) begin
                cif.dWEN = 1;
                cif.daddr = {frame_left[row_count[3:1]].tag, row_count[3:1], 3'b0};
                cif.dstore = frame_left[row_count[3:1]].data[0];
            end
            if(frame_right[row_count[3:1]].dirty && row_count[0]) begin
                cif.dWEN = 1;
                cif.daddr = {frame_right[row_count[3:1]].tag, row_count[3:1], 3'b0};
                cif.dstore = frame_right[row_count[3:1]].data[0];
            end
            if(row_count == 'd16) begin
                cif.dWEN = 0;
            end
        end

        FLUSH1: begin
            if(frame_left[row_count[3:1]].dirty && !row_count[0]) begin
                cif.dWEN = 1;
                cif.daddr = {frame_left[row_count[3:1]].tag, row_count[3:1], 3'b100};
                cif.dstore = frame_left[row_count[3:1]].data[1];
                
            end
            if(frame_right[row_count[3:1]].dirty && row_count[0]) begin
                cif.dWEN = 1;
                cif.daddr = {frame_right[row_count[3:1]].tag, row_count[3:1], 3'b100};
                cif.dstore = frame_right[row_count[3:1]].data[1];
            end

            if(row_count == 'd16) begin
                cif.dWEN = 0;
            end
            if (!cif.dWEN || !cif.dwait) begin
                if(frame_left[row_count[3:1]].dirty && !row_count[0]) begin
                    nxt_frame_left[row_count[3:1]].dirty = 0;
                    nxt_frame_left[row_count[3:1]].valid = 0;
                end 
                else if(frame_right[row_count[3:1]].dirty && row_count[0]) begin
                    nxt_frame_right[row_count[3:1]].dirty = 0;
                    nxt_frame_right[row_count[3:1]].valid = 0;
                end
                nxt_row_count = row_count + 1;
            end 
        end

        HALT: begin
            dcif.flushed = 1;
        end

        SNPCHK:begin
            if (cif.ccwait && snooptag == frame_right[snoopidx].tag)begin
                if (cif.ccinv && !frame_right[snoopidx].dirty)begin
                    nxt_frame_right[snoopidx].tag = '0;
                    nxt_frame_right[snoopidx].valid = 0;
                    nxt_frame_right[snoopidx].dirty = 0;
                    nxt_frame_right[snoopidx].data[0] = '0;
                    nxt_frame_right[snoopidx].data[1] = '0;
                end
            end
            else if (cif.ccwait && snooptag == frame_left[snoopidx].tag)begin
                if (cif.ccinv && !frame_left[snoopidx].dirty)begin
                    nxt_frame_left[snoopidx].tag = '0;
                    nxt_frame_left[snoopidx].valid = 0;
                    nxt_frame_left[snoopidx].dirty = 0;
                    nxt_frame_left[snoopidx].data[0] = '0;
                    nxt_frame_left[snoopidx].data[1] = '0;
                end
            end
        end

        SNPSHR0:begin
            if (snooptag == frame_left[snoopidx].tag)begin
                cif.dstore = frame_left[snoopidx].data[0];
                cif.daddr = {frame_left[snoopidx].tag, snoopidx,1'b0,2'b00};
                // nxt_frame_left[snoopidx].dirty = 0;
            end
            else if (snooptag == frame_right[snoopidx].tag)begin
                cif.dstore = frame_right[snoopidx].data[0];
                cif.daddr = {frame_right[snoopidx].tag, snoopidx,1'b0,2'b00};
                // nxt_frame_right[snoopidx].dirty = 0;
            end
        end

        SNPSHR1:begin
            if (snooptag == frame_left[snoopidx].tag)begin
                cif.dstore = frame_left[snoopidx].data[1];
                cif.daddr = {frame_left[snoopidx].tag, snoopidx,1'b0,2'b00};
                nxt_frame_left[snoopidx].dirty = 0;
                if (~cif.dwait && cif.ccinv)begin
                    nxt_frame_left[snoopidx].tag = '0;
                    nxt_frame_left[snoopidx].valid = 0;
                    nxt_frame_left[snoopidx].dirty = 0;
                    nxt_frame_left[snoopidx].data[0] = '0;
                    nxt_frame_left[snoopidx].data[1] = '0;
                end
            end
            else if (snooptag == frame_right[snoopidx].tag)begin
                cif.dstore = frame_right[snoopidx].data[1];
                cif.daddr = {frame_right[snoopidx].tag, snoopidx,1'b0,2'b00};
                nxt_frame_right[snoopidx].dirty = 0;
                if (~cif.dwait && cif.ccinv)begin
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

always_ff @( posedge CLK, negedge nRST ) begin : vars_latch
    if(!nRST) begin
        state       <= IDLE;
        hit_count   <= '0;
        miss        <= '0;
        row_count   <= '0;
        LRU         <= '0;
        for(int i=0; i<8; i++) begin
            frame_left[i] <= '0;
            frame_right[i] <= '0;
        end
        linkreg <= '0;
        linkval <= 0;
        dcif_halt <= '0;
    end
    else begin
        state       <= nxt_state;
        hit_count   <= nxt_hit_count;
        miss        <= nxt_miss;
        row_count   <= nxt_row_count;
        LRU         <= nxt_LRU;
        frame_left  <= nxt_frame_left;
        frame_right <= nxt_frame_right;
        linkreg     <= nxt_linkreg;
        linkval     <= nxt_linkval;
        dcif_halt <= nxt_dcif_halt;
    end
end
endmodule