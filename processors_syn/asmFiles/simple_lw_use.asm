
  #------------------------------------------------------------------
  # R-type Instruction (ALU) Test Program
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,0xD269
  ori   $2,$zero,0x37F1

  ori   $22,$zero,0xF0
# Now running all R type instructions
  lw    $7, 0($22)
  nor   $13,$7,$2
# Store them to verify the results
  nop
  nop
  sw    $13,4($22)
  halt  # that's all

  org   0x00F0
  cfw   0x7337
  cfw   0x2701
  cfw   0x1337
