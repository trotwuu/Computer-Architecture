onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dhit
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemaddr
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemload
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemREN
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemstore
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemWEN
add wave -noupdate -expand -group CIF /dcache_tb/cif/daddr
add wave -noupdate -expand -group CIF /dcache_tb/cif/dload
add wave -noupdate -expand -group CIF /dcache_tb/cif/dREN
add wave -noupdate -expand -group CIF /dcache_tb/cif/dstore
add wave -noupdate -expand -group CIF /dcache_tb/cif/dwait
add wave -noupdate -expand -group CIF /dcache_tb/cif/dWEN
add wave -noupdate /dcache_tb/PROG/CLK
add wave -noupdate /dcache_tb/PROG/nRST
add wave -noupdate /dcache_tb/PROG/tb_test_case
add wave -noupdate /dcache_tb/PROG/testcase_num
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/cache_dhit
add wave -noupdate -expand -group DCACHE -radix binary /dcache_tb/DUT/row_count
add wave -noupdate -expand -group DCACHE -radix binary /dcache_tb/DUT/nxt_row_count
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/nxt_state
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/state
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/flag
add wave -noupdate -expand -group DCACHE -expand /dcache_tb/DUT/frame_left
add wave -noupdate -expand -group DCACHE -expand /dcache_tb/DUT/frame_right
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/hit_count
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/hit_left
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/hit_right
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/LRU
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/miss
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/nRST
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/nxt_frame_left
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/nxt_frame_right
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/nxt_hit_count
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/nxt_LRU
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/nxt_miss
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {312 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 228
configure wave -valuecolwidth 227
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
WaveRestoreZoom {191 ns} {383 ns}
