onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hazard_unit_tb/CLK
add wave -noupdate /hazard_unit_tb/nRST
add wave -noupdate /hazard_unit_tb/DUT/huif/dcif_dhit
add wave -noupdate /hazard_unit_tb/DUT/huif/exmem_flush
add wave -noupdate /hazard_unit_tb/DUT/huif/exmem_freeze
add wave -noupdate /hazard_unit_tb/DUT/huif/idex_flush
add wave -noupdate /hazard_unit_tb/DUT/huif/idex_freeze
add wave -noupdate /hazard_unit_tb/DUT/huif/idex_regWr
add wave -noupdate /hazard_unit_tb/DUT/huif/idex_rt
add wave -noupdate /hazard_unit_tb/DUT/huif/ifid_flush
add wave -noupdate /hazard_unit_tb/DUT/huif/ifid_freeze
add wave -noupdate /hazard_unit_tb/DUT/huif/ifid_instr
add wave -noupdate /hazard_unit_tb/DUT/huif/memwb_flush
add wave -noupdate /hazard_unit_tb/DUT/huif/memwb_freeze
add wave -noupdate /hazard_unit_tb/DUT/huif/pc_freeze
add wave -noupdate /hazard_unit_tb/DUT/huif/pcsrc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23 ns} 0}
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
