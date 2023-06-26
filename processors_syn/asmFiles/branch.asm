org 0x0000
ori $2, $0, 0x0040
ori $3, $0, 2
ori $4, $0, 3
ori $5, $0, 3
ori $6, $0, 4

false:
    bne	$4 , $5, true	# if  != $t1 then target
    sw $3, 0($2)
    beq $4 , $5, true

done: 
    sw $6, 8($2)
    halt

true:
    beq $3 , $5, done
    sw $4, 4($2)
    bne	$3 , $5, done
    sw $4, 12($2)

