`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"
import cpu_types_pkg::*;

module icache(
  input logic CLK, nRST,
  datapath_cache_if.icache dcif,
  caches_if.icache cif
);
  typedef enum logic {IDLE, LOAD} states;
  states state, nxt_state;
  icachef_t imemaddr;
  icache_frame [15:0] frames, nxt_frames;

  assign imemaddr = icachef_t'(dcif.imemaddr);

  always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST)begin
      state <= IDLE;
      frames <= '0;
    end else begin
      state <= nxt_state;
      frames[imemaddr.idx].data <= nxt_frames[imemaddr.idx].data;
      frames[imemaddr.idx].tag <= nxt_frames[imemaddr.idx].tag;
      frames[imemaddr.idx].valid <= nxt_frames[imemaddr.idx].valid;
    end
  end
  
  always_comb begin
    cif.iREN = 0;
    cif.iaddr = dcif.imemaddr;
    dcif.ihit = 0;
    dcif.imemload = '0;
    nxt_state = state;
    nxt_frames = frames;
    
    case(state)
      IDLE: begin
        if (dcif.imemREN && frames[imemaddr.idx].tag == imemaddr.tag && frames[imemaddr.idx].valid) begin
          dcif.ihit = 1;
          dcif.imemload = frames[imemaddr.idx].data;
        end
        else begin
          cif.iREN = 1;
          nxt_state = LOAD;
        end
      end
      LOAD: begin
        cif.iREN = 1;
        if (!cif.iwait) begin
          dcif.ihit = 1;
          dcif.imemload = cif.iload;
          nxt_state = IDLE;
          nxt_frames[imemaddr.idx].data = cif.iload;
          nxt_frames[imemaddr.idx].tag = imemaddr.tag;
          nxt_frames[imemaddr.idx].valid = 1;
        end  
      end
    endcase
  end
endmodule
