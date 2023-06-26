org 0x0000
ori $2, $0, 0x00F0
lui   $7,0xdead
nop
nop
nop
ori   $7,$7,0xbeef
nop
nop
nop
sw    $7,12($2)
  halt      # that's all

  org   0x00F0
  cfw   0x7337
  cfw   0x2701
  cfw   0x1337



