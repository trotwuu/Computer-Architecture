
  #------------------------------------------------------------------
  # R-type Instruction (ALU) Test Program
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,0xD269
  ori   $2,$zero,0x37F1

  ori   $22,$zero,0xF0
  nop
  nop
# Now running all R type instructions

  nor   $13,$1,$2
# Store them to verify the results
  addi  $14, $13, 0x59
  sw    $14,0($22)
  halt  # that's all
