import sys
import shlex
import random
import subprocess
from termcolor import colored

N = 16

class Pin:

    def __init__(self):
        self.array = [["0"]*N for i in range(N)]

    def set_xy(self, x, y):
        self.array[y][x] = "1"

    # return a bit vector of the PIN
    # MSB (top right of grid) on right
    #
    # 6 7 8
    # 3 4 5   =>  87654321
    # 0 1 2
    #
    def bits(self):
        rt = ""
        for line in self.array:
            rt += "".join(reversed(line))
        return rt

def get_bits(shift):

    # get bit strings
    shift_bits = bin(shift).replace("0b", "").zfill(N)
    result_bits = ["0"]*N
    pin = Pin()

    # generate a random ordering permutation
    order = range(N)
    random.shuffle(order)
    #order = order[::-1]

    # reorder the result bits
    for i in range(N):
        result_bits[i] = shift_bits[order[i]]

    # calculate PIN for this permutation
    for i in range(N):
        pin.set_xy(order[i], i)

    # return with MSB on left
    return (pin.bits(), shift_bits[::-1], "".join(result_bits)[::-1])

def write_cmd_file(pin_bits, shift_bits, result_bits, analyzer=False):

    with open("intranex.cmd", "w") as f:

        f.write("stepsize 10\n")
        f.write("logfile intranex.log\n")
        f.write("h VDD\n")
        f.write("l GND\n")
        f.write("vector SCLK SCLKI\n")
        f.write("vector PCLK PCLKI\n")
        if analyzer: f.write("ana PCLKI PSI PSO SCLKI SI LDO SO\n")
        f.write("w   PCLKI PSI PSO SCLKI SI LDO SO\n")
        f.write("l TESTI\n")

        # load the PIN
        f.write("clock PCLK 0 1\n")
        for i in pin_bits:
            if i == "1":
                f.write("h PSI\n")
            else:
                f.write("l PSI\n")
            f.write("c\n")

        # disable PCLK
        f.write("clock PCLK 0 0\n")

        # load the SHIFT
        f.write("l LDI\n")
        f.write("clock SCLK 0 1\n")
        for i in shift_bits:
            if i == "1":
                f.write("h SI\n")
            else:
                f.write("l SI\n")
            f.write("c\n")

        # latch the result
        f.write("h LDI\n")
        f.write("c\n")
        f.write("l LDI\n")

        f.write("assert SO %s\n" % result_bits[0])

        # shift out remaining result bits
        for i in range(1, N):
            f.write("c\n")
            f.write("assert SO %s\n" % result_bits[i])

        f.write("c\n")

        if not analyzer: f.write("exit\n")

if __name__ == "__main__":

    random.seed()

    completed = []
    for i in range(100):

        # find a unique permutation we havent tested yet
        while True:

            shift = random.randrange(0, 2**N)
            (pin_bits, shift_bits, result_bits) = get_bits(shift)

            if (pin_bits, shift_bits, result_bits) in completed:
                print "Duplicate test, skipping..."
                continue

            completed.append((pin_bits, shift_bits, result_bits))
            break

        print "TEST #%d" % i
        print "PIN: %s" % pin_bits
        print "SHF: %s" % shift_bits
        print "RSL: %s" % result_bits

        write_cmd_file(pin_bits, shift_bits, result_bits)

        irsim_cmd = "irsim -s../../models/scmos30.prm ../magic/intranex.sim -intranex.cmd"
        subprocess.call(shlex.split(irsim_cmd))

        grep_cmd = "grep assertion intranex.log"
        grep_code = subprocess.call(shlex.split(grep_cmd))

        if grep_code == 0:
            print colored("TEST FAILED!!!", 'red')
            sys.exit(1)

        print colored("PASSED", 'green')
        print colored("-"*50, 'yellow')

    print "DONE"
