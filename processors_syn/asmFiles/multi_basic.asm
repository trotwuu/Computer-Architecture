org 0x0000
  ori $1, $zero, 0x0300
  ori $2, $zero, 0xbeef
  sw $2, 0($1) # I -> M
  addi $2, $2, 0x0033
  sw $2, 0($1) # M -> M
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  addi $2, $2, 0x3333
  sw $2, 0($1) # core1 I -> M core2 M -> I


  halt


org 0x0200
  ori $1, $zero, 0x0300
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  lw $2, 0($1) # core1 M -> S core2 I -> S

  addi $2, $2, 0x0011
  sw $2, 0($1) # core2 S -> M core1 S -> I
  halt

  org   0x0300
  cfw   0x7337
  cfw   0x2701
  cfw   0x1337
