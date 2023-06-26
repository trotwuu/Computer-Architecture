onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cif0/iwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cif0/dwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cif0/iREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cif0/dREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cif0/dWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cif0/iload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cif0/dload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cif0/dstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cif0/iaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cif0/daddr
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/negative
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/overflow
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/aluop
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/port_a
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/port_b
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/outport
add wave -noupdate -group RegisterFiles /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group RegisterFiles /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group RegisterFiles /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group RegisterFiles /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group RegisterFiles /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group RegisterFiles /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group RegisterFiles /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/addr
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/BAD
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/CLK
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/count
add wave -noupdate -expand -group ram -radix binary /system_tb/DUT/RAM/en
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/LAT
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/nRST
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/q
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/rstate
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/wren
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {710736 ps} 0}
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
WaveRestoreZoom {262570 ps} {501274 ps}
