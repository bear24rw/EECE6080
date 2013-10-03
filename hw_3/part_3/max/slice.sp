*
* MODELS
*

.include /home/thrunml/vlsi/models/model_t36s.sp
.include slice.spice

*
* CIRCUIT
*

*C_load F gnd 100fF
VDD vdd gnd 5V

*
* SIMULATION
*

** glitch one
*va  A     gnd PWL(0n 5V)
*vb  B     gnd PWL(0n 0V 4.9n 0V 5n 5V 9.9n 5V 10n 0V)
*vc  C_IN  gnd PWL(0n 5V 4.9n 5V 5n 0V 9.9n 0V 10n 5V)
*vs  S     gnd PWL(0n 5V 4.9n 5V 5n 0V 9.9n 0V 10n 5V)

* glitch two
*va  A     gnd PWL(0n 5V)
*vb  B     gnd PWL(0n 5V)
*vc  C_IN  gnd PWL(0n 0V 4.9n 0V 5n 5V 9.9n 5V 10n 0V)
*vs  S     gnd PWL(0n 5V 4.9n 5V 5n 0V 9.9n 0V 10n 5V)

* delay B to F
*va  A     gnd PWL(0n 0V)
*vb  B     gnd PWL(0n 0V 4.9n 0V 5n 5V 9.9n 5V 10n 0V)
*vc  C_IN  gnd PWL(0n 5V 4.9n 5V 5n 0V 9.9n 0V 10n 5V)
*vs  S     gnd PWL(0n 0V)

* delay B to C_OUT
*va  A     gnd PWL(0n 0V)
*vb  B     gnd PWL(0n 0V 4.9n 0V 5n 5V 9.9n 5V 10n 0V)
*vc  C_IN  gnd PWL(0n 0V)
*vs  S     gnd PWL(0n 0V)

* delay S to F
va  A     gnd PWL(0n 5V)
vb  B     gnd PWL(0n 0V)
vc  C_IN  gnd PWL(0n 0V)
vs  S     gnd PWL(0n 0V 4.9n 0V 5n 5V 9.9n 5V 10n 0V)

.option post
.tran 0.01n 15n
.measure t_rise trig v(F) val=0.5 rise=1 targ v(F) val=4.5 rise=1
.measure t_fall trig v(F) val=4.5 fall=1 targ v(F) val=0.5 fall=1
.measure t_delay param='(t_rise + t_fall)/2'

.end
