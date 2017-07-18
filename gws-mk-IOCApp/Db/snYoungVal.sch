[schematic2]
uniq 13
[tools]
[detail]
w 1744 1539 100 0 n#1 estringouts.estringouts#343.FLNK 1696 1536 1792 1536 1792 1344 1344 1344 1344 1024 1440 1024 esirs.esirs#164.SLNK
w 2032 1187 100 0 n#2 esirs.esirs#164.FLNK 1856 1184 2208 1184 2208 1216 2400 1216 eaos.eaos#313.SLNK
w 1744 1763 100 0 n#3 eaos.eaos#267.FLNK 1696 1760 1792 1760 1792 1600 1344 1600 1344 1520 1440 1520 estringouts.estringouts#343.SLNK
w 1744 1987 100 0 n#4 eaos.eaos#204.FLNK 1696 1984 1792 1984 1792 1824 1344 1824 1344 1728 1440 1728 eaos.eaos#267.SLNK
w 1744 2275 100 0 n#5 eaos.eaos#114.FLNK 1696 2272 1792 2272 1792 2048 1344 2048 1344 1952 1440 1952 eaos.eaos#204.SLNK
w 2672 2147 100 0 n#6 eaos.eaos#309.FLNK 2656 2144 2688 2144 2688 2208 2304 2208 2304 2336 2400 2336 eaos.eaos#308.SLNK
w 2672 1923 100 0 n#7 eaos.eaos#310.FLNK 2656 1920 2688 1920 2688 1984 2304 1984 2304 2112 2400 2112 eaos.eaos#309.SLNK
w 2672 1699 100 0 n#8 eaos.eaos#311.FLNK 2656 1696 2688 1696 2688 1760 2304 1760 2304 1888 2400 1888 eaos.eaos#310.SLNK
w 2672 1475 100 0 n#9 eaos.eaos#312.FLNK 2656 1472 2688 1472 2688 1536 2304 1536 2304 1664 2400 1664 eaos.eaos#311.SLNK
w 2672 1251 100 0 n#10 eaos.eaos#313.FLNK 2656 1248 2688 1248 2688 1312 2304 1312 2304 1440 2400 1440 eaos.eaos#312.SLNK
w 1296 1187 100 0 HLTH1 hwin.hwin#344.in 1152 1184 1440 1184 esirs.esirs#164.INP
w 304 1923 100 0 n#11 hwin.hwin#141.in 288 1920 320 1920 320 1888 416 1888 eevents.eevents#140.INP
w 256 1859 100 0 SLNK inhier.SLNK.P 96 1856 416 1856 eevents.eevents#140.SLNK
w 776 1891 100 0 FLNK eevents.eevents#140.FLNK 704 1888 848 1888 outhier.FLNK.p
w 1186 1562 -100 0 n#12 hwin.hwin#346.in 1184 1552 1440 1552 estringouts.estringouts#343.DOL
s 2570 640 100 0 Gemini Weather Sensor
s 2511 580 100 0 Young Anemometer Health & Values
s 2281 523 100 0 Pedro Gigoux
s 2299 489 100 0 26/Jul/02
[cell use]
use bc200tr -320 360 -100 0 frame
xform 0 1360 1664
use estringouts 1440 1447 100 0 estringouts#343
xform 0 1568 1520
p 1376 1326 100 0 0 OMSL:closed_loop
p 1552 1440 100 1024 -1 name:$(top)$(dev)$(d1)Err
use inhier 80 1815 100 0 SLNK
xform 0 96 1856
use eaos 2400 2247 100 0 eaos#308
xform 0 2528 2336
p 2480 2368 100 0 1 EGU:m/s
p 2144 2318 100 0 0 OMSL:closed_loop
p 2480 2288 100 0 1 PREC:2
p 2512 2240 100 1024 -1 name:$(top)$(dev)$(d1)Speed2D
use eaos 1440 1863 100 0 eaos#204
xform 0 1568 1952
p 1520 1984 100 0 1 EGU:m/s
p 1184 1934 100 0 0 OMSL:closed_loop
p 1520 1904 100 0 1 PREC:2
p 1568 1856 100 1024 -1 name:$(top)$(dev)$(d1)SpeedV
use eaos 1440 2151 100 0 eaos#114
xform 0 1568 2240
p 1520 2272 100 0 1 EGU:m/s
p 1504 2080 100 0 1 EVNT:$(event)
p 1184 2222 100 0 0 OMSL:closed_loop
p 1520 2192 100 0 1 PREC:2
p 1504 2112 100 0 1 SCAN:Event
p 1552 2144 100 1024 -1 name:$(top)$(dev)$(d1)SpeedU
use eaos 1440 1639 100 0 eaos#267
xform 0 1568 1728
p 1520 1760 100 0 1 EGU:m/s
p 1184 1710 100 0 0 OMSL:closed_loop
p 1520 1680 100 0 1 PREC:2
p 1568 1632 100 1024 -1 name:$(top)$(dev)$(d1)SpeedW
use eaos 2400 2023 100 0 eaos#309
xform 0 2528 2112
p 2480 2144 100 0 1 EGU:m/s
p 2144 2094 100 0 0 OMSL:closed_loop
p 2480 2064 100 0 1 PREC:2
p 2512 2016 100 1024 -1 name:$(top)$(dev)$(d1)Speed3D
use eaos 2400 1799 100 0 eaos#310
xform 0 2528 1888
p 2480 1920 100 0 1 EGU:degrees
p 2144 1870 100 0 0 OMSL:closed_loop
p 2480 1840 100 0 1 PREC:2
p 2512 1792 100 1024 -1 name:$(top)$(dev)$(d1)WindAz
use eaos 2400 1575 100 0 eaos#311
xform 0 2528 1664
p 2480 1696 100 0 1 EGU:degrees
p 2144 1646 100 0 0 OMSL:closed_loop
p 2480 1616 100 0 1 PREC:2
p 2512 1568 100 1024 -1 name:$(top)$(dev)$(d1)WindEl
use eaos 2400 1351 100 0 eaos#312
xform 0 2528 1440
p 2480 1472 100 0 1 EGU:m/s
p 2144 1422 100 0 0 OMSL:closed_loop
p 2480 1392 100 0 1 PREC:2
p 2512 1344 100 1024 -1 name:$(top)$(dev)$(d1)SoS
use eaos 2400 1127 100 0 eaos#313
xform 0 2528 1216
p 2480 1248 100 0 1 EGU:C
p 2480 1168 100 0 1 PREC:2
p 2512 1120 100 1024 -1 name:$(top)$(dev)$(d1)Temp
use esirs 1440 935 100 0 esirs#164
xform 0 1648 1088
p 1568 1024 100 0 1 FTVL:LONG
p 1568 1056 100 0 1 SNAM:healthSir
p 1552 928 100 1024 -1 name:$(top)$(dev)$(d1)Hlth
use hwin 96 1879 100 0 hwin#141
xform 0 192 1920
p 99 1912 100 0 -1 val(in):$(event)
use eevents 416 1767 100 0 eevents#140
xform 0 560 1856
p 528 1760 100 1024 -1 name:$(top)$(dev)$(d1)evn
use outhier 816 1847 100 0 FLNK
xform 0 832 1888
use hwin 960 1168 100 0 hwin#344
xform 0 1056 1184
p 904 1201 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.SEVR
use hwin 992 1536 100 0 hwin#346
xform 0 1088 1552
p 936 1569 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.STAT
[comments]
