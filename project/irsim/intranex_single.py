import sys
import shlex
import subprocess

import intranex

pin_bits = sys.argv[1]
shift_bits = sys.argv[2]
result_bits = sys.argv[3]

intranex.write_cmd_file(pin_bits, shift_bits, result_bits, analyzer=True)

irsim_cmd = "irsim -s../../models/scmos30.prm ../magic/intranex.sim -intranex.cmd"
subprocess.call(shlex.split(irsim_cmd))
