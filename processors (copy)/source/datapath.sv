/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "request_unit_if.vh"
`include "alu_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "forward_unit_if.vh"
`include "hazard_unit_if.vh"


`include "if_id_if.vh"
`include "id_ex_if.vh"
`include "ex_mem_if.vh"
`include "mem_wb_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dcif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  //INTERFACE
  control_unit_if   cuif();
  alu_if            aluif();
  register_file_if  rfif();
  request_unit_if   rqif();
  if_id_if		      ifidif();
	id_ex_if		      idexif();
	ex_mem_if	        exmemif();
	mem_wb_if	       	memwbif();
  forward_unit_if   fuif();
  hazard_unit_if    huif();
  
  //COMPONENT
  hazard_unit       HU(huif);
  forward_unit_haha FOEU(fuif);
  control_unit      CTRL(cuif);
  alu               ALU(aluif);
  register_file     RF(CLK, nRST, rfif);
  request_unit      RQ(CLK, nRST, rqif);
  if_id 		        II(CLK, nRST, ifidif);
	id_ex 		        IE(CLK, nRST, idexif);
	ex_mem 		        EM(CLK, nRST, exmemif);
	mem_wb 		        MW(CLK, nRST, memwbif);
  
  // **********************************************************************
  // PC logic
  // **********************************************************************
  logic pc_en, branch_taken;
  logic [2:0] pcsrc;
  word_t pc, nxt_pc, pc_p4, jump_pc;

  always_comb begin
    
    pc_p4   = pc + 4;
    pcsrc  = {branch_taken, exmemif.jump_o};
    jump_pc = {pc_p4[31:28], exmemif.jump_addr_o[25:0], 2'b0};
    nxt_pc  = pc_p4;

    case(pcsrc)
      3'b001: nxt_pc = exmemif.rdat1_o;
      3'b010: nxt_pc = jump_pc;
      3'b000: nxt_pc = pc_p4;
      3'b100: nxt_pc = exmemif.branch_addr_o;
      //default: nxt_pc = pc_p4;
    endcase

    // Program Counter Latch
    if((dcif.ihit || huif.pc_en_bj) && huif.pc_freeze != 1)
        pc_en = 1;
    else
        pc_en = 0;
  end

  always_ff @( posedge CLK, negedge nRST ) begin
    if(!nRST) begin
      pc <= PC_INIT;
    end
    else if(pc_en == 1) begin
      pc <= nxt_pc;

    end
  end

  // **********************************************************************
  // Control Unit
  // **********************************************************************
  assign cuif.instr = ifidif.imem_load_o;

  // **********************************************************************
  // Register File 
  // **********************************************************************
  word_t write_data;
  assign rfif.WEN   = memwbif.regWr_o;
  assign rfif.rsel1 = ifidif.imem_load_o[25:21];
  assign rfif.rsel2 = ifidif.imem_load_o[20:16];
  assign rfif.wsel  = memwbif.wsel_o;
  assign rfif.wdat  = write_data;

  // **********************************************************************
  // Sign Extender and Load Upper Imm
  // **********************************************************************
  word_t signout, up_imm;
  always_comb begin
    if(cuif.extend)
      signout = 32'($signed(ifidif.imem_load_o[15:0]));
    //else if(cuif.extend == 0)
    else
      signout = {16'h0, ifidif.imem_load_o[15:0]};
  end

  assign up_imm = {ifidif.imem_load_o[15:0], 16'h0};

  // **********************************************************************
  // Branch Adder related
  // **********************************************************************
  // Branch address
  word_t branch_addr;
  assign branch_addr = idexif.pc_p4_o + (idexif.signout_o << 2);

  // Branch taken?
  assign branch_taken = exmemif.branch_o && (exmemif.bne_o?~exmemif.zero_o:exmemif.zero_o);

  // **********************************************************************
  // ALU related
  // **********************************************************************
  // assign aluif.port_a = idexif.rdat1_o;
  // assign aluif.port_b = idexif.alu_src_o ? idexif.signout_o : idexif.rdat2_o;
  assign aluif.aluop = idexif.aluop_o;

  // **********************************************************************
  // Register Destinaiton
  // **********************************************************************
  regbits_t wsel;
  always_comb begin
    case (idexif.reg_dst_o)
      2'b00: wsel = idexif.rd_o;
      2'b01: wsel = idexif.rt_o;
      2'b11: wsel = 5'd31;
      // default: wsel = idexif.rt_o;
      default: wsel = '0;
    endcase
  end

  // **********************************************************************
  // Memory Signals Connection
  // **********************************************************************
  assign dcif.imemREN   = 1;
  assign dcif.imemaddr  = pc;
  assign dcif.dmemaddr  = exmemif.alu_out_o;
  assign dcif.dmemstore = exmemif.rdat2_o;
  assign dcif.dmemREN   = exmemif.mem_read_o;
  assign dcif.dmemWEN   = exmemif.mem_write_o; 

  // **********************************************************************
  // Memory to Register Logic
  // **********************************************************************
  always_comb begin
    case(memwbif.mem_to_reg_o)
      2'b00: write_data = memwbif.alu_out_o;
      2'b01: write_data = memwbif.dmem_load_o;
      2'b10: write_data = memwbif.pc_p4_o;
      2'b11: write_data = memwbif.up_imm_o;
    endcase
  end

  // **********************************************************************
  // Forward_unit
  // **********************************************************************
  always_comb begin
  aluif.port_a = 0;
    casez (fuif.fward_a)
      2'b00: aluif.port_a = idexif.rdat1_o;
      2'b01: begin
        casez (memwbif.mem_to_reg_o)
          2'b00: aluif.port_a = memwbif.alu_out_o;
          2'b01: aluif.port_a = memwbif.dmem_load_o;
          2'b10: aluif.port_a = memwbif.pc_p4_o;
          2'b11: aluif.port_a = memwbif.up_imm_o;
        endcase
      end
      2'b10: begin
        casez (exmemif.mem_to_reg_o)
          2'b00: aluif.port_a = exmemif.alu_out_o;
          2'b01: aluif.port_a = dcif.dmemload;
          2'b10: aluif.port_a = exmemif.pc_p4_o;
          2'b11: aluif.port_a = exmemif.up_imm_o;
        endcase
      end
      // aluif.port_a = (memwbif.mem_to_reg_o == 2'b01)? memwbif.dmem_load_o: memwbif.alu_out_o;
      // 2'b10: aluif.port_a = (exmemif.mem_to_reg_o == 2'b01)? dcif.dmemload : exmemif.alu_out_o;
    endcase
  end

  always_comb begin
    aluif.port_b = '0;
    if (idexif.alu_src_o) begin
      aluif.port_b = idexif.signout_o;
    end 
    else begin
      casez (fuif.fward_b)
      2'b00: aluif.port_b = idexif.rdat2_o;
      2'b01: begin
        casez (memwbif.mem_to_reg_o)
          2'b00: aluif.port_b = memwbif.alu_out_o;
          2'b01: aluif.port_b = memwbif.dmem_load_o;
          2'b10: aluif.port_b = memwbif.pc_p4_o;
          2'b11: aluif.port_b = memwbif.up_imm_o;
        endcase
      end
      2'b10: begin
        casez (exmemif.mem_to_reg_o)
          2'b00: aluif.port_b = exmemif.alu_out_o;
          2'b01: aluif.port_b = dcif.dmemload;
          2'b10: aluif.port_b = exmemif.pc_p4_o;
          2'b11: aluif.port_b = exmemif.up_imm_o;
        endcase
      end
    endcase
      // casez (fuif.fward_b)
      //   2'b00: aluif.port_b = idexif.rdat2_o;
      //   2'b01: aluif.port_b = (memwbif.mem_to_reg_o == 2'b01)? memwbif.dmem_load_o: memwbif.alu_out_o;
      //   2'b10: aluif.port_b = (exmemif.mem_to_reg_o == 2'b01)? dcif.dmemload : exmemif.alu_out_o;
      // endcase
    end
  end

  always_comb begin
    exmemif.rdat2_i = idexif.rdat2_o;
    casez (fuif.fward_b)
      2'b00: exmemif.rdat2_i = idexif.rdat2_o;
      2'b01: begin
        casez (memwbif.mem_to_reg_o)
          2'b00: exmemif.rdat2_i = memwbif.alu_out_o;
          2'b01: exmemif.rdat2_i = memwbif.dmem_load_o;
          2'b10: exmemif.rdat2_i = memwbif.pc_p4_o;
          2'b11: exmemif.rdat2_i = memwbif.up_imm_o;
        endcase
      end
      2'b10: begin
        casez (exmemif.mem_to_reg_o)
          2'b00: exmemif.rdat2_i = exmemif.alu_out_o;
          2'b01: exmemif.rdat2_i = dcif.dmemload;
          2'b10: exmemif.rdat2_i = exmemif.pc_p4_o;
          2'b11: exmemif.rdat2_i = exmemif.up_imm_o;
        endcase
      end
    endcase
  end

  // **********************************************************************
  // Datomic 
  // **********************************************************************
  assign dcif.datomic = exmemif.datomic_o;

  // **********************************************************************
  // 
  // All Latches connections, Forwarding and Hazard Unit are below
  // 
  // **********************************************************************

  // **********************************************************************
  // Hazard Unit
  // **********************************************************************
  assign huif.idex_rt = idexif.rt_o;
  assign huif.ifid_instr   = ifidif.imem_load_o;
  assign huif.dcif_dhit   = dcif.dhit;
  assign huif.pcsrc = pcsrc;
  assign huif.idex_regWr = idexif.regWr_o;
  assign huif.exmem_memrw = (exmemif.mem_read_o || exmemif.mem_write_o);
  assign huif.idex_halt = idexif.halt_o;

  // **********************************************************************
  // Forwarding Unit
  // **********************************************************************
  assign fuif.idex_rs = idexif.rs_o;
  assign fuif.idex_rt = idexif.rt_o;
  assign fuif.exmem_wsel = exmemif.wsel_o;
  assign fuif.memwb_wsel = memwbif.wsel_o;
  //assign fuif.exmem_dmemren = exmemif.mem_to_reg_o;
  //assign fuif.exmem_dmemwen = exmemif.dWEN_o;
  assign fuif.exmem_regWr = exmemif.regWr_o;
  assign fuif.memwb_regWr = memwbif.regWr_o;

  // **********************************************************************
  // IF/ID
  // **********************************************************************
  always_comb begin
    ifidif.pc_p4_i      = pc_p4;
    ifidif.imem_load_i  = dcif.imemload;
    ifidif.ihit = dcif.ihit;
    ifidif.freeze = huif.ifid_freeze;
    ifidif.flush = huif.ifid_flush;

    // ****************
    // CPU tracker only
    // ****************
    ifidif.pc_i = pc;
    ifidif.nxt_pc_i = nxt_pc;
  end

  // **********************************************************************
  // ID/EX 
  // **********************************************************************
  always_comb begin
    // Control Unit signals
    idexif.regWr_i      = cuif.regWr;
    idexif.mem_to_reg_i = cuif.mem_to_reg;
    idexif.branch_i     = cuif.branch;
    idexif.mem_write_i  = cuif.mem_write;
    idexif.mem_read_i   = cuif.mem_read;
    idexif.jump_i       = cuif.jump;
    idexif.aluop_i      = cuif.aluop;
    idexif.reg_dst_i    = cuif.reg_dst;
    idexif.alu_src_i    = cuif.alu_src;
    idexif.bne_i        = cuif.bne;
    idexif.datomic_i    = cuif.datomic;
    idexif.halt_i       = cuif.halt;
    
    // Register File, Sign Extender, Load Upper Imm Signals
    idexif.rdat1_i      = rfif.rdat1;
    idexif.rdat2_i      = rfif.rdat2;
    idexif.signout_i    = signout;
    idexif.up_imm_i     = up_imm;

    // IF/ID Signals
    idexif.pc_p4_i      = ifidif.pc_p4_o;
    idexif.imem_load_i  = ifidif.imem_load_o; //pass instr
    idexif.jump_addr_i  = ifidif.imem_load_o[25:0];
    idexif.rd_i         = ifidif.imem_load_o[15:11];
    idexif.rt_i         = ifidif.imem_load_o[20:16];
    idexif.rs_i         = ifidif.imem_load_o[25:21];

    // DATAPATH Signals
    idexif.flush        = huif.idex_flush;
    idexif.en           = 1;
    idexif.freeze       = huif.idex_freeze;

    // ****************
    // CPU tracker only
    // ****************
    idexif.pc_i      = ifidif.pc_o;
    idexif.nxt_pc_i  = ifidif.nxt_pc_o;
    idexif.instr_i   = ifidif.imem_load_o;
    idexif.up_imm_i  = up_imm;
    idexif.funct_i   = funct_t'(ifidif.imem_load_o[5:0]);
    idexif.opcode_i  = opcode_t'(ifidif.imem_load_o[31:26]);
    idexif.rs_i      = ifidif.imem_load_o[25:21];

  end

  // **********************************************************************
  // EX/MEM 
  // **********************************************************************
  always_comb begin
    // Control Unit signals
    exmemif.regWr_i      = idexif.regWr_o;
    exmemif.mem_to_reg_i = idexif.mem_to_reg_o;
    exmemif.branch_i     = idexif.branch_o;
    exmemif.jump_i       = idexif.jump_o;
    exmemif.bne_i        = idexif.bne_o;
    exmemif.datomic_i    = idexif.datomic_o;
    exmemif.halt_i       = idexif.halt_o;
    
    //Adder, ALU, Wsel MUX Signals
    exmemif.branch_addr_i = branch_addr;
    exmemif.alu_out_i     = aluif.outport;
    exmemif.zero_i        = aluif.zero;
    exmemif.wsel_i        = wsel;

    // ID/EX Signals
    exmemif.rdat1_i      = idexif.rdat1_o;
    // exmemif.rdat2_i      = idexif.rdat2_o; //add forward logic
    exmemif.pc_p4_i      = idexif.pc_p4_o;
    exmemif.up_imm_i     = idexif.up_imm_o;
    exmemif.imem_load_i  = idexif.imem_load_o; //pass instr
    exmemif.jump_addr_i  = idexif.jump_addr_o;
    exmemif.mem_read_i   = idexif.mem_read_o;
    exmemif.mem_write_i  = idexif.mem_write_o;

    // DATAPATH Signals
    exmemif.flush        = huif.exmem_flush;
    exmemif.en           = 1;
    exmemif.freeze       = huif.exmem_freeze;

    // ****************
    // CPU tracker only
    // ****************
    exmemif.pc_i      = idexif.pc_o;
    exmemif.nxt_pc_i  = idexif.nxt_pc_o;
    exmemif.instr_i   = idexif.instr_o;
    exmemif.up_imm_i  = idexif.up_imm_o;
    exmemif.funct_i   = funct_t'(idexif.instr_o[5:0]);
    exmemif.opcode_i  = opcode_t'(idexif.instr_o[31:26]);
    exmemif.rs_i      = idexif.rs_o;
	  exmemif.rt_i      = idexif.rt_o;
  end
  // **********************************************************************
  // MEM/WB
  // **********************************************************************
  always_comb begin
    // Control Unit signals
    memwbif.regWr_i      = exmemif.regWr_o;
    memwbif.mem_to_reg_i = exmemif.mem_to_reg_o;
    memwbif.halt_i       = exmemif.halt_o;
    
    // Memory Signals
    memwbif.dmem_load_i  = dcif.dmemload;

    // EX//MEM Signals
    memwbif.alu_out_i    = exmemif.alu_out_o;
    memwbif.pc_p4_i      = exmemif.pc_p4_o;
    memwbif.up_imm_i     = exmemif.up_imm_o;
    memwbif.imem_load_i  = exmemif.imem_load_o; //pass instr
    memwbif.wsel_i       = exmemif.wsel_o;

    // DATAPATH Signals
    memwbif.flush        = huif.memwb_flush;
    memwbif.en           = 1;
    memwbif.freeze       = huif.memwb_freeze;

    // ****************
    // CPU tracker only
    // ****************
    memwbif.pc_i      = exmemif.pc_o;
    memwbif.nxt_pc_i  = exmemif.nxt_pc_o;
    memwbif.instr_i   = exmemif.instr_o;
    memwbif.up_imm_i  = exmemif.up_imm_o;
    memwbif.funct_i   = funct_t'(exmemif.instr_o[5:0]);
    memwbif.opcode_i  = opcode_t'(exmemif.instr_o[31:26]);
    memwbif.rs_i      = exmemif.rs_o;
	  memwbif.rt_i      = exmemif.rt_o;
    memwbif.branch_addr_i = exmemif.branch_addr_o;
    memwbif.rdat2_i = exmemif.rdat2_o;
  end
  /*
  //REGISTER FILE
  always_comb begin
    rfif.WEN = 0;
    rfif.wsel = '0;
    rfif.rsel1 =  dcif.imemload[25:21];
    rfif.rsel2 =  dcif.imemload[20:16];
    rfif.wdat = '0;
    if(cuif.regWr && (dcif.dhit| dcif.ihit))
      rfif.WEN = cuif.regWr;
    else
      rfif.WEN = 0;
    case(cuif.reg_dst)
      2'b00: rfif.wsel =  dcif.imemload[15:11];
      2'b01: rfif.wsel =  dcif.imemload[20:16];
      2'b11: rfif.wsel = 31;
    endcase

    case(cuif.write_data)
      2'b00: rfif.wdat = aluif.outport;
      2'b01: rfif.wdat = dcif.dmem_load;
      2'b10: rfif.wdat = pc_p4;
      2'b11: rfif.wdat = { dcif.imemload[15:0], 16'h0000};//LUI
    endcase
  end

  //ALU 
  always_comb begin
    aluif.port_a = rfif.rdat1;
    aluif.port_b = rfif.rdat2;
    aluif.aluop = cuif.aluop;
    if(cuif.alu_src == 1)begin
      if(cuif.extend)
        aluif.port_b = 32'(signed'( dcif.imemload[15:0]));
      else
        aluif.port_b = {16'h0000,  dcif.imemload[15:0]};
    end
    cuif.zero = aluif.zero;
  end

  //REQUEST & MEMORY 
  always_comb begin
    rqif.ihit = dcif.ihit;
    rqif.dhit = dcif.dhit;
    rqif.mem_write = cuif.mem_write;
    rqif.mem_read = cuif.mem_read;
    dcif.dmemREN = rqif.dmemREN;
    dcif.imemREN = rqif.imemREN;
    dcif.dmemWEN = rqif.dmemWEN;
    dcif.dmemaddr = aluif.outport;
    dcif.dmemstore = rfif.rdat2;
    dcif.imemaddr = pc;
    cuif.instr = dcif.imemload;
  end*/

  //HALT
  always_ff @( posedge CLK, negedge nRST ) begin : Halting
    if(nRST == 0)
      dcif.halt = 0;
    else
      dcif.halt <= memwbif.halt_o;
  end

endmodule

