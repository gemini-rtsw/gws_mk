[schematic2]
uniq 37
[tools]
[detail]
w 2112 907 100 0 FLNK snYoungIO.snYoungIO#29.FLNK 2016 896 2256 896 outhier.FLNK.p
w 1576 907 100 0 n#35 snYoungIO.snYoungIO#28.FLNK 1536 896 1664 896 snYoungIO.snYoungIO#29.SLNK
w 1096 907 100 0 n#34 snYoungIO.snYoungIO#27.FLNK 1056 896 1184 896 snYoungIO.snYoungIO#28.SLNK
w 600 907 100 0 SLNK inhier.SLNK.P 544 896 704 896 snYoungIO.snYoungIO#27.SLNK
s 1744 1088 100 0 Top End
s 1264 1088 100 0 +X
s 784 1088 100 0 -X
s 544 384 100 0 of the anemometer's address (e.g. A is 65)
s 544 416 100 0 decimal equivalent of the ASCII representation
s 544 448 100 0 Note: The address in the 'addr' property is the
s 1929 233 100 0 02/May/02
s 1906 266 100 0 Pedro Gigoux
s 2141 325 100 0 Young Ultrasonic Anemometers
s 2183 381 100 0 Gemini Weather Server
[cell use]
use snYoungIO 704 839 100 0 snYoungIO#27
xform 0 880 992
p 928 832 100 0 1 seta1:a1 $(yngamx)
p 704 768 100 0 1 setd:dev $(dev)Ua
p 704 832 100 0 1 setd1:d1 $(yngmx)
p 928 800 100 0 1 setda1:da1 $(yngdmx)
p 704 736 100 0 1 seten:evn $(yngevnmx)
p 704 704 100 0 1 setev:evv $(yngevvmx)
use snYoungIO 1184 839 100 0 snYoungIO#28
xform 0 1360 992
p 1408 832 100 0 1 seta1:a1 $(yngapx)
p 1184 768 100 0 1 setd:dev $(dev)Ua
p 1184 832 100 0 1 setd1:d1 $(yngpx)
p 1408 800 100 0 1 setda1:da1 $(yngdpx)
p 1184 736 100 0 1 seten:evn $(yngevnpx)
p 1184 704 100 0 1 setev:evv $(yngevvpx)
use snYoungIO 1664 839 100 0 snYoungIO#29
xform 0 1840 992
p 1888 832 100 0 1 seta1:a1 $(yngate)
p 1664 768 100 0 1 setd:dev $(dev)Ua
p 1664 832 100 0 1 setd1:d1 $(yngte)
p 1888 800 100 0 1 setda1:da1 $(yngdte)
p 1664 736 100 0 1 seten:evn $(yngevnte)
p 1664 704 100 0 1 setev:evv $(yngevvte)
use outhier 2224 855 100 0 FLNK
xform 0 2240 896
use inhier 528 855 100 0 SLNK
xform 0 544 896
use bb200tr 96 104 -100 0 frame
xform 0 1376 928
[comments]
