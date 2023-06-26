
  #------------------------------------------------------------------
  # R-type Instruction (ALU) Test Program
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,0xD269
  ori   $2,$zero,0x37F1

  ori   $22,$zero,0xF0

# Now running all R type instructions

  nor   $13,$1,$2
# Store them to verify the results
  sw    $13,0($22)
  halt  # that's all
