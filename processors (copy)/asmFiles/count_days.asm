org 0x0000
ori $29, $0, 0xFFFC

ori $2, $0, 30 #mounth
ori $3, $0, 1 # 1
ori $15, $0, 365 #day in a year
ori $16, $0, 2000 #year 2000
ori $6, $0, 23 #cur day
ori $13, $0, 8 #cur mon
ori $14, $0, 2022 #cur year
ori $9, $0, 0 #cur year

#$9 final result
#$10 mon days
#$11 year days
sub $13, $13, $3 #month -1
sub $14, $14, $16 #year -2000
push $14
push $15
push $13
push $2


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
    j mult2

mult2:
    pop $17 #first result
    pop $4 #7
    pop $5 #3
    ori $7, $0, 0x0000 #sum init to 0
loop2: 
    beq $4, $0, endloop2 #check if it is now 0
    add $7, $7, $5 # +3 to sum
    ori $8, $0, 0x0001 #reg8 is 1 for sub
    sub $4, $4, $8 #sub 1
    j loop2
endloop2:
    push $7
    add $9, $7, $9
    add $9, $17, $9
    add $9, $6, $9


    halt

