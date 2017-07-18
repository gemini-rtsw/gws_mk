[schematic2]
uniq 5
[tools]
[detail]
w 2720 1571 100 0 FLNK snYoungVal.snYoungVal#259.FLNK 2656 1568 2784 1568 outhier.FLNK.p
w 688 1891 100 0 n#1 next1.next1#246.FLNK 608 1888 768 1888 768 1568 2304 1568 snYoungVal.snYoungVal#259.SLNK
w 128 1763 100 0 SLNK inhier.SLNK.P 32 1760 224 1760 224 1888 352 1888 next1.next1#246.SLNK
w 1296 2019 100 0 n#2 wsYoungRec.wsYoungRec#285.FLNK 1280 2016 1312 2016 1312 2144 320 2144 320 1984 352 1984 next1.next1#246.SLNK1
w 712 1987 100 0 n#3 next1.next1#246.FLNK1 608 1984 816 1984 816 1800 928 1800 wsYoungRec.wsYoungRec#285.SLNK
w 355 1955 100 2 n#4 hwin.hwin#248.in 352 1952 352 1952 next1.next1#246.DISA1
s 2289 524 100 0 Pedro Gigoux
s 2306 489 100 0 26/Apr/02
s 2507 579 100 0 Young Ultrasonic Anemometer Sensor
s 2576 640 100 0 Gemini Weather Server
s 2368 1413 100 0 VALA Wind speed U component (m/s)
s 2369 1379 100 0 VALB Wind speed V component (m/s)
s 2370 1346 100 0 VALC Wind speed W component (m/s)
s 2370 1316 100 0 VALD 2D wind speed (m/s)
s 2370 1283 100 0 VALE 3D wind speed (m/s)
s 2372 1249 100 0 VALF Azimuth (degrees)
s 2373 1219 100 0 VALG Elevation (m/s)
s 2372 1185 100 0 VALH Speed of sound (m/s)
s 2370 1155 100 0 VALI Sonic temperature (C)
s 2370 1122 100 0 VALJ Health
s 2373 1091 100 0 VALK Error message
s 2374 1056 100 0 VALL Processing delay
s 640 2240 100 0 Commands to the Young anemometers are of the form M<address)!
s 640 2208 100 0 No return or linefeed is needed
[cell use]
use bc200tr -320 360 -100 0 frame
xform 0 1360 1664
use hwin 160 1911 100 0 hwin#248
xform 0 256 1952
p -147 1943 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.DISA
use snYoungVal 2304 1479 100 0 snYoungVal#259
xform 0 2480 1760
p 2384 1520 100 0 1 seta:event $(evv)
use next1 352 1831 100 0 next1#246
xform 0 480 1936
p 368 1832 100 0 1 seta:src $(dev)n$(d1)
p 370 1806 100 0 1 setb:event $(evn)
use outhier 2752 1527 100 0 FLNK
xform 0 2768 1568
use inhier 16 1719 100 0 SLNK
xform 0 32 1760
use wsYoungRec 928 1760 100 0 wsYoungRec#285
xform 0 1104 1920
p 1000 1920 100 0 -1 set2:top $(top)$(dev)$(d1)
p 1000 1888 100 0 -1 set3:SCAN Passive
p 1000 1824 100 0 -1 set5:CHAN $(a1)
p 1000 1952 100 0 -1 set1:PORT $(port)
[comments]
