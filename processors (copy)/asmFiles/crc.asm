#----------------------------------------------------------
# First Processor
#----------------------------------------------------------
  org   0x0000              # first processor p0
  ori   $sp, $zero, 0x3ffc  # stack
  ori   $t9, $zero, 0x1       # set seed to 5
  or    $a0, $zero, $t9    # set argument to previous value (or seed if first loop)
  jal   crc32              # go to program
  or   $t8, $zero, $v0     # set temp register to result of crc32
  ori $t0, $zero, element
  sw $t8, 0($t0)
  halt

#----------------------------------------------------------
# Second Processor
#----------------------------------------------------------
  org   0x200               # second processor p1
  # ori   $sp, $zero, 0x7ffc  # stack
  # jal   mainp1              # go to program
  halt

#REGISTERS
#at $1 at
#v $2-3 function returns
#a $4-7 function args
#t $8-15 temps
#s $16-23 saved temps (callee preserved)
#t $24-25 temps
#k $26-27 kernel
#gp $28 gp (callee preserved)
#sp $29 sp (callee preserved)
#fp $30 fp (callee preserved)
#ra $31 return address

# USAGE random0 = crc(seed), random1 = crc(random0)
#       randomN = crc(randomN-1)
#------------------------------------------------------
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

l1:
  slt $t4, $t2, $t3
  beq $t4, $zero, l2

  ori $t5, $0, 31
  srlv $t4, $t5, $a0
  ori $t5, $0, 1
  sllv $a0, $t5, $a0
  beq $t4, $0, l3
  xor $a0, $a0, $t1
l3:
  addiu $t2, $t2, 1
  j l1
l2:
  or $v0, $a0, $0
  jr $ra

org 0xE000
