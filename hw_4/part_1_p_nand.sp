* Max Thrun HW4 Part 1 P-Nand

.include ../models/library.sp

vdd vdd gnd 5V

xpnand a b f clk vdd gnd pnand

.param f = 200meg
*.param f = 530meg

vclk    clk     gnd PULSE(0V 5V '(1/f)/2' 0 0 '(1/f)/2' '1/f')
va      a       gnd PULSE(5V 0V 10n 0 0 10n 20n)
vb      b       gnd PULSE(5V 0V 10n 0 0 10n 20n)

.option post
.tran 0.01n 30n

.end
