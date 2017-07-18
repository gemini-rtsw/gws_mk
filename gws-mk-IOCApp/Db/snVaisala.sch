[schematic2]
uniq 25
[tools]
[detail]
w 1672 843 100 0 FLNK snVaisalaIO.snVaisalaIO#22.FLNK 1600 832 1792 832 outhier.FLNK.p
w 1144 843 100 0 SLNK inhier.SLNK.P 1088 832 1248 832 snVaisalaIO.snVaisalaIO#22.SLNK
s 1772 494 100 0 Gemini Weather Server
s 1751 438 100 0 Vaisala Humidity Sensors
s 1489 383 100 0 Pedro Gigoux
s 1506 345 100 0 05/May/02
[cell use]
use snVaisalaIO 1248 775 100 0 snVaisalaIO#22
xform 0 1424 928
p 1472 768 100 0 1 seta1:a1 $(vslapx)
p 1248 672 100 0 1 setd:dev $(dev)Hs
p 1248 768 100 0 1 setd1:d1 $(vslpx)
p 1248 736 100 0 1 seten:evn $(vslevnpx)
p 1248 704 100 0 1 setev:evv $(vslevvpx)
use ba200tr 640 216 -100 0 frame
xform 0 1440 840
use outhier 1760 791 100 0 FLNK
xform 0 1776 832
use inhier 1072 791 100 0 SLNK
xform 0 1088 832
[comments]
