org 0x0000
ori $2, $0, 0x00F0
ori $3, $0, 2
ori $4, $0, 3
ori $5, $0, 3
ori $6, $0, 4

sw  $4,  0($2)

false:
    beq $4 , $5, true
    sw  $3,  4($2)

true: 
    sw $6, 8($2)
    halt

    

