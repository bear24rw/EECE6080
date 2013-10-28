with open("shift_slice.cmd", "w") as f:

    f.write("stepsize 10\n")
    f.write("logfile shift_slice.log\n")
    f.write("h VDD\n")
    f.write("l GND\n")
    f.write("vector CLK SCLKI\n")
    f.write("clock CLK 0 1\n")
    f.write("ana SCLKI LDI SI Z SO\n")
    f.write("w   SCLKI LDI SI Z SO\n")

     # ldi  z  si   so
    patterns = (
        ('l','l','l', 'l'),
        ('l','l','h', 'h'),
        ('l','h','l', 'l'),
        ('l','h','h', 'h'),
        ('h','l','l', 'l'),
        ('h','l','h', 'l'),
        ('h','h','l', 'h'),
        ('h','h','h', 'h')
    )

    for ldi, z, si, so in patterns:
        f.write("%s LDI\n" % ldi)
        f.write("%s Z\n" % z)
        f.write("%s SI\n" % si)
        f.write("c CLK\n")
