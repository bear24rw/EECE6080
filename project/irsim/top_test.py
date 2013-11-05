with open("top_test.cmd", "w") as f:

    f.write("stepsize 10\n")
    f.write("logfile top_test.log\n")
    f.write("h VDD\n")
    f.write("l GND\n")
    f.write("vector CLK SCLKO\n")
    f.write("clock CLK 0 1\n")
    f.write("ana SCLKO SI SSO SO\n")
    f.write("w   SCLKO SI SSO SO\n")

    f.write("l LDO\n")
    f.write("l PCLKI\n")
    f.write("l PSI\n")
    f.write("h TESTO\n")

    f.write("l SI\n")
    f.write("c CLK\n")

    f.write("h SI\n")
    f.write("c CLK\n")

    f.write("l SI\n")
    f.write("c CLK\n")

    for i in range(15*16+10):
    #for i in range(50):
        f.write("c CLK\n")
