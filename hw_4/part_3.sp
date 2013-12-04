* Max Thrun HW4 Part 3

.include ../models/library.sp

VDD vdd gnd 5V

Xcarry0 p_0 g_0 ci   co_0 nclk pclk vdd gnd carry
Xcarry1 p_1 g_1 co_0 co_1 nclk pclk vdd gnd carry
Xcarry2 p_2 g_2 co_1 co_2 nclk pclk vdd gnd carry
Xcarry3 p_3 g_3 co_2 co_3 nclk pclk vdd gnd carry

.param f = 117meg

vpclk   pclk    gnd PULSE(5V 0V '(1/f)/2' 0 0 '(1/f)/2' '1/f')
vnclk   nclk    gnd PULSE(0V 5V '(1/f)/2' 0 0 '(1/f)/2' '1/f')
vci     ci      gnd PULSE(0V 5V 10n 0 0 10n 20n)

vp_0    p_0     gnd PWL(0n 5V)
vp_1    p_1     gnd PWL(0n 5V)
vp_2    p_2     gnd PWL(0n 5V)
vp_3    p_3     gnd PWL(0n 5V)

vg_0    g_0     gnd PWL(0n 0V)
vg_1    g_1     gnd PWL(0n 0V)
vg_2    g_2     gnd PWL(0n 0V)
vg_3    g_3     gnd PWL(0n 0V)

.option post
.tran 0.01n 30n

.end
