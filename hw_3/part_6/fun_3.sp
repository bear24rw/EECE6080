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
.end
