stepsize 100

logfile fun_8.log

h VDD
l GND

l A0 A1 A2 A3 A4 A5 A6 B0 B1 B2 B3 B4 B5 B6 B7
vector A A7 A6 A5 A4 A3 A2 A1 A0
vector B B7 B6 B5 B4 B3 B2 B1 B0
vector F F7 F6 F5 F4 F3 F2 F1 F0
ana A B F
w A B F

setvector A 00000000
setvector B 00000000
s
path F
setvector A 00000000
setvector B 00111111
s
path F
setvector A 00000000
setvector B 01111110
s
path F
setvector A 00000000
setvector B 10111101
s
path F
setvector A 00000000
setvector B 11111100
s
path F
setvector A 00111101
setvector B 00000000
s
path F
setvector A 00111101
setvector B 00111111
s
path F
setvector A 00111101
setvector B 01111110
s
path F
setvector A 00111101
setvector B 10111101
s
path F
setvector A 00111101
setvector B 11111100
s
path F
setvector A 01111010
setvector B 00000000
s
path F
setvector A 01111010
setvector B 00111111
s
path F
setvector A 01111010
setvector B 01111110
s
path F
setvector A 01111010
setvector B 10111101
s
path F
setvector A 01111010
setvector B 11111100
s
path F
setvector A 10110111
setvector B 00000000
s
path F
setvector A 10110111
setvector B 00111111
s
path F
setvector A 10110111
setvector B 01111110
s
path F
setvector A 10110111
setvector B 10111101
s
path F
setvector A 10110111
setvector B 11111100
s
path F
setvector A 11110100
setvector B 00000000
s
path F
setvector A 11110100
setvector B 00111111
s
path F
setvector A 11110100
setvector B 01111110
s
path F
setvector A 11110100
setvector B 10111101
s
path F
setvector A 11110100
setvector B 11111100
s
path F
