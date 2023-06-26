onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_control_tb/PROG/CLK
add wave -noupdate /memory_control_tb/PROG/nRST
add wave -noupdate /memory_control_tb/PROG/#ublk#502948#78/test_name
add wave -noupdate -radix unsigned /memory_control_tb/PROG/#ublk#502948#78/test_num
add wave -noupdate -expand -group {Bus Control} /memory_control_tb/DUT/state
add wave -noupdate -expand -group {Bus Control} /memory_control_tb/DUT/icache_now
add wave -noupdate -expand -group {Bus Control} /memory_control_tb/DUT/requestor
add wave -noupdate -expand -group {Bus Control} /memory_control_tb/DUT/responder
add wave -noupdate -expand -group {Bus Control} -expand -group {nxt signals} /memory_control_tb/DUT/nxt_icache
add wave -noupdate -expand -group {Bus Control} -expand -group {nxt signals} /memory_control_tb/DUT/nxt_requestor
add wave -noupdate -expand -group {Bus Control} -expand -group {nxt signals} /memory_control_tb/DUT/nxt_responder
add wave -noupdate -expand -group {Bus Control} -expand -group {nxt signals} /memory_control_tb/DUT/nxt_state
add wave -noupdate -expand -group RAM /memory_control_tb/DUT/ccif/ramaddr
add wave -noupdate -expand -group RAM /memory_control_tb/DUT/ccif/ramload
add wave -noupdate -expand -group RAM /memory_control_tb/DUT/ccif/ramREN
add wave -noupdate -expand -group RAM /memory_control_tb/DUT/ccif/ramstate
add wave -noupdate -expand -group RAM /memory_control_tb/DUT/ccif/ramstore
add wave -noupdate -expand -group RAM /memory_control_tb/DUT/ccif/ramWEN
add wave -noupdate -expand -group CIF0 /memory_control_tb/cif0/ccinv
add wave -noupdate -expand -group CIF0 /memory_control_tb/cif0/ccsnoopaddr
add wave -noupdate -expand -group CIF0 /memory_control_tb/cif0/cctrans
add wave -noupdate -expand -group CIF0 /memory_control_tb/cif0/ccwait
add wave -noupdate -expand -group CIF0 /memory_control_tb/cif0/ccwrite
add wave -noupdate -expand -group CIF0 -expand -group Dcache /memory_control_tb/cif0/dWEN
add wave -noupdate -expand -group CIF0 -expand -group Dcache /memory_control_tb/cif0/dREN
add wave -noupdate -expand -group CIF0 -expand -group Dcache /memory_control_tb/cif0/daddr
add wave -noupdate -expand -group CIF0 -expand -group Dcache /memory_control_tb/cif0/dload
add wave -noupdate -expand -group CIF0 -expand -group Dcache /memory_control_tb/cif0/dstore
add wave -noupdate -expand -group CIF0 -expand -group Dcache /memory_control_tb/cif0/dwait
add wave -noupdate -expand -group CIF0 -expand -group Icache /memory_control_tb/cif0/iaddr
add wave -noupdate -expand -group CIF0 -expand -group Icache /memory_control_tb/cif0/iload
add wave -noupdate -expand -group CIF0 -expand -group Icache /memory_control_tb/cif0/iREN
add wave -noupdate -expand -group CIF0 -expand -group Icache /memory_control_tb/cif0/iwait
add wave -noupdate -group CIF1 /memory_control_tb/cif1/ccinv
add wave -noupdate -group CIF1 /memory_control_tb/cif1/ccsnoopaddr
add wave -noupdate -group CIF1 /memory_control_tb/cif1/cctrans
add wave -noupdate -group CIF1 /memory_control_tb/cif1/ccwait
add wave -noupdate -group CIF1 /memory_control_tb/cif1/ccwrite
add wave -noupdate -group CIF1 -expand -group Dcache /memory_control_tb/cif1/dREN
add wave -noupdate -group CIF1 -expand -group Dcache /memory_control_tb/cif1/dWEN
add wave -noupdate -group CIF1 -expand -group Dcache /memory_control_tb/cif1/daddr
add wave -noupdate -group CIF1 -expand -group Dcache /memory_control_tb/cif1/dload
add wave -noupdate -group CIF1 -expand -group Dcache /memory_control_tb/cif1/dstore
add wave -noupdate -group CIF1 -expand -group Dcache /memory_control_tb/cif1/dwait
add wave -noupdate -group CIF1 -expand -group Icache /memory_control_tb/cif1/iREN
add wave -noupdate -group CIF1 -expand -group Icache /memory_control_tb/cif1/iaddr
add wave -noupdate -group CIF1 -expand -group Icache /memory_control_tb/cif1/iload
add wave -noupdate -group CIF1 -expand -group Icache /memory_control_tb/cif1/iwait
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {95000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 154
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
WaveRestoreZoom {0 ps} {247 ns}
