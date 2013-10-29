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

for i, (ldi, z, si, so) in enumerate(patterns):

    with open("shift_slice_%s.sp" % i, "w") as f:

        f.write("* Shift Slice Test %d\n" % i)
        f.write("* Initial values: (ldi = %s) (z = %s) (si = %s)\n" % (ldi, z, so))
        f.write("* Expected output: (so = %s)\n" % (so))

        f.write(".include ../../models/model_t36s.sp\n")
        f.write(".include ../magic/shift_slice.spice\n")

        for n in ("ldi", "z", "si", "so", "sclki"):
            f.write(".ic v(%s) = 0\n" % n)

        f.write("VDD vdd gnd 5V\n")

        f.write("Vldi LDI gnd PWL(0n %sV)\n" % ldi)
        f.write("Vz   Z   gnd PWL(0n %sV)\n" % z)
        f.write("Vsi  SI  gnd PWL(0n %sV)\n" % si)

        f.write("Vsclki SCLKI gnd PULSE(0V 5V 5n 0 0 15n 20n)\n")

        f.write(".option post\n")
        f.write(".tran 0.01n 10n\n")
        f.write(".end\n")

