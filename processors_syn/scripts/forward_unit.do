onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /forward_unit_tb/CLK
add wave -noupdate -radix unsigned /forward_unit_tb/PROG/#ublk#502948#30/test_case_num
add wave -noupdate /forward_unit_tb/fuif/exmem_dmemren
add wave -noupdate /forward_unit_tb/fuif/exmem_dmemwen
add wave -noupdate /forward_unit_tb/fuif/exmem_regWr
add wave -noupdate /forward_unit_tb/fuif/exmem_wsel
add wave -noupdate /forward_unit_tb/fuif/idex_rs
add wave -noupdate /forward_unit_tb/fuif/idex_rt
add wave -noupdate /forward_unit_tb/fuif/memwb_regWr
add wave -noupdate /forward_unit_tb/fuif/memwb_wsel
add wave -noupdate -expand -group Output /forward_unit_tb/fuif/fward_a
add wave -noupdate -expand -group Output /forward_unit_tb/fuif/fward_b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40 ns} 0}
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
WaveRestoreZoom {0 ns} {84 ns}
