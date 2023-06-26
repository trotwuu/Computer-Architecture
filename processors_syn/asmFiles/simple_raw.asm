  org   0x0000
  ori   $1, $zero, 0x400
  ori   $7, $zero, 0xFF
  sub  $2, $7, $1
  andi $3, $2, 0xFF00
  add $4, $2, $2


  sw  $2, 0($1)
  sw  $3, 4($1)
  sw $4, 8($1)
  halt      
  
  # that's all

  org   0x0400
  cfw   0x7337
  cfw   0x2701
  cfw   0x1337
