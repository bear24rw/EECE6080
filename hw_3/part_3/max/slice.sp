*
* MODELS
*

.include ../../../models/model_t36s.sp
.include slice.spice

*
* CIRCUIT
*

VDD vdd gnd 5V

*
* SIMULATION
*

* delay B to F
*va  A     gnd PWL(0n 0V)
*vb  B     gnd PWL(0n 0V 4.9n 0V 5n 5V 9.9n 5V 10n 0V)
*vc  C_IN  gnd PWL(0n 5V 4.9n 5V 5n 0V 9.9n 0V 10n 5V)
*vs  S     gnd PWL(0n 0V)

* delay B to C_OUT
va  A     gnd PWL(0n 0V)
vb  B     gnd PWL(0n 0V 4.9n 0V 5n 5V 9.9n 5V 10n 0V)
vc  C_IN  gnd PWL(0n 0V)
vs  S     gnd PWL(0n 0V)

.option post
.tran 0.01n 15n
.end
