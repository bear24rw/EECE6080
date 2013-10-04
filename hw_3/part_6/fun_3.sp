*
* MODELS
*

.include ../../models/model_t36s.sp
.include ../part_5/fun_3.spice

*
* CIRCUIT
*

VDD vdd gnd 5V

*
* SIMULATION
*

va0  A0     gnd PWL(0n 5V 4.9n 5V 5n 0V 19.9n 0V 20n 5v)
va1  A1     gnd PWL(0n 0V)
va2  A2     gnd PWL(0n 0V)

vb0  B0     gnd PWL(0n 5V)
vb1  B1     gnd PWL(0n 0V)
vb2  B2     gnd PWL(0n 0V)

.option post
.tran 0.01n 25n
.measure t_rise trig v(F) val=0.5 rise=1 targ v(F) val=4.5 rise=1
.measure t_fall trig v(F) val=4.5 fall=1 targ v(F) val=0.5 fall=1
.measure t_delay param='(t_rise + t_fall)/2'

.end
