SIZE=8
for a in range(0, 2**SIZE, 61):
    for b in range(0, 2**SIZE, 63):
        print "setvector A %s" % (bin(a).replace("0b","").zfill(SIZE))
        print "setvector B %s" % (bin(b).replace("0b","").zfill(SIZE))
        print "s"
        print "path F"
