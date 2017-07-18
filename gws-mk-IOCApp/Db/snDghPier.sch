[schematic2]
uniq 60
[tools]
[detail]
w 1200 939 100 0 FLNK snDghIO.snDghIO#47.FLNK 1152 928 1296 928 outhier.FLNK.p
w 712 939 100 0 SLNK inhier.SLNK.P 672 928 800 928 snDghIO.snDghIO#47.SLNK
s 1917 233 100 0 03/May/02
s 1906 269 100 0 Pedro Gigoux
s 2226 325 100 0 DGH Sensors
s 2178 381 100 0 Gemini Weather Server
[cell use]
use snDghIO 800 871 100 0 snDghIO#47
xform 0 976 1024
p 1024 864 100 0 1 seta1:a1 $(dgha21)
p 1024 832 100 0 1 seta2:a2 $(dgha22)
p 1024 800 100 0 1 seta3:a3 $(dgha23)
p 1024 768 100 0 1 seta4:a4 $(dgha24)
p 1024 736 100 0 1 seta5:a5 $(dgha25)
p 800 640 100 0 1 setd:dev $(dev)
p 800 864 100 0 1 setd1:d1 $(dgh21)
p 800 832 100 0 1 setd2:d2 $(dgh22)
p 800 800 100 0 1 setd3:d3 $(dgh23)
p 800 768 100 0 1 setd4:d4 $(dgh24)
p 800 736 100 0 1 setd5:d5 $(dgh25)
p 800 704 100 0 1 seten:evn $(dghevn05)
p 800 672 100 0 1 setev:evv $(dghevv05)
use outhier 1264 887 100 0 FLNK
xform 0 1280 928
use inhier 656 887 100 0 SLNK
xform 0 672 928
use bb200tr 96 104 -100 0 frame
xform 0 1376 928
[comments]
