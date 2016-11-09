#!/usr/bin/python

import Image
import os.path
import sys

def thumb(ori):
    ws = [ 40, 58, 60, 87, 80, 120, 180 ]
    for w in ws:
        img = Image.open(ori)
        img.thumbnail((w, w), Image.ANTIALIAS)
        saveToPath = ori[:-4] + "-" + str(w) + ".png"
        img.save(saveToPath, "png")

if __name__ == '__main__':
    thumb(sys.argv[1])
