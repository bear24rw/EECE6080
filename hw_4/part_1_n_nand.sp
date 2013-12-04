* Max Thrun HW4 Part 1 N-Nand

.include ../models/library.sp

vdd vdd gnd 5V

xnnand a b f clk vdd gnd nnand

*.param f = 200meg
.param f = 940meg

vclk    clk     gnd PULSE(0V 5V '(1/f)/2' 0 0 '(1/f)/2' '1/f')
va      a       gnd PULSE(0V 5V 10n 0 0 10n 20n)
vb      b       gnd PULSE(0V 5V 10n 0 0 10n 20n)

.option post
.tran 0.01n 30n

.end
