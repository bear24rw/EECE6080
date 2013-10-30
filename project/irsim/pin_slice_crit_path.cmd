stepsize 10
logfile pin_slice.log
h VDD
l GND
vector CLK CI
clock CLK 0 1
ana CI ZO ZI QI WI QO
w   CI ZO ZI QI WI QO

l ZI
l QI
h WI
c CLK

l ZI
h QI
h WI
c CLK

path ZO

l ZI
l QI
h WI
c CLK

path ZO
