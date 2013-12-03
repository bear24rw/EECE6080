* Max Thrun HW4 Part 2

.include ../models/library.sp

VDD vdd gnd 5V

Xcarry p g ci co nclk pclk vdd gnd carry

.param s = 0.075

vpclk   nclk    gnd PULSE(0V 5V '15n*s' 0 0 '15n*s' '30n*s')
vnclk   pclk    gnd PULSE(5V 0V '15n*s' 0 0 '15n*s' '30n*s')
vp      p       gnd PWL(0n 5V)
vg      g       gnd PWL(0n 5V)
vci     ci      gnd PWL(0n 0V '9.9n*s' 0V '10n*s' 5V '34.9n*s' 5V '35n*s' 0V '49.9n*s' 0V '50n*s' 5V '54.9n*s' 5V '55n*s' 0v)

.option post
.tran 0.01n '75n*s'

.end
