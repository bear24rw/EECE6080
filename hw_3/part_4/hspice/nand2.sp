.include ../../../models/model_t36s.sp

.param n=4
.param wp=0.3u*n
.param wn=0.3u*n
.param hd=2u

mPMos1 c a vdd vdd pfet w=wp l=0.6u ad=hd*wp pd=2*hd+2*wp as=hd*wp ps=2*hd+2*wp
mPMos2 b a vdd vdd pfet w=wp l=0.6u ad=hd*wp pd=2*hd+2*wp as=hd*wp ps=2*hd+2*wp

mNMos1 c a d d nfet w=wn l=0.6u ad=hd*wn pd=2*hd+2*wn as=hd*wn ps=2*hd+2*wn
mNMos2 d b gnd gnd nfet w=wn l=0.6u ad=hd*wn pd=2*hd+2*wn as=hd*wn ps=2*hd+2*wn

VDD vdd gnd 5v
Va a gnd PWL(0 0v 4.9n 0v 5n 5v 9.9n 5v 10n 0v 14.9n 0v )
Vb b gnd PWL(0 0v 4.9n 0v 5n 5v 9.9n 5v 10n 5v 14.9n 5v )

.option post
.tran 0.1n 15n
.end

