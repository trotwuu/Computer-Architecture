org 0x0000

ori $2, $2, 0x0400
ori $3, $3, 0x4

sw $3, 0($2)
loop:
    lw $5, 0($2)
    addi $3, $3, -1
    beq $3, $0, end
    j loop

end:
    halt

org 0x4000
cfw 0x1234
