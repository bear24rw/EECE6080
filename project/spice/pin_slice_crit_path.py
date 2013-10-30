# zi  qi  wi
patterns = (
    ('0','0','5'),
    ('0','5','5'),
    ('0','0','5')
)

with open("pin_slice_crit_path.sp", "w") as f:

    f.write("* Pin Slice Critical Path\n")

    f.write(".include ../../models/model_t36s.sp\n")
    f.write(".include ../magic/pin_slice.spice\n")

    for n in ("zi", "ci", "qi", "wi", "zo", "qo"):
        f.write(".ic v(%s) = 0\n" % n)

    f.write("VDD vdd gnd 5V\n")

    f.write("Vsclki ci gnd PULSE(0V 5V 10n 0 0 10n 20n)\n")

    o_zi = ""
    o_qi = ""
    o_wi = ""

    for i, (zi, qi, wi) in enumerate(patterns):
        o_zi += "%dn %sV %fn %sV " % (i*20, zi, (i+1)*20-0.001, zi)
        o_qi += "%dn %sV %fn %sV " % (i*20, qi, (i+1)*20-0.001, qi)
        o_wi += "%dn %sV %fn %sV " % (i*20, wi, (i+1)*20-0.001, wi)

    f.write("Vzi zi gnd PWL(%s)\n" % o_zi)
    f.write("Vqi qi gnd PWL(%s)\n" % o_qi)
    f.write("Vwi wi gnd PWL(%s)\n" % o_wi)

    f.write(".option post\n")
    f.write(".tran 0.01n %dn\n" % (len(patterns)*20))
    f.write(".end\n")

