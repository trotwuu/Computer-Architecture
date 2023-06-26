onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPUCLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group Instr -expand -group Core0 -color Cyan -label IFID /system_tb/DUT/CPU/DP0/II/ifidif/imem_load_o
add wave -noupdate -expand -group Instr -expand -group Core0 -color Cyan -label IDEX /system_tb/DUT/CPU/DP0/IE/idexif/instr_o
add wave -noupdate -expand -group Instr -expand -group Core0 -color Cyan -label EXMEM /system_tb/DUT/CPU/DP0/EM/exmemif/instr_o
add wave -noupdate -expand -group Instr -expand -group Core0 -color Cyan -label MEMWB /system_tb/DUT/CPU/DP0/MW/memwbif/instr_o
add wave -noupdate -expand -group Instr -expand -group Core1 -color Cyan -label IFID /system_tb/DUT/CPU/DP1/ifidif/imem_load_o
add wave -noupdate -expand -group Instr -expand -group Core1 -color Cyan -label IDEX /system_tb/DUT/CPU/DP1/idexif/instr_o
add wave -noupdate -expand -group Instr -expand -group Core1 -color Cyan -label EXMEM /system_tb/DUT/CPU/DP1/exmemif/instr_o
add wave -noupdate -expand -group Instr -expand -group Core1 -color Cyan -label MEMWB /system_tb/DUT/CPU/DP1/memwbif/instr_o
add wave -noupdate -expand -group PC -label {DP0 nxt_pc} /system_tb/DUT/CPU/DP0/nxt_pc
add wave -noupdate -expand -group PC -label {DP0 pc} /system_tb/DUT/CPU/DP0/pc
add wave -noupdate -expand -group PC -label {DP1 nxt_pc} /system_tb/DUT/CPU/DP1/nxt_pc
add wave -noupdate -expand -group PC -label {DP1 pc} /system_tb/DUT/CPU/DP1/pc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/datomic
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/dhit
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/dmemaddr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/dmemload
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/dmemREN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/dmemstore
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/dmemWEN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/flushed
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/halt
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/ihit
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/imemaddr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/imemload
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dcif/imemREN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/datomic
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/dhit
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/dmemaddr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/dmemload
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/dmemREN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/dmemstore
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/dmemWEN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/flushed
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/halt
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/ihit
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/imemaddr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/imemload
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/dcif/imemREN
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/linkreg
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/linkval
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/nxt_linkreg
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/nxt_linkval
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -group CIF0 -expand -group Dcache -radix binary /system_tb/DUT/CPU/CM0/DCACHE/addr
add wave -noupdate -group CIF0 -expand -group Dcache -expand /system_tb/DUT/CPU/CM0/DCACHE/addr
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/cache_dhit
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/flag
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/frame_left
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/frame_right
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/hit_count
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/hit_left
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/hit_right
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/LRU
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/miss
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/nxt_frame_left
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/nxt_frame_right
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/nxt_hit_count
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/nxt_LRU
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/nxt_miss
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/nxt_row_count
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/nxt_state
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/row_count
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/snoopidx
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/snooptag
add wave -noupdate -group CIF0 -expand -group Dcache /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -group CIF0 -group Icache /system_tb/DUT/CPU/CM0/ICACHE/state
add wave -noupdate -group CIF0 -group Icache /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -group CIF0 -group Icache /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -group CIF0 -group Icache /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -group CIF0 -group Icache /system_tb/DUT/CPU/CM0/ICACHE/nxt_state
add wave -noupdate -group CIF0 -group Icache /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/linkreg
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/linkval
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/nxt_linkreg
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/nxt_linkval
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/ccinv
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/ccsnoopaddr
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/cctrans
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/ccwait
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/ccwrite
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/daddr
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/dload
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/dREN
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/dstore
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/dwait
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/cif1/dWEN
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/addr
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/cache_dhit
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/flag
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/frame_left
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/frame_right
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/hit_count
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/hit_left
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/hit_right
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/LRU
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/miss
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/nxt_frame_left
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/nxt_frame_right
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/nxt_hit_count
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/nxt_LRU
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/nxt_miss
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/nxt_row_count
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/nxt_state
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/row_count
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/snoopidx
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/snooptag
add wave -noupdate -group CIF1 -expand -group Dcache /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -group CIF1 -group Icache /system_tb/DUT/CPU/CM1/ICACHE/state
add wave -noupdate -group CIF1 -group Icache /system_tb/DUT/CPU/CM1/ICACHE/nxt_state
add wave -noupdate -group CIF1 -group Icache /system_tb/DUT/CPU/cif1/iaddr
add wave -noupdate -group CIF1 -group Icache /system_tb/DUT/CPU/cif1/iload
add wave -noupdate -group CIF1 -group Icache /system_tb/DUT/CPU/cif1/iREN
add wave -noupdate -group CIF1 -group Icache /system_tb/DUT/CPU/cif1/iwait
add wave -noupdate -group MC /system_tb/DUT/CPU/CC/CLK
add wave -noupdate -group MC /system_tb/DUT/CPU/CC/nxt_requestor
add wave -noupdate -group MC /system_tb/DUT/CPU/CC/nxt_responder
add wave -noupdate -group MC /system_tb/DUT/CPU/CC/nxt_state
add wave -noupdate -group MC /system_tb/DUT/CPU/CC/requestor
add wave -noupdate -group MC /system_tb/DUT/CPU/CC/responder
add wave -noupdate -group MC /system_tb/DUT/CPU/CC/state
add wave -noupdate -group RAM /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -group RAM /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -group RAM /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -group RAM /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group RAM /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -group RAM /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -group {Core0 IFID} /system_tb/DUT/CPU/DP0/II/ifidif/nxt_pc_o
add wave -noupdate -group {Core0 IFID} /system_tb/DUT/CPU/DP0/II/ifidif/flush
add wave -noupdate -group {Core0 IFID} /system_tb/DUT/CPU/DP0/II/ifidif/freeze
add wave -noupdate -group {Core0 IFID} /system_tb/DUT/CPU/DP0/II/ifidif/ihit
add wave -noupdate -group {Core0 IFID} /system_tb/DUT/CPU/DP0/II/ifidif/pc_o
add wave -noupdate -group {Core0 IFID} /system_tb/DUT/CPU/DP0/II/ifidif/pc_p4_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/alu_src_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/aluop_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/bne_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/branch_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/en
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/flush
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/freeze
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/funct_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/halt_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/imem_load_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/jump_addr_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/jump_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/mem_read_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/mem_to_reg_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/mem_write_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/nxt_pc_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/opcode_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/pc_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/pc_p4_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/rd_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/rdat1_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/rdat2_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/reg_dst_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/regWr_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/rs_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/rt_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/signout_o
add wave -noupdate -group {Core0 IDEX} /system_tb/DUT/CPU/DP0/IE/idexif/up_imm_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/alu_out_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/bne_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/branch_addr_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/branch_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/en
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/flush
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/freeze
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/funct_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/halt_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/imem_load_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/jump_addr_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/jump_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/mem_read_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/mem_to_reg_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/mem_write_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/nxt_pc_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/opcode_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/pc_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/pc_p4_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/rdat1_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/rdat2_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/regWr_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/rs_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/rt_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/up_imm_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/wsel_o
add wave -noupdate -group {Core0 EXMEM} /system_tb/DUT/CPU/DP0/EM/exmemif/zero_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/alu_out_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/branch_addr_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/dmem_load_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/en
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/flush
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/freeze
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/funct_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/halt_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/imem_load_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/mem_to_reg_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/nxt_pc_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/opcode_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/pc_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/pc_p4_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/rdat2_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/regWr_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/rs_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/rt_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/up_imm_o
add wave -noupdate -group {Core0 MEMWB} /system_tb/DUT/CPU/DP0/MW/memwbif/wsel_o
add wave -noupdate -group {Core1 IFID} /system_tb/DUT/CPU/DP1/ifidif/flush
add wave -noupdate -group {Core1 IFID} /system_tb/DUT/CPU/DP1/ifidif/freeze
add wave -noupdate -group {Core1 IFID} /system_tb/DUT/CPU/DP1/ifidif/ihit
add wave -noupdate -group {Core1 IFID} /system_tb/DUT/CPU/DP1/ifidif/nxt_pc_o
add wave -noupdate -group {Core1 IFID} /system_tb/DUT/CPU/DP1/ifidif/pc_o
add wave -noupdate -group {Core1 IFID} /system_tb/DUT/CPU/DP1/ifidif/pc_p4_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/alu_src_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/aluop_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/bne_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/branch_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/en
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/flush
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/freeze
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/funct_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/halt_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/imem_load_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/jump_addr_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/jump_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/mem_read_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/mem_to_reg_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/mem_write_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/nxt_pc_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/opcode_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/pc_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/pc_p4_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/rd_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/rdat1_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/rdat2_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/reg_dst_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/regWr_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/rs_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/rt_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/signout_o
add wave -noupdate -group {Core1 IDEX} /system_tb/DUT/CPU/DP1/idexif/up_imm_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/alu_out_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/bne_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/branch_addr_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/branch_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/en
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/flush
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/freeze
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/funct_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/halt_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/imem_load_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/jump_addr_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/jump_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/mem_read_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/mem_to_reg_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/mem_write_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/nxt_pc_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/opcode_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/pc_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/pc_p4_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/rdat1_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/rdat2_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/regWr_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/rs_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/rt_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/up_imm_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/wsel_o
add wave -noupdate -group {Core1 EXMEM} /system_tb/DUT/CPU/DP1/exmemif/zero_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/alu_out_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/branch_addr_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/dmem_load_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/en
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/flush
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/freeze
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/funct_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/halt_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/imem_load_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/mem_to_reg_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/nxt_pc_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/opcode_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/pc_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/pc_p4_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/rdat2_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/regWr_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/rs_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/rt_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/up_imm_o
add wave -noupdate -group {Core1 MEMWB} /system_tb/DUT/CPU/DP1/memwbif/wsel_o
add wave -noupdate -group {Core0 RFIF} /system_tb/DUT/CPU/DP0/rfif/rdat1
add wave -noupdate -group {Core0 RFIF} /system_tb/DUT/CPU/DP0/rfif/rdat2
add wave -noupdate -group {Core0 RFIF} /system_tb/DUT/CPU/DP0/rfif/rsel1
add wave -noupdate -group {Core0 RFIF} /system_tb/DUT/CPU/DP0/rfif/rsel2
add wave -noupdate -group {Core0 RFIF} /system_tb/DUT/CPU/DP0/rfif/wdat
add wave -noupdate -group {Core0 RFIF} /system_tb/DUT/CPU/DP0/rfif/WEN
add wave -noupdate -group {Core0 RFIF} /system_tb/DUT/CPU/DP0/rfif/wsel
add wave -noupdate -group {Core0 RFIF} /system_tb/DUT/CPU/DP0/RF/nxt_registers
add wave -noupdate -group {Core0 RFIF} /system_tb/DUT/CPU/DP0/RF/registers
add wave -noupdate -group {Core1 RFIF} /system_tb/DUT/CPU/DP1/rfif/rdat1
add wave -noupdate -group {Core1 RFIF} /system_tb/DUT/CPU/DP1/rfif/rdat2
add wave -noupdate -group {Core1 RFIF} /system_tb/DUT/CPU/DP1/rfif/rsel1
add wave -noupdate -group {Core1 RFIF} /system_tb/DUT/CPU/DP1/rfif/rsel2
add wave -noupdate -group {Core1 RFIF} /system_tb/DUT/CPU/DP1/rfif/wdat
add wave -noupdate -group {Core1 RFIF} /system_tb/DUT/CPU/DP1/rfif/WEN
add wave -noupdate -group {Core1 RFIF} /system_tb/DUT/CPU/DP1/rfif/wsel
add wave -noupdate -group {Core1 RFIF} /system_tb/DUT/CPU/DP1/RF/nxt_registers
add wave -noupdate -group {Core1 RFIF} /system_tb/DUT/CPU/DP1/RF/registers
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {749304 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 186
configure wave -valuecolwidth 267
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2659 ns}
