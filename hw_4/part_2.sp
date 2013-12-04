* Max Thrun HW4 Part 2

.include ../models/library.sp

VDD vdd gnd 5V

Xcarry p g ci co nclk pclk vdd gnd carry

*.param f = 125meg
.param f = 380meg

vpclk   pclk    gnd PULSE(5V 0V '(1/f)/2' 0 0 '(1/f)/2' '1/f')
vnclk   nclk    gnd PULSE(0V 5V '(1/f)/2' 0 0 '(1/f)/2' '1/f')
vci     ci      gnd PULSE(0V 5V 10n 0 0 10n 20n)
vp      p       gnd PWL(0n 5V)
vg      g       gnd PWL(0n 0V)

.option post
.tran 0.01n 30n

.end
