*
* MODELS
*

.include ../../models/model_t36s.sp
.include ../part_5/fun_8.spice

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
va3  A3     gnd PWL(0n 0V)
va4  A4     gnd PWL(0n 0V)
va5  A5     gnd PWL(0n 0V)
va6  A6     gnd PWL(0n 0V)
va7  A7     gnd PWL(0n 0V)

vb0  B0     gnd PWL(0n 5V)
vb1  B1     gnd PWL(0n 0V)
vb2  B2     gnd PWL(0n 0V)
vb3  B3     gnd PWL(0n 0V)
vb4  B4     gnd PWL(0n 0V)
vb5  B5     gnd PWL(0n 0V)
vb6  B6     gnd PWL(0n 0V)
vb7  B7     gnd PWL(0n 0V)

.option post
.tran 0.01n 25n
.end
