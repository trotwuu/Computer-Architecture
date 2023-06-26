org 0x0000
ori $29, $0, 0xFFFC #intialize stack pointer at 0xfffc

# write and read r5 at the same time

lw   $5,   initval($0) # in write back stage 0x7337 will be write into r5
add  $10,  $11,  $12   # random stuff
sub  $13,  $14,  $15   # ranfom stuff
or   $16,  $5,   $17   # reading r5 will cause a problem

halt


# initialize data into memory, stating at addr F0
org   0x00F0
initval:

cfw   0x7337     # F0
cfw   0x2701     # F4
cfw   0x1337     # F8
