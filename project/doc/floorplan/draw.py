import svgwrite

pins_per_side = 10

pin_length = 60
pin_width = pin_length / 2
pin_spacing = pin_length / 5
edge_to_pin = pin_length / 2
pin_1_indicator_size = pin_length / 2

dwg = svgwrite.Drawing("floorplan.svg")
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


#
# PIN SLICES
#

pin = dwg.defs.add(dwg.g(id="pin"))

def draw_rect_txt_pin(x, y, w, h, t):
    pin.add(rect(x, y, w, h))
    pin.add(txt(x+(w/2), y+(h/2), t, center_vert=True, anchor="middle", size="0.5em"))

slice_height = 12
slice_width = 2*slice_height
slice_space = slice_height - 3

# pin slices
for y in range(15):
    for x in range(15):
        draw_rect_txt_pin(x*slice_width,
                      -1*y*(slice_height+slice_space),
                      slice_width,
                      slice_height,
                      "P%d" % (x+y*15))

# shifter
for x in range(15):
        _x = x*slice_width
        draw_rect_txt_pin(_x,
                      2*slice_height,
                      slice_width,
                      slice_height,
                      "S%d" % x)
# shift to pin
for x in range(15):
    _x = x*slice_width
    pin.add(dwg.line(start=(_x+slice_width/2, slice_height),
                       end=(_x+slice_width/2, 2*slice_height),
                       stroke="black"))

# W veritcle lines
for y in range(14):
    for x in range(15):
        _x = x*slice_width
        pin.add(dwg.line(start=(_x+slice_width/2, -y*(slice_height+slice_space)),
                           end=(_x+slice_width/2, -(y*(slice_height+slice_space))-slice_space),
                           stroke="black"))


# slice row connects
for y in range(14):
    #_y = y*(slice_height + slice_space/2.0)
    _y = y * (slice_height+slice_space) + slice_space/2.0
    _y *= -1
    l = -5
    r = 15*slice_width+5
    u = _y-slice_space/2.0-slice_height/2.0 + slice_height/3./2.
    d = _y+slice_space/2.0+slice_height/2.0 - slice_height/3./2.
    pin.add(dwg.line(start=(l, _y), end=(r, _y), stroke="black"))
    pin.add(dwg.line(start=(l, _y), end=(l, u), stroke="black"))
    pin.add(dwg.line(start=(r, _y), end=(r, d), stroke="black"))
    pin.add(dwg.line(start=(l, u), end=(l+5, u), stroke="black"))
    pin.add(dwg.line(start=(r, d), end=(r-5, d), stroke="black"))

# pin output right
m = 1.5
for y in range(15):
    r = 15*slice_width
    _y = -y*(slice_height+slice_space) + slice_height - slice_height/3.
    pin.add(dwg.line(start=(r, _y), end=(r+10+y*m, _y), stroke="black"))

# pin output down
for y in range(15):
    r = 15*slice_width
    _y = -y*(slice_height+slice_space) + slice_height - slice_height/3.
    _y2 = 3*slice_height + y*m + 5
    pin.add(dwg.line(start=(r+10+y*m, _y2), end=(r+10+y*m, _y), stroke="black"))

# shift input down
for x in range(15):
    _x = x*slice_width + slice_width/2.0
    _y = 3*slice_height
    _y2 = _y + (14-x)*m + 5
    pin.add(dwg.line(start=(_x, _y), end=(_x, _y2), stroke="black"))

# shift input right
for x in range(15):
    _x = x*slice_width + slice_width/2.0
    _y = 3*slice_height
    _y2 = _y + (14-x)*m + 5
    _x2 = 15*slice_width + m*(14-x) + 10
    pin.add(dwg.line(start=(_x2, _y2), end=(_x, _y2), stroke="black"))

# pin clock output left
m = 1.5
for y in range(15):
    _y = -y*(slice_height+slice_space) + slice_height/3.
    pin.add(dwg.line(start=(0, _y), end=(-10, _y), stroke="black"))

# pin clock down
pin.add(dwg.line(start=(-10,(-14*(slice_height+slice_space))+slice_height/3.), end=(-10, 0), stroke="black"))

# pin mux
draw_rect_txt_pin(-slice_width - slice_space/2,
                  0,
                  slice_width,
                  slice_height+slice_height,
                  "MUX")

# to mux
pin.add(dwg.line(start=(-slice_space/2, slice_height-slice_height*1/3.), end=(0, slice_height-slice_height*1/3.), stroke="black"))
#pin.add(dwg.line(start=(-slice_space/2, slice_height-slice_height*2/3.), end=(0, slice_height-slice_height*2/3.), stroke="black"))

# to end of shifter
pin.add(dwg.line(start=(-slice_space/2, slice_height+slice_height*1/3.), end=(15*slice_width+06, slice_height+slice_height*1/3.), stroke="black"))
pin.add(dwg.line(start=(-slice_space/2, slice_height+slice_height*2/3.), end=(15*slice_width+03, slice_height+slice_height*2/3.), stroke="black"))

# coming out of shift right
pin.add(dwg.line(start=(15*slice_width, 2*slice_height+slice_height*1/3.), end=(15*slice_width+03, 2*slice_height+slice_height*1/3.), stroke="black"))
pin.add(dwg.line(start=(15*slice_width, 2*slice_height+slice_height*2/3.), end=(16.7*slice_width, 2*slice_height+slice_height*2/3.), stroke="black"))

# going up to mux
pin.add(dwg.line(start=(16.7*slice_width, 2*slice_height+slice_height*2/3.), end=(16.7*slice_width, 2*slice_height+slice_height*2/3.-1.75*slice_height), stroke="black"))
# going down to mux
pin.add(dwg.line(start=(16.7*slice_width, -14*(slice_height+slice_space)+slice_height/3.), end=(16.7*slice_width, 2*slice_height+slice_height*2/3.-1.75*slice_height), stroke="black"))
# going over to PSO
pin.add(dwg.line(start=(15*slice_width, -14*(slice_height+slice_space)+slice_height/3.), end=(16.7*slice_width, -14*(slice_height+slice_space)+slice_height/3.), stroke="black"))

# comping out of shifter up
pin.add(dwg.line(start=(15*slice_width+03, 2*slice_height+slice_height*1/3.), end=(15*slice_width+03, slice_height+slice_height*2/3.), stroke="black"))
pin.add(dwg.line(start=(15*slice_width+06, 2*slice_height+slice_height*2/3.), end=(15*slice_width+06, slice_height+slice_height*1/3.), stroke="black"))


u = dwg.use(pin)
u.translate(-15*slice_width/2.0, 9*slice_height)
dwg.add(u)

def draw_rect_txt(x, y, w, h, t):
    dwg.add(rect(x, y, w, h))
    dwg.add(txt(x+(w/2), y+(h/2), t, center_vert=True, anchor="middle", size="0.5em"))

# so mux

_x = chip_edge - slice_space - pin_width/3.
#_y = 4*pin_width  + pin_width/2.
_y = 3*(pin_width + pin_spacing) - pin_spacing/2.
w = pin_width
h = pin_width/3.

so_group = dwg.defs.add(dwg.g(id="so_mux"))
so_group.add(rect(0,0,w,h))
so_group.add(txt(0+(w/2), 0+(h/2), "MUX", center_vert=True, anchor="middle", size="0.5em"))
u = dwg.use(so_group)
u.translate(_x,_y)
u.rotate(270)
dwg.add(u)

#dwg.add(dwg.line(start=(0, 0), end=(1000, 0), stroke="black"))

draw_rect_txt(-5*(pin_width+pin_spacing)+(pin_spacing/2.0),
               chip_edge - slice_height*2 - slice_space,
               2*pin_width+pin_spacing,
               slice_height*2,
               "Test Inverter")

draw_rect_txt(-3*(pin_width+pin_spacing)+(pin_spacing/2.0),
               chip_edge - slice_height*2 - slice_space,
               3*pin_width+2*pin_spacing,
               slice_height*2,
               "Test DFF")

draw_rect_txt(-5*(pin_width+pin_spacing)+(pin_spacing/2.0),
               -chip_edge +  slice_space,
               4*pin_width+3*pin_spacing,
               slice_height*2,
               "Test PIN Slice")

draw_rect_txt(0*(pin_width+pin_spacing)+(pin_spacing/2.0),
               -chip_edge +  slice_space,
               5*pin_width+4*pin_spacing,
               slice_height*2,
               "Test PIN Slice")

dwg.save()
