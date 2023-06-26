org 0x0000
ori $29, $0, 0xFFFC #intialize stack pointer at 0xfffc
ori $28, $0, 0xFFF8
ori $2, $0, 3 # 1 op
ori $3, $0, 5 # 2 op
ori $4, $0, 7 # 3 op

push $2
push $3
push $4

multprocedure:
    beq $29, $28, endprocedure

    j mult

mult:
    pop $4
    pop $5
    ori $7, $0, 0x0000 #sum init to 0

loop: 
    beq $4, $0, endloop #check if it is now 0
    add $7, $7, $5 # +3 to sum
    ori $8, $0, 0x0001 #reg8 is 1 for sub
    sub $4, $4, $8 #sub 1
    j loop
endloop:
    push $7
    j multprocedure
    


endprocedure:
    halt
