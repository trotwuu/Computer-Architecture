  org   0x0000
  ori   $1, $zero, 0x400
  ori   $7, $zero, 0xFF
  nop
  nop
  or  $6,$1,$7
  sw    $6, 0($1)
  halt      
  
  # that's all
  nop
  nop
  nop
  lw    $3, 0($1)
  sw    $7, 0($1)
  org   0x00F0
  cfw   0x7337
  cfw   0x2701
  cfw   0x1337
