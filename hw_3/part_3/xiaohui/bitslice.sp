*********

.include ../../../models/model_t36s.sp
.include bitslice.spice

VDD vdd gnd 5v
Va A gnd PWL(0 5v 4.9n 5v 5n 0v 9.9n 0v 10n 5v 14.9n 5v 15n 0v 19.9n 0v 20n 5v 24.9n 5v)
Vb B gnd PWL(0 5v 4.9n 5v 5n 0v 9.9n 0v 10n 5v 19.9n 5v 20n 0v 24.9n 0v)
Vcin cin gnd PWL(0 0v 4.9n 0v 5n 5v 19.9n 5v 20n 0v 24.9n 0v)
Vs S gnd PWl(0 0v 4.9n 0v 5n 5v 19.9n 5v 20n 0v 24.9n 0v)
.option post
.tran 0.1n 25n
.end
