patterns = ("0", "5", "0")

with open("invx1_test.sp", "w") as f:

        f.write("* INVX1 Test\n")

        f.write(".include ../../models/model_t36s.sp\n")
        f.write(".include ../magic/INVX1.spice\n")

        for n in ("a", "y"):
            f.write(".ic v(%s) = 0\n" % n)

        f.write("V1 vdd gnd  5V\n")

        o_a = ""

        for i, d in enumerate(patterns):
            o_a += "%dn %sV %fn %sV " % (i*20, d, (i+1)*20-0.001, d)

        f.write("Va a gnd PWL(%s)\n" % o_a)

        f.write(".option post\n")
        f.write(".tran 0.01n %dn\n" % (len(patterns)*20))
        # measure each crossing
        f.write(".meas tran delay_0 when v(y)=2.5 td=10n cross=1\n")
        f.write(".meas tran delay_1 when v(y)=2.5 td=30n cross=1\n")
        f.write(".end\n")

