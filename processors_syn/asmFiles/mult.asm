org 0x0000
ori $29, $0, 0xFFFC

ori $2, $0, 0x0003 #3
ori $3, $0, 0x0007 #7

push $2
push $3

mult: 
    pop $4 #7
    pop $5 #3
    ori $7, $0, 0x0000 #sum init to 0

loop: 
    beq $4, $0, endloop #check if it is now 0
    add $7, $7, $5 # +3 to sum
    ori $8, $0, 0x0001 #reg8 is 1 for sub
    sub $4, $4, $8 #sub 1
    j loop
endloop:
    push $7
    halt
