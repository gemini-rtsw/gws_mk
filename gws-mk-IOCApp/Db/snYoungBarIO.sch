[schematic2]
uniq 5
[tools]
[detail]
w 2720 1571 100 0 FLNK snYoungBarVal.snYoungBarVal#307.FLNK 2656 1568 2784 1568 outhier.FLNK.p
w 672 1891 100 0 n#1 next1.next1#246.FLNK 608 1888 736 1888 736 1048 2216 1048 2216 1568 2304 1568 snYoungBarVal.snYoungBarVal#307.SLNK
w 128 1763 100 0 SLNK inhier.SLNK.P 32 1760 224 1760 224 1888 352 1888 next1.next1#246.SLNK
w 1296 2019 100 0 n#2 wsYoungBarRec.wsYoungBarRec#308.FLNK 1280 2016 1312 2016 1312 2144 320 2144 320 1984 352 1984 next1.next1#246.SLNK1
w 816 1987 100 0 n#3 next1.next1#246.FLNK1 608 1984 816 1984 816 1800 928 1800 wsYoungBarRec.wsYoungBarRec#308.SLNK
w 355 1955 100 2 n#4 hwin.hwin#248.in 352 1952 352 1952 next1.next1#246.DISA1
s 2289 524 100 0 Pedro Gigoux
s 2306 489 100 0 26/Apr/02
s 2507 579 100 0 Young Ultrasonic Anemometer Sensor
s 2576 640 100 0 Gemini Weather Server
s 2368 1413 100 0 VALA Pressure
s 2368 1378 100 0 VALJ Health
s 2371 1347 100 0 VALK Error message
s 2372 1312 100 0 VALL Processing delay
s 640 2240 100 0 Commands to the Young barometric sensor are of the form M<address)!
s 640 2208 100 0 No return or linefeed is needed
[cell use]
use bc200tr -320 360 -100 0 frame
xform 0 1360 1664
use snYoungBarVal 2304 1511 100 0 snYoungBarVal#307
xform 0 2480 1760
p 2368 1504 100 0 1 seta:event $(evv)
use hwin 160 1911 100 0 hwin#248
xform 0 256 1952
p -147 1943 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.DISA
use next1 352 1831 100 0 next1#246
xform 0 480 1936
p 368 1832 100 0 1 seta:src $(dev)n$(d1)
p 370 1806 100 0 1 setb:event $(evn)
use outhier 2752 1527 100 0 FLNK
xform 0 2768 1568
use inhier 16 1719 100 0 SLNK
xform 0 32 1760
use wsYoungBarRec 928 1760 100 0 wsYoungBarRec#308
xform 0 1104 1920
p 1000 1920 100 0 -1 set2:top $(top)$(dev)$(d1)
p 1000 1888 100 0 -1 set3:SCAN Passive
p 1000 1824 100 0 -1 set5:CHAN $(a1)
p 1000 1952 100 0 -1 set1:PORT $(port)
[comments]
