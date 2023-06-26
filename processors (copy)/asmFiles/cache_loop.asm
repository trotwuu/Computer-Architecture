org 0x0000

ori $5, $5, 0xFFF          # index for loop (not for index in addr)
ori $6, $6, 0x4000      # addr 

loop:
    beq $5, $0, end     # loop for 16 times
    lw $7, 0($6)
    sw  $5, 0($6)       # store random things into left data0 
    lw $7, 0($6)
    addi $6, $6, 4      # add 4(100 in binary) would change the block off constantly
    lw $7, 0($6)
    sw  $5, 0($6)       # store random things into left data1
    lw $7, 0($6)
    addi $6, $6, 4      

    addi $5, $5, -1     # decrement the loop index
    j loop
end:

halt



