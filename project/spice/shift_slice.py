# ldi  z  si   so
patterns = (
    ('0','0','0', '0'),
    ('0','0','5', '5'),
    ('0','5','0', '0'),
    ('0','5','5', '5'),
    ('5','0','0', '0'),
    ('5','0','5', '0'),
    ('5','5','0', '5'),
    ('5','5','5', '5')
)

with open("shift_slice_all.sp", "w") as f:

        f.write("* Shift Slice Test All\n")

        f.write(".include ../../models/model_t36s.sp\n")
        f.write(".include ../magic/shift_slice.spice\n")

        for n in ("ldi", "z", "si", "so", "sclki"):
            f.write(".ic v(%s) = 0\n" % n)

        f.write("VDD vdd gnd 5V\n")

        f.write("Vsclki SCLKI gnd PULSE(0V 5V 10n 0 0 10n 20n)\n")

        o_ldi = ""
        o_z = ""
        o_si = ""

        for i, (ldi, z, si, so) in enumerate(patterns):
            o_ldi += "%dn %sV %fn %sV " % (i*20, ldi, (i+1)*20-0.001, ldi)
            o_z   += "%dn %sV %fn %sV " % (i*20, z,   (i+1)*20-0.001, z)
            o_si  += "%dn %sV %fn %sV " % (i*20, si,  (i+1)*20-0.001, si)

        f.write("Vldi ldi gnd PWL(%s)\n" % o_ldi)
        f.write("Vz   z   gnd PWL(%s)\n" % o_z)
        f.write("Vsi  si  gnd PWL(%s)\n" % o_si)

        f.write(".option post\n")
        f.write(".tran 0.01n %dn\n" % (len(patterns)*20))
        f.write(".end\n")
