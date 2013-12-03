* Max Thrun HW4 Part 1 P-Nand

.include ../models/library.sp

vdd vdd gnd 5V

xpnand a b f clk vdd gnd pnand

.param s = 1

vclk    clk     gnd PULSE(0V 5V '15n*s' 0 0 '15n*s' '30n*s')
va      a       gnd PWL('0n*s' 0V '9.9n*s' 0V '10n*s' 5V '34.9n*s' 5V '35n*s' 0V '49.9n*s' 0V '50n*s' 5V '54.9n*s' 5V '55n*s' 0v)
vb      b       gnd PWL('0n*s' 0V '9.9n*s' 0V '10n*s' 5V '34.9n*s' 5V '35n*s' 0V '49.9n*s' 0V '50n*s' 5V '54.9n*s' 5V '55n*s' 0v)

.option post
.tran 0.01n '75n*s'

.end
