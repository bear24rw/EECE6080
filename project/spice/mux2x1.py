import itertools

# S A B Y
patterns = (
    ('0','0','0', '5'),
    ('0','0','5', '0'),
    ('0','5','0', '5'),
    ('0','5','5', '0'),
    ('5','0','0', '5'),
    ('5','0','5', '5'),
    ('5','5','0', '0'),
    ('5','5','5', '0')
)

with open("mux2x1_test.sp", "w") as f:

        f.write("* MUX2X1 Test\n")

        f.write(".include ../../models/model_t36s.sp\n")
        f.write(".include ../magic/MUX2X1.spice\n")

        for n in ("s", "a", "b", "y"):
            f.write(".ic v(%s) = 0\n" % n)

        f.write("V1 vdd gnd  5V\n")

        o_a = ""
        o_b = ""
        o_s = ""

        i = 0
        for state_1, state_2 in itertools.permutations(patterns, 2):
            # if this state change doesn't change the output, skip it
            if state_1[-1] == state_2[-1]: continue
            # if more than one input changed skip it
            if sum(1 for x, y in zip(state_1[:-1], state_2[:-1]) if x != y) > 1: continue
            # otherwise execute the state change
            print (state_1, state_2)
            for s, a, b, y in (state_1, state_2):
                o_s += "%dn %sV %fn %sV " % (i*20, s, (i+1)*20-0.001, s)
                o_a += "%dn %sV %fn %sV " % (i*20, a, (i+1)*20-0.001, a)
                o_b += "%dn %sV %fn %sV " % (i*20, b, (i+1)*20-0.001, b)
                i += 1

        print i

        f.write("Vs s gnd PWL(%s)\n" % o_s)
        f.write("Va a gnd PWL(%s)\n" % o_a)
        f.write("Vb b gnd PWL(%s)\n" % o_b)

        f.write(".option post\n")
        f.write(".tran 0.01n %dn\n" % (i*20))

        # measure each crossing
        for n in range(0,(i/2)):
            f.write(".meas tran delay_%d when v(y)=2.5 td=%sn cross=1\n" % (n,(n*40)+10))

        f.write(".end\n")

