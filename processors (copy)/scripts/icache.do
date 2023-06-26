onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate -radix decimal /icache_tb/PROG/tb_test_num
add wave -noupdate /icache_tb/PROG/tb_index
add wave -noupdate /icache_tb/PROG/tb_tag
add wave -noupdate /icache_tb/DUT/state
add wave -noupdate /icache_tb/DUT/nxt_state
add wave -noupdate -expand -group DCIF -color Cyan /icache_tb/dcif/imemREN
add wave -noupdate -expand -group DCIF -color Cyan /icache_tb/dcif/imemaddr
add wave -noupdate -expand -group DCIF -color Cyan /icache_tb/dcif/ihit
add wave -noupdate -expand -group DCIF -color Cyan /icache_tb/dcif/imemload
add wave -noupdate -expand -group CIF -color Gold /icache_tb/cif/iwait
add wave -noupdate -expand -group CIF -color Gold /icache_tb/cif/iload
add wave -noupdate -expand -group CIF -color Gold /icache_tb/cif/iaddr
add wave -noupdate -expand -group CIF -color Gold /icache_tb/cif/iREN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {612 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {516 ns} {1128 ns}
