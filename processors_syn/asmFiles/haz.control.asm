org 0x0000
ori $29, $0, 0xFFFC #intialize stack pointer at 0xfffc

beq $0,  $0,  taken
# processor should skip the follwing lines and jump to taken
and $12, $12,  $5
or  $13, $6,  $2
add $14, $2,  $2

# jump to here
taken:
    lw   $10,  initval($0)

halt

org   0x00F0
initval:

cfw   0x7337     # F0
