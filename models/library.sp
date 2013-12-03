.include ../models/model_t36s.sp

* FET Parameters
.param l  = 0.6u
.param pw = 0.9u
.param nw = 0.9u
.param ld = 2.0u

* P-NAND
.subckt pnand a b f clk vdd gnd
    mp1     vdd     clk     t789    vdd pfet w=pw l=l ad=(ld*pw) as=(ld*pw) pd=(2*ld+2*pw) ps=(2*ld+2*pw)
    mp2     t789    a       f       vdd pfet w=pw l=l ad=(ld*pw) as=(ld*pw) pd=(2*ld+2*pw) ps=(2*ld+2*pw)
    mp3     t789    b       f       vdd pfet w=pw l=l ad=(ld*pw) as=(ld*pw) pd=(2*ld+2*pw) ps=(2*ld+2*pw)
    mn4     f       clk     gnd     gnd nfet w=nw l=l ad=(ld*nw) as=(ld*nw) pd=(2*ld+2*nw) ps=(2*ld+2*nw)
.ends

* N-NAND
.subckt nnand a b f clk vdd gnd
    mp1     vdd     clk     f       vdd pfet w=pw l=l ad=(ld*pw) as=(ld*pw) pd=(2*ld+2*pw) ps=(2*ld+2*pw)
    mn2     f       a       t23     gnd nfet w=nw l=l ad=(ld*nw) as=(ld*nw) pd=(2*ld+2*nw) ps=(2*ld+2*nw)
    mn3     t23     b       t34     gnd nfet w=nw l=l ad=(ld*nw) as=(ld*nw) pd=(2*ld+2*nw) ps=(2*ld+2*nw)
    mn4     t34     clk     gnd     gnd nfet w=nw l=l ad=(ld*nw) as=(ld*nw) pd=(2*ld+2*nw) ps=(2*ld+2*nw)
.ends

* Inverter
.subckt inv a f vdd gnd
    mp  vdd     a   f       vdd pfet w=pw l=l ad=(ld*pw) as=(ld*pw) pd=(2*ld+2*pw) ps=(2*ld+2*pw)
    mn  f       a   gnd     gnd nfet w=nw l=l ad=(ld*nw) as=(ld*nw) pd=(2*ld+2*nw) ps=(2*ld+2*nw)
.ends

* Carry Slice
.subckt carry p g ci co nclk pclk vdd gnd
    Xinv   g  f2          vdd gnd inv
    Xnnand p  ci f1  nclk vdd gnd nnand
    Xpnand f1 f2 co  pclk vdd gnd pnand
.ends

.end
