org 0x0000
ori $2, $0, 0x0040
ori $3, $0, 2
ori $4, $0, 3
ori $5, $0, 4
ori $6, $0, 5

nop
nop
nop
nop
nop
j first
nop
nop
nop
nop
nop

first:
    sw $3, 0($2)
    nop
    nop
    nop
    nop
    nop
    jal second
    nop
    nop
    nop
    nop
    nop

    sw $5, 8($2)
    nop
    nop
    nop
    nop
    nop
    j end
    nop
    nop
    nop
    nop
    nop
    

second:
    nop
    nop
    nop
    nop
    nop
    sw $4, 4($2)
    nop
    nop
    nop
    nop
    nop
    jr $31
    nop
    nop
    nop
    nop
    nop


end:
    nop
    nop
    nop
    nop
    nop
    sw $6, 12($2)
    halt


