stepsize 10
logfile shift_slice.log
h VDD
l GND
vector CLK SCLKI
clock CLK 0 1
ana SCLKI LDI SI Z SO
w   SCLKI LDI SI Z SO

l LDI
l Z
l SI
c CLK

h SI
c CLK
path SO

l SI
c CLK
path SO
