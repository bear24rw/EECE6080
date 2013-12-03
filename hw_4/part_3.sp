* Max Thrun HW4 Part 3

.include ../models/library.sp

VDD vdd gnd 5V

Xcarry0 p_0 g_0 ci   co_0 nclk pclk vdd gnd carry
Xcarry1 p_1 g_1 co_0 co_1 nclk pclk vdd gnd carry
Xcarry2 p_2 g_2 co_1 co_2 nclk pclk vdd gnd carry
Xcarry3 p_3 g_3 co_2 co_3 nclk pclk vdd gnd carry

.param s = 0.078

vpclk   nclk    gnd PULSE(0V 5V '15n*s' 0 0 '15n*s' '30n*s')
vnclk   pclk    gnd PULSE(5V 0V '15n*s' 0 0 '15n*s' '30n*s')

vp_0    p_0     gnd PWL(0n 5V)
vp_1    p_1     gnd PWL(0n 5V)
vp_2    p_2     gnd PWL(0n 5V)
vp_3    p_3     gnd PWL(0n 5V)

vg_0    g_0     gnd PWL(0n 5V)
vg_1    g_1     gnd PWL(0n 5V)
vg_2    g_2     gnd PWL(0n 5V)
vg_3    g_3     gnd PWL(0n 5V)

vci     ci      gnd PWL(0n 0V '9.9n*s' 0V '10n*s' 5V '34.9n*s' 5V '35n*s' 0V '49.9n*s' 0V '50n*s' 5V '54.9n*s' 5V '55n*s' 0v)

.option post
.tran 0.01n '75n*s'

.end
