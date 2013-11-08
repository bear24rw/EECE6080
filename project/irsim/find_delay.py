import re
import sys

f = open(sys.argv[1])

contents = f.read()
paths = contents.split("critical path")

time_regex = re.compile("@\s(.*?)ns\s")

deltas = []

for path in paths:
    times = re.findall(time_regex, path)
    if len(times) == 0: continue
    print times
    deltas.append(float(times[-1])-float(times[0]))

print "---"
print "Worst delay: %f" % sorted(deltas)[-1]
print "---"

