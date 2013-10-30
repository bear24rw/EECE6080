patterns = ("0", "5", "0")

with open("dffposx1_test.sp", "w") as f:

        f.write("* DFFPOSX1 Test\n")

        f.write(".include ../../models/model_t36s.sp\n")
        f.write(".include ../magic/DFFPOSX1.spice\n")

        for n in ("clk", "d", "q"):
            f.write(".ic v(%s) = 0\n" % n)

        f.write("V1 vdd gnd  5V\n")

        f.write("Vclk clk gnd PULSE(0V 5V 10n 0 0 10n 20n)\n")

        o_d = ""

        for i, d in enumerate(patterns):
            o_d += "%dn %sV %fn %sV " % (i*20, d, (i+1)*20-0.001, d)

        f.write("Vd d gnd PWL(%s)\n" % o_d)

        f.write(".option post\n")
        f.write(".tran 0.01n %dn\n" % (len(patterns)*20))
        f.write(".meas tran delay_0 when v(q)=2.5 td=5n cross=1\n")
        f.write(".meas tran delay_1 when v(q)=2.5 td=5n cross=2\n")
        f.write(".end\n")
