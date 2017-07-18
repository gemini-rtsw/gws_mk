[schematic2]
uniq 5
[tools]
[detail]
w 2720 1635 100 0 FLNK snVaisalaVal.snVaisalaVal#234.FLNK 2656 1632 2784 1632 outhier.FLNK.p
w 688 1891 100 0 n#1 next1.next1#246.FLNK 608 1888 768 1888 768 1632 2312 1632 snVaisalaVal.snVaisalaVal#234.SLNK
w 128 1763 100 0 SLNK inhier.SLNK.P 32 1760 224 1760 224 1888 352 1888 next1.next1#246.SLNK
w 1296 2019 100 0 n#2 wsVaisHumRec.wsVaisHumRec#249.FLNK 1280 2016 1312 2016 1312 2144 320 2144 320 1984 352 1984 next1.next1#246.SLNK1
w 712 1987 100 0 n#3 next1.next1#246.FLNK1 608 1984 816 1984 816 1784 928 1784 wsVaisHumRec.wsVaisHumRec#249.SLNK
w 355 1955 100 2 n#4 hwin.hwin#248.in 352 1952 352 1952 next1.next1#246.DISA1
s 2374 1191 100 0 VALJ Processing delay
s 2375 1222 100 0 VALI Error message
s 2371 1252 100 0 VALH Health
s 2372 1285 100 0 VALG Dew temperature difference (C)
s 2371 1316 100 0 VALF Wet bulb temperature (C)
s 2371 1346 100 0 VALE Mixing ratio (g/Kg)
s 2371 1345 100 0 VALE Mixing ratio (g/Kg)
s 2369 1378 100 0 VALD Absolute humidity (g/m^3)
s 2368 1412 100 0 VALC Dew point temperature (C)
s 2369 1442 100 0 VALB Temperature (C)
s 2368 1475 100 0 VALA Relative humidity (%)
s 2289 524 100 0 Pedro Gigoux
s 2306 489 100 0 26/Apr/02
s 2563 577 100 0 Vaisala Humidity Sensor
s 2576 640 100 0 Gemini Weather Server
s 384 2208 100 0 Commands to the Vaisala hunity sensor are of the form 'SEND <address>\r'
[cell use]
use bc200tr -320 360 -100 0 frame
xform 0 1360 1664
use hwin 160 1911 100 0 hwin#248
xform 0 256 1952
p -153 1943 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.DISA
use next1 352 1831 100 0 next1#246
xform 0 480 1936
p 368 1832 100 0 1 seta:src $(dev)n$(d1)
p 370 1806 100 0 1 setb:event $(evn)
use snVaisalaVal 2304 1591 100 0 snVaisalaVal#234
xform 0 2480 1792
p 2368 1584 100 0 1 seta:event $(evv)
use outhier 2752 1591 100 0 FLNK
xform 0 2768 1632
use inhier 16 1719 100 0 SLNK
xform 0 32 1760
use wsVaisHumRec 928 1760 100 0 wsVaisHumRec#249
xform 0 1104 1920
p 1000 1920 100 0 -1 set2:top $(top)$(dev)$(d1)
p 1000 1888 100 0 -1 set3:SCAN Passive
p 1000 1824 100 0 -1 set5:CHAN $(a1)
p 1000 1952 100 0 -1 set1:PORT $(port)
[comments]
