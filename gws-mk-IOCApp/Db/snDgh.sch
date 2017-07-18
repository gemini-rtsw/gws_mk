[schematic2]
uniq 4
[tools]
[detail]
w 824 939 100 0 n#1 snDghIO.snDghIO#47.FLNK 768 928 928 928 snDghIO.snDghIO#48.SLNK
w 2368 939 100 0 FLNK snDghIO.snDghIO#52.FLNK 2320 928 2464 928 outhier.FLNK.p
w 1856 939 100 0 n#2 snDghIO.snDghIO#49.FLNK 1792 928 1968 928 snDghIO.snDghIO#52.SLNK
w 1336 939 100 0 n#3 snDghIO.snDghIO#48.FLNK 1280 928 1440 928 snDghIO.snDghIO#49.SLNK
w 328 939 100 0 SLNK inhier.SLNK.P 288 928 416 928 snDghIO.snDghIO#47.SLNK
s 1917 233 100 0 03/May/02
s 1906 269 100 0 Pedro Gigoux
s 2226 325 100 0 DGH Sensors
s 2178 381 100 0 Gemini Weather Server
[cell use]
use bb200tr 96 104 -100 0 frame
xform 0 1376 928
use snDghIO 416 871 100 0 snDghIO#47
xform 0 592 1024
p 640 864 100 0 1 seta1:a1 $(dgha01)
p 640 832 100 0 1 seta2:a2 $(dgha02)
p 640 800 100 0 1 seta3:a3 $(dgha03)
p 640 768 100 0 1 seta4:a4 $(dgha04)
p 640 736 100 0 1 seta5:a5 $(dgha05)
p 416 640 100 0 1 setd:dev $(dev)
p 416 864 100 0 1 setd1:d1 $(dgh01)
p 416 832 100 0 1 setd2:d2 $(dgh02)
p 416 800 100 0 1 setd3:d3 $(dgh03)
p 416 768 100 0 1 setd4:d4 $(dgh04)
p 416 736 100 0 1 setd5:d5 $(dgh05)
p 416 704 100 0 1 seten:evn $(dghevn01)
p 416 672 100 0 1 setev:evv $(dghevv01)
use snDghIO 928 871 100 0 snDghIO#48
xform 0 1104 1024
p 1152 864 100 0 1 seta1:a1 $(dgha06)
p 1152 832 100 0 1 seta2:a2 $(dgha07)
p 1152 800 100 0 1 seta3:a3 $(dgha08)
p 1152 768 100 0 1 seta4:a4 $(dgha09)
p 1152 736 100 0 1 seta5:a5 $(dgha10)
p 928 640 100 0 1 setd:dev $(dev)
p 928 864 100 0 1 setd1:d1 $(dgh06)
p 928 832 100 0 1 setd2:d2 $(dgh07)
p 928 800 100 0 1 setd3:d3 $(dgh08)
p 928 768 100 0 1 setd4:d4 $(dgh09)
p 928 736 100 0 1 setd5:d5 $(dgh10)
p 928 704 100 0 1 seten:evn $(dghevn02)
p 928 672 100 0 1 setev:evv $(dghevv02)
use snDghIO 1440 871 100 0 snDghIO#49
xform 0 1616 1024
p 1664 864 100 0 1 seta1:a1 $(dgha11)
p 1664 832 100 0 1 seta2:a2 $(dgha12)
p 1664 800 100 0 1 seta3:a3 $(dgha13)
p 1664 768 100 0 1 seta4:a4 $(dgha14)
p 1664 736 100 0 1 seta5:a5 $(dgha15)
p 1440 640 100 0 1 setd:dev $(dev)
p 1440 864 100 0 1 setd1:d1 $(dgh11)
p 1440 832 100 0 1 setd2:d2 $(dgh12)
p 1440 800 100 0 1 setd3:d3 $(dgh13)
p 1440 768 100 0 1 setd4:d4 $(dgh14)
p 1440 736 100 0 1 setd5:d5 $(dgh15)
p 1440 704 100 0 1 seten:evn $(dghevn03)
p 1440 672 100 0 1 setev:evv $(dghevv03)
use snDghIO 1968 871 100 0 snDghIO#52
xform 0 2144 1024
p 2192 864 100 0 1 seta1:a1 $(dgha16)
p 2192 832 100 0 1 seta2:a2 $(dgha17)
p 2192 800 100 0 1 seta3:a3 $(dgha18)
p 2192 768 100 0 1 seta4:a4 $(dgha19)
p 2192 736 100 0 1 seta5:a5 $(dgha20)
p 1968 640 100 0 1 setd:dev $(dev)
p 1968 864 100 0 1 setd1:d1 $(dgh16)
p 1968 832 100 0 1 setd2:d2 $(dgh17)
p 1968 800 100 0 1 setd3:d3 $(dgh18)
p 1968 768 100 0 1 setd4:d4 $(dgh19)
p 1968 736 100 0 1 setd5:d5 $(dgh20)
p 1968 704 100 0 1 seten:evn $(dghevn04)
p 1968 672 100 0 1 setev:evv $(dghevv04)
use outhier 2432 887 100 0 FLNK
xform 0 2448 928
use inhier 272 887 100 0 SLNK
xform 0 288 928
[comments]
