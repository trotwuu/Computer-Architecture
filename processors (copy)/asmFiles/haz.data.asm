org 0x0000
ori $29, $0, 0xFFFC #intialize stack pointer at 0xfffc


# write to r1 two consecutive time. Then read r1. It should use the latest value
add  $1,  $2,  $3
sub  $1,  $4,  $5
and  $6,  $1,  $4

# load/use
# load value into r7 and use it immediately 
lw   $7,  initval($0)
xor  $10, $7,  $4

# load/store
# load value into r7 and store it immediately 
lw   $12,  initval($0)
sw   $12,  0xF4($0)

halt

org   0x00F0
initval:

cfw   0x7337     # F0
cfw   0x2701     # F4
cfw   0x1337     # F8
