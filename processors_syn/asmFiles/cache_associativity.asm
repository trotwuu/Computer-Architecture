org 0x0000
ori $2, $2, 0x4000

sw  $3, 0($2)
sw  $4, 4($2)
sw  $5, 8($2)

halt

org 0x4000
cfw 0x1111

org 0x4004
cfw 0x2222

org 0x4008
cfw 0x3333