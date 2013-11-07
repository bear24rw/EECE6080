from PIL import Image

scale = 3

with open("logo.mag", "w") as f:
    f.write("magic\n")
    f.write("tech scmos\n")
    f.write("timestamp 1383824361\n")

    img = Image.open("logo.png")
    pix = img.load()

    f.write("<< metal1 >>\n")
    for x in range(img.size[0]):
        for y in range(img.size[1]):
            if pix[x,y][0] > 127 and pix[x,y][1] == 0:
                x1 = x*scale
                y1 = (img.size[1]-y)*scale
                x2 = (x+1)*scale
                y2 = ((img.size[1]-y)+1)*scale
                f.write("rect %d %d %d %d\n" % (x1, y1, x2, y2))

    f.write("<< metal2 >>\n")
    for x in range(img.size[0]):
        for y in range(img.size[1]):
            if pix[x,y][2] > 127 and pix[x,y][1] == 0:
                x1 = x*scale
                y1 = (img.size[1]-y)*scale
                x2 = (x+1)*scale
                y2 = ((img.size[1]-y)+1)*scale
                f.write("rect %d %d %d %d\n" % (x1, y1, x2, y2))

    f.write("<< end >>\n")
