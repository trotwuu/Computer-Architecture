org 0x0000

ori $5, $5, 16
ori $9, $9, 0x1234
ori $6, $6, 0x4000      # addr 

loop:
    beq $5, $0, end     # loop for 16 times
    sw  $9, 0($6)
    sw  $9, 0($6)
    sw  $9, 0($6)
    sw  $9, 0($6)
    addi $5, $5, -1     # decrement the loop index
    j loop
end:

halt

