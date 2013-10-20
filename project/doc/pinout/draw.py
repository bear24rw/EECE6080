import svgwrite

pins_per_side = 10

pin_length = 50
pin_width = pin_length / 2
pin_spacing = pin_length / 5
edge_to_pin = pin_length / 2
pin_1_indicator_size = pin_length / 2

dwg = svgwrite.Drawing("pinout.svg")
dwg.viewbox(-400, -400, 800, 800)

# load pinnames
names = ["--"]*pins_per_side*4
f = open("pinlist.txt")
for line in f:
    if line[0] == "%": continue
    if line[0] == "\n": continue
    number = int(line.split("&")[0].strip())-1
    if (number >= len(names)):
        print "Pin number out of range: "+line
        continue
    name = line.split("&")[1].strip()
    names[number] = name

def rect(x, y, w, h):
    return dwg.rect(
        insert = (x, y),
        size = (str(w), str(h)),
        stroke_width = "2",
        stroke = "black",
        fill = "rgb(255,255,255)")

def txt(x, y, t, center_vert=False, anchor="start", size="1em"):
    rt = dwg.text(t, insert = (x, y))
    rt["font-size"] = size
    rt["text-anchor"] = anchor # start, middle, end
    if center_vert:
        rt["dominant-baseline"] = "central"
    return rt

# main chip body
chip_width = 2*edge_to_pin + pin_width*pins_per_side + pin_spacing*(pins_per_side-1)
chip_edge = chip_width / 2
chip_rect = rect(-chip_edge, -chip_edge, chip_width, chip_width)
dwg.add(chip_rect)
dwg.add(txt(0, 0, "INTRANEX", center_vert=True, anchor="middle", size="2em"))

for side in range(4):

    pin_rect = dwg.defs.add(dwg.g(id="side-%d"%side))

    for i in range(pins_per_side):
        if side == 0 or side == 1:
            x = -pin_length
            y = i*(pin_width + pin_spacing) + edge_to_pin
            txt_x = -5 - pin_length
            txt_y = y + (pin_width/2.0)
            num_x = -5
            anchor = "end"
        if side == 2 or side == 3:
            x = 0
            y = -1*i*(pin_width + pin_spacing) - edge_to_pin - pin_width
            txt_x = 5 + pin_length
            txt_y = y + (pin_width/2.0)
            num_x = 5
            anchor = "start"

        pin_rect.add(rect(x, y, pin_length, pin_width))

        pin_number = side*pins_per_side+i
        pin_rect.add(txt(txt_x, txt_y, names[pin_number], anchor=anchor, center_vert=True))

        pin_rect.add(txt(num_x, txt_y, str(pin_number+1), anchor=anchor, center_vert=True))

    u = dwg.use(pin_rect)

    if side == 0:
        u.translate(-chip_edge, -chip_edge)
    if side == 1:
        u.rotate(270)
        u.translate(-chip_edge, -chip_edge)
    if side == 2:
        u.translate(chip_edge, chip_edge)
    if side == 3:
        u.rotate(270)
        u.translate(chip_edge, chip_edge)

    dwg.add(u)


#dwg.add(dwg.line(start=(-100,0), end=(100,0), stroke="green"))
#dwg.add(dwg.line(start=(0,-100), end=(0,100), stroke="green"))

# pin 1 indicator
dwg.add(dwg.circle((-chip_edge+pin_1_indicator_size*1.5,-chip_edge+pin_1_indicator_size*1.5),
    r=pin_1_indicator_size,
    stroke_width = "2",
    stroke = "black",
    fill = "rgb(255,255,255)"))

dwg.save()
