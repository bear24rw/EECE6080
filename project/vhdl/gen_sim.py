N = 3

out = open("vectors_%d_bit.sim"%N, "w")

# loop through all possible pins and shift values
for pin in range(2**(N*N)):
    for shift in range(2**N):

        # get bit strings
        pin_bits = bin(pin).replace("0b", "").zfill(N*N)
        shift_bits = bin(shift).replace("0b", "").zfill(N)
        result_bits = ["0"]*N

        # calculate the expected result
        for z in range(N):
            for w in range(N):
                if pin_bits[(N-1-z)*N+w] == "1" and shift_bits[w] == "1":
                    result_bits[z] = "1"

        # writeout results
        out.write("%s\n" % pin_bits)
        out.write("%s\n" % shift_bits)
        out.write("%s\n" % "".join(result_bits))

out.close()
