org 0x0000
ori $2, $0, 0x00F0
ori $3, $0, 2
ori $4, $0, 3
ori $5, $0, 4
ori $6, $0, 5
sw $3, 0($2)

jal first
sw $3, 4($2)

halt

first:
    sw $3, 8($2)
    jr $31


