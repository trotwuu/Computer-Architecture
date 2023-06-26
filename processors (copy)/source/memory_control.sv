/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

  typedef enum logic [3:0] {  IDLE,
                              ICONET,
                              WMEM0, WMEM1,  
                              ARBITR, SNOP, LDC0, LDC1, LMEM0, LMEM1 } stateType;
  stateType state, nxt_state;

  logic icache_now, nxt_icache;
  logic requestor, nxt_requestor, responder, nxt_responder;

  always_comb begin : nxt_state_logic;
    nxt_state = state;
    nxt_icache = icache_now;
    nxt_requestor = requestor;
    nxt_responder = responder;
    
    case (state)
      IDLE: begin
        if(|ccif.dWEN) begin
          nxt_state = WMEM0;
        end
        else if(|ccif.dREN) begin
          nxt_state = ARBITR;
        end
        else if(|ccif.iREN) begin
          nxt_state = ICONET;
        end
      end

      ICONET: begin                 // decide which icache to use in output logic
        if(ccif.ramstate == ACCESS) begin
          nxt_state = IDLE; //
          nxt_icache = ~icache_now;
        end
        // if(ccif.dWEN) begin
        //   nxt_state = WMEM0;
        // end
      end

      WMEM0: begin
        if(ccif.ramstate == ACCESS) begin
          nxt_state = WMEM1;
        end
      end

      WMEM1: begin
        if(ccif.ramstate == ACCESS) begin
          nxt_state = IDLE;         
        end
      end

      ARBITR: begin
        if(ccif.dREN[0]) begin
          nxt_requestor = 0;
          nxt_responder = 1;
          nxt_state = SNOP;
        end
        else if(ccif.dREN[1]) begin
          nxt_requestor = 1;
          nxt_responder = 0;
          nxt_state = SNOP;
        end
        // else begin
        //   nxt_state = IDLE;                      // or arbtir
        // end
      end

      SNOP: begin
        nxt_state = ccif.cctrans[responder] ? LDC0 : LMEM0; //get from cache if reponder is dirty
      end

      LMEM0: begin
        if(ccif.ramstate == ACCESS) begin
          nxt_state = LMEM1;
        end
      end

      LMEM1: begin
        if(ccif.ramstate == ACCESS) begin
          nxt_state = IDLE;
        end
      end

      LDC0: begin
        if(ccif.ramstate == ACCESS) begin
          nxt_state = LDC1;
        end
      end

      LDC1: begin
        if(ccif.ramstate == ACCESS) begin
          nxt_state = IDLE;
        end
      end

      endcase
  end

  // output logic starts here
  always_comb begin : output_logic
  ccif.iwait        = '1;
  ccif.dwait        = '1;
  ccif.iload        = '0;
  ccif.dload        = '0;
  ccif.ramstore     = '0;
  ccif.ramaddr      = '0;
  ccif.ramWEN       = '0;
  ccif.ramREN       = '0;
  ccif.ccwait       = '0;
  ccif.ccsnoopaddr  = '0;
  ccif.ccinv[0] = ccif.ccwrite[1];
  ccif.ccinv[1] = ccif.ccwrite[0];
  
  case (state)
    IDLE: begin
      //do nothing
    end

    ICONET: begin
      if (ccif.iREN[0] && ccif.iREN[1]) begin
        ccif.ramREN   = ccif.iREN[icache_now];
        ccif.ramaddr  = ccif.iaddr[icache_now];
        ccif.iwait[icache_now] = (ccif.ramstate == ACCESS) ? 0 : 1;  // when ACCESS means data is ready, so let iwait = 0
        ccif.iload[icache_now] = ccif.ramload;
      end
      else if(ccif.iREN[0]) begin
        ccif.ramREN   = ccif.iREN[0];
        ccif.ramaddr  = ccif.iaddr[0];
        ccif.iwait[0] = (ccif.ramstate == ACCESS) ? 0 : 1;  // when ACCESS means data is ready, so let iwait = 0
        ccif.iload[0] = ccif.ramload;
      end
      else if (ccif.iREN[1]) begin
        ccif.ramREN   = ccif.iREN[1];
        ccif.ramaddr  = ccif.iaddr[1];
        ccif.iwait[1] = (ccif.ramstate == ACCESS) ? 0 : 1;  // when ACCESS means data is ready, so let iwait = 0
        ccif.iload[1] = ccif.ramload;
      end
    end

    WMEM0: begin
      if(ccif.dWEN[0]) begin
        ccif.ramWEN     = 1;
        ccif.ramaddr    = ccif.daddr[0];
        ccif.ramstore   = ccif.dstore[0];
        ccif.dwait[0]   = (ccif.ramstate == ACCESS) ? 0 : 1;
        // ccif.ccwait[1]  = 1;
      end
      else if(ccif.dWEN[1]) begin
        ccif.ramWEN     = 1;
        ccif.ramaddr    = ccif.daddr[1];
        ccif.ramstore   = ccif.dstore[1];
        ccif.dwait[1]   = (ccif.ramstate == ACCESS) ? 0 : 1;
        // ccif.ccwait[0]  = 1;                                      // check
      end
    end

    WMEM1: begin
      if(ccif.dWEN[0]) begin
        ccif.ramWEN     = 1;
        ccif.ramaddr    = ccif.daddr[0];
        ccif.ramstore   = ccif.dstore[0];
        ccif.dwait[0]   = (ccif.ramstate == ACCESS) ? 0 : 1;
        // ccif.ccwait[1]  = 1;
      end
      else if(ccif.dWEN[1]) begin
        ccif.ramWEN     = 1;
        ccif.ramaddr    = ccif.daddr[1];
        ccif.ramstore   = ccif.dstore[1];
        ccif.dwait[1]   = (ccif.ramstate == ACCESS) ? 0 : 1;
        // ccif.ccwait[0]  = 1;                                      // check
      end
    end

    ARBITR: begin
      ccif.ccwait[nxt_responder] = 1;
      ccif.ccsnoopaddr[nxt_responder] = ccif.daddr[requestor];
    end

    SNOP: begin
      ccif.ccwait[responder] = 0;
      ccif.ccsnoopaddr[responder] = ccif.daddr[requestor];
    end

    LDC0: begin
      ccif.dwait = (ccif.ramstate == ACCESS) ? 2'b0 : 2'b11;    // let requestor go from rmem0 to rmem1 and responder from snopshare0 to snopshare1
      ccif.dload[requestor] = ccif.dstore[responder];
      
      ccif.ramstore = ccif.dstore[responder];
      ccif.ramaddr = ccif.daddr[responder];
      ccif.ramWEN = 1;

      ccif.ccsnoopaddr[responder] = ccif.daddr[requestor];      // pass the address into responder
      // ccif.ccwait[responder] = 1;                               // don't let datapath input signals to cache on the responder side

    end

    LDC1: begin
      ccif.dwait = (ccif.ramstate == ACCESS) ? 2'b0 : 2'b11;    // let requestor go from rmem1 to idle and responder from snopshare1 to idle
      ccif.dload[requestor] = ccif.dstore[responder];
      
      ccif.ramstore = ccif.dstore[responder];
      ccif.ramaddr = ccif.daddr[responder];
      ccif.ramWEN = 1;

      ccif.ccsnoopaddr[responder] = ccif.daddr[requestor];      // pass the address into responder
      // ccif.ccwait[responder] = 1;                               // don't let datapath input signals to cache on the responder side
    end

    LMEM0: begin
      ccif.ramaddr = ccif.daddr[requestor];
      ccif.dwait[requestor] = ~(ccif.ramstate == ACCESS);
      ccif.dload[requestor] = ccif.ramload;
      ccif.ramREN = 1;

      // ccif.ccwait[responder] = 1;
      ccif.ccsnoopaddr[responder] = ccif.daddr[requestor];
    end
    
    LMEM1: begin
      ccif.ramaddr = ccif.daddr[requestor];
      ccif.dwait[requestor] = ~(ccif.ramstate == ACCESS);
      ccif.dload[requestor] = ccif.ramload;
      ccif.ramREN = 1;

      // ccif.ccwait[responder] = 1;
      ccif.ccsnoopaddr[responder] = ccif.daddr[requestor];
    end
    endcase
  end

  always_ff @(posedge CLK, negedge nRST) begin
    if(~nRST) begin
      state <= IDLE;
      icache_now <= 0;
      requestor <= 0;
      responder <= 0;
    end
    else begin
      state <= nxt_state;
      icache_now <= nxt_icache;
      requestor <= nxt_requestor;
      responder <= nxt_responder;

    end
  end

  endmodule
  

  // //TO RAM
  // assign ccif.ramstore = ccif.dWEN ? ccif.dstore: 0;
	// always_comb begin
	// 		ccif.ramWEN = 0;
	// 		ccif.ramREN = 0;
	// 	if (ccif.dWEN)begin
	// 		ccif.ramWEN = 1;
	// 		ccif.ramREN = 0;
	// 	end
	// 	else if(ccif.dREN)begin
	// 		ccif.ramWEN = 0;
	// 		ccif.ramREN = 1;
	// 	end
	// 	else if(ccif.iREN)begin
	// 		ccif.ramWEN = 0;
	// 		ccif.ramREN = 1;
	// 	end
	// end

  // assign ccif.ramaddr = (ccif.dWEN || ccif.dREN) ? ccif.daddr : ccif.iaddr;

  // //TO CACHE
  // assign ccif.dwait = ((ccif.ramstate == ACCESS) && (ccif.dREN || ccif.dWEN)) ? 0 : 1; 
  // assign ccif.dload = ccif.ramload;
  // assign ccif.iwait = ((ccif.ramstate == ACCESS) && (!(ccif.dREN || ccif.dWEN)) && ccif.iREN) ? 0 : 1;
  // assign ccif.iload = (ccif.iREN) ? ccif.ramload : 0;