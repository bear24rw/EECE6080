stepsize 50

logfile irsim_cout.log

h VDD
l GND

l A B C_IN S
vector in A B C_IN S
ana A B C_IN S C_OUT F
w A B C_IN S C_OUT F

setvector in 0000
s
path C_OUT
setvector in 0001
s
path C_OUT
setvector in 0010
s
path C_OUT
setvector in 0011
s
path C_OUT
setvector in 0100
s
path C_OUT
setvector in 0101
s
path C_OUT
setvector in 0110
s
path C_OUT
setvector in 0111
s
path C_OUT
setvector in 1000
s
path C_OUT
setvector in 1001
s
path C_OUT
setvector in 1010
s
path C_OUT
setvector in 1011
s
path C_OUT
setvector in 1100
s
path C_OUT
setvector in 1101
s
path C_OUT
setvector in 1110
s
path C_OUT
setvector in 1111
s
path C_OUT
