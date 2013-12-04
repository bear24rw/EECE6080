* Max Thrun HW4 Part 4

.include ../models/library.sp

VDD vdd gnd 5V

Xcarry0 p_0 g_0 ci   co_0 nclk pclk vdd gnd carry
Xcarry1 p_1 g_1 co_0 co_1 nclk pclk vdd gnd carry
Xcarry2 p_2 g_2 co_1 co_2 nclk pclk vdd gnd carry
Xcarry3 p_3 g_3 co_2 co_3 nclk pclk vdd gnd carry

.param s = 10000000

vpclk   nclk    gnd PULSE(0V 5V 5n 0 0 '10n*s' '20n*s')
vnclk   pclk    gnd PULSE(5V 0V 5n 0 0 '10n*s' '20n*s')
vci     ci      gnd PWL(0n 0V 9.9n 0V 10n 5V 19.9n 5V 20n 0V)

vp_0    p_0     gnd PWL(0n 5V)
vp_1    p_1     gnd PWL(0n 5V)
vp_2    p_2     gnd PWL(0n 5V)
vp_3    p_3     gnd PWL(0n 5V)

vg_0    g_0     gnd PWL(0n 0V)
vg_1    g_1     gnd PWL(0n 0V)
vg_2    g_2     gnd PWL(0n 0V)
vg_3    g_3     gnd PWL(0n 0V)

.option post
.tran 0.01n '10n*s'

.end
