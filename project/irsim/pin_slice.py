with open("pin_slice.cmd", "w") as f:

    f.write("stepsize 10\n")
    f.write("logfile pin_slice.log\n")
    f.write("h VDD\n")
    f.write("l GND\n")
    f.write("vector CLK CI\n")
    f.write("clock CLK 0 1\n")
    f.write("ana CI ZI QI WI ZO QO\n")
    f.write("w   CI ZI QI WI ZO QO\n")

    # zi  qi  wi   zo
    patterns = (
        ('l','l','l', 'l'),
        ('l','l','h', 'l'),
        ('l','h','l', 'l'),
        ('l','h','h', 'h'),
        ('h','l','l', 'h'),
        ('h','l','h', 'h'),
        ('h','h','l', 'h'),
        ('h','h','h', 'h')
    )

    for zi, qi, wi, zo in patterns:
        f.write("%s ZI\n" % zi)
        f.write("%s QI\n" % qi)
        f.write("%s WI\n" % wi)
        f.write("c CLK\n")
