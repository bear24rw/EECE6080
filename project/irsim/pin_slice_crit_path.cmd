stepsize 10
logfile pin_slice.log
h VDD
l GND
vector CLK CI
clock CLK 0 1
ana CI ZO ZI QI WI QO
w   CI ZO ZI QI WI QO

l ZI
h WI
l QI
c CLK

h QI
c CLK
path ZO

l QI
c CLK
path ZO
