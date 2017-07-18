[schematic2]
uniq 16
[tools]
[detail]
w 308 2451 100 0 ERR1 hwin.hwin#220.in 168 2448 448 2448 estringouts.estringouts#197.DOL
w 312 2099 100 0 ERR2 hwin.hwin#218.in 176 2096 448 2096 estringouts.estringouts#201.DOL
w 344 1747 100 0 ERR3 hwin.hwin#212.in 240 1744 448 1744 estringouts.estringouts#200.DOL
w 332 1395 100 0 ERR4 hwin.hwin#214.in 216 1392 448 1392 estringouts.estringouts#199.DOL
w 332 1043 100 0 ERR5 hwin.hwin#216.in 216 1040 448 1040 estringouts.estringouts#198.DOL
w 752 2083 100 0 n#1 estringouts.estringouts#201.FLNK 704 2080 800 2080 800 2240 352 2240 352 2416 448 2416 estringouts.estringouts#197.SLNK
w 752 1027 100 0 n#2 estringouts.estringouts#198.FLNK 704 1024 800 1024 800 1184 352 1184 352 1360 448 1360 estringouts.estringouts#199.SLNK
w 752 1379 100 0 n#3 estringouts.estringouts#199.FLNK 704 1376 800 1376 800 1536 352 1536 352 1712 448 1712 estringouts.estringouts#200.SLNK
w 752 1731 100 0 n#4 estringouts.estringouts#200.FLNK 704 1728 800 1728 800 1888 352 1888 352 2064 448 2064 estringouts.estringouts#201.SLNK
w 880 2435 100 0 n#5 estringouts.estringouts#197.FLNK 704 2432 1056 2432 1056 2464 1248 2464 eaos.eaos#110.SLNK
w 1104 1091 100 0 VAL5 inhier.VAL5.P 960 1088 1248 1088 eaos.eaos#114.DOL
w 1988 1251 100 0 HLTH5 hwin.hwin#210.in 1896 1248 2080 1248 esirs.esirs#168.INP
w 1968 1603 100 0 HLTH4 hwin.hwin#208.in 1856 1600 2080 1600 esirs.esirs#167.INP
w 1992 1955 100 0 HLTH3 hwin.hwin#206.in 1904 1952 2080 1952 esirs.esirs#166.INP
w 2008 2307 100 0 HLTH2 hwin.hwin#204.in 1936 2304 2080 2304 esirs.esirs#165.INP
w 2048 2659 100 0 HLTH1 hwin.hwin#202.in 2016 2656 2080 2656 esirs.esirs#164.INP
w 1104 1443 100 0 VAL4 inhier.VAL4.P 960 1440 1248 1440 eaos.eaos#113.DOL
w 1104 2147 100 0 VAL2 inhier.VAL2.P 960 2144 1248 2144 eaos.eaos#111.DOL
w 1104 1795 100 0 VAL3 inhier.VAL3.P 960 1792 1248 1792 eaos.eaos#112.DOL
w 1104 2499 100 0 VAL1 inhier.VAL1.P 960 2496 1248 2496 eaos.eaos#110.DOL
w 1792 1091 100 0 n#6 eaos.eaos#114.FLNK 1504 1088 2080 1088 esirs.esirs#168.SLNK
w 1040 771 100 0 n#7 hwin.hwin#141.in 1024 768 1056 768 1056 736 1152 736 eevents.eevents#140.INP
w 992 707 100 0 SLNK inhier.SLNK.P 832 704 1152 704 eevents.eevents#140.SLNK
w 1552 1443 100 0 n#8 eaos.eaos#113.FLNK 1504 1440 1600 1440 1600 1184 1152 1184 1152 1056 1248 1056 eaos.eaos#114.SLNK
w 1552 2499 100 0 n#9 eaos.eaos#110.FLNK 1504 2496 1600 2496 1600 2240 1152 2240 1152 2112 1248 2112 eaos.eaos#111.SLNK
w 1552 1795 100 0 n#10 eaos.eaos#112.FLNK 1504 1792 1600 1792 1600 1536 1152 1536 1152 1408 1248 1408 eaos.eaos#113.SLNK
w 1552 2147 100 0 n#11 eaos.eaos#111.FLNK 1504 2144 1600 2144 1600 1888 1152 1888 1152 1760 1248 1760 eaos.eaos#112.SLNK
w 2512 2307 100 0 n#12 esirs.esirs#165.FLNK 2496 2304 2528 2304 2528 2368 1984 2368 1984 2496 2080 2496 esirs.esirs#164.SLNK
w 2512 1955 100 0 n#13 esirs.esirs#166.FLNK 2496 1952 2528 1952 2528 2016 1984 2016 1984 2144 2080 2144 esirs.esirs#165.SLNK
w 2512 1603 100 0 n#14 esirs.esirs#167.FLNK 2496 1600 2528 1600 2528 1664 1984 1664 1984 1792 2080 1792 esirs.esirs#166.SLNK
w 2512 1251 100 0 n#15 esirs.esirs#168.FLNK 2496 1248 2528 1248 2528 1312 1984 1312 1984 1440 2080 1440 esirs.esirs#167.SLNK
w 1512 739 100 0 FLNK eevents.eevents#140.FLNK 1440 736 1584 736 outhier.FLNK.p
[cell use]
use bc200tr -320 360 -100 0 frame
xform 0 1360 1664
use inhier 944 1399 100 0 VAL4
xform 0 960 1440
use inhier 944 1751 100 0 VAL3
xform 0 960 1792
use inhier 944 2103 100 0 VAL2
xform 0 960 2144
use inhier 944 2455 100 0 VAL1
xform 0 960 2496
use inhier 816 663 100 0 SLNK
xform 0 832 704
use inhier 944 1047 100 0 VAL5
xform 0 960 1088
use estringouts 448 1991 100 0 estringouts#201
xform 0 576 2064
p 384 1870 100 0 0 OMSL:closed_loop
p 560 1984 100 1024 -1 name:$(top)$(dev)$(d2)Err
use estringouts 448 1639 100 0 estringouts#200
xform 0 576 1712
p 384 1518 100 0 0 OMSL:closed_loop
p 560 1632 100 1024 -1 name:$(top)$(dev)$(d3)Err
use estringouts 448 1287 100 0 estringouts#199
xform 0 576 1360
p 384 1166 100 0 0 OMSL:closed_loop
p 560 1280 100 1024 -1 name:$(top)$(dev)$(d4)Err
use estringouts 448 935 100 0 estringouts#198
xform 0 576 1008
p 448 864 100 0 1 EVNT:$(event)
p 384 814 100 0 0 OMSL:closed_loop
p 448 896 100 0 1 SCAN:Event
p 560 928 100 1024 -1 name:$(top)$(dev)$(d5)Err
use estringouts 448 2343 100 0 estringouts#197
xform 0 576 2416
p 448 2272 100 0 0 EVNT:0
p 384 2222 100 0 0 OMSL:closed_loop
p 448 2304 100 0 0 SCAN:Passive
p 560 2336 100 1024 -1 name:$(top)$(dev)$(d1)Err
use esirs 2080 2407 100 0 esirs#164
xform 0 2288 2560
p 2208 2496 100 0 1 FTVL:LONG
p 2208 2528 100 0 1 SNAM:healthSir
p 2192 2400 100 1024 -1 name:$(top)$(dev)$(d1)Hlth
use esirs 2080 2055 100 0 esirs#165
xform 0 2288 2208
p 2208 2144 100 0 1 FTVL:LONG
p 2208 2176 100 0 1 SNAM:healthSir
p 2192 2048 100 1024 -1 name:$(top)$(dev)$(d2)Hlth
use esirs 2080 1703 100 0 esirs#166
xform 0 2288 1856
p 2208 1792 100 0 1 FTVL:LONG
p 2208 1824 100 0 1 SNAM:healthSir
p 2192 1696 100 1024 1 name:$(top)$(dev)$(d3)Hlth
use esirs 2080 1351 100 0 esirs#167
xform 0 2288 1504
p 2208 1440 100 0 1 FTVL:LONG
p 2208 1472 100 0 1 SNAM:healthSir
p 2192 1344 100 1024 -1 name:$(top)$(dev)$(d4)Hlth
use esirs 2080 999 100 0 esirs#168
xform 0 2288 1152
p 2208 1088 100 0 1 FTVL:LONG
p 2208 1120 100 0 1 SNAM:healthSir
p 2192 992 100 1024 -1 name:$(top)$(dev)$(d5)Hlth
use hwin 832 727 100 0 hwin#141
xform 0 928 768
p 835 760 100 0 -1 val(in):$(event)
use eevents 1152 615 100 0 eevents#140
xform 0 1296 704
p 1264 608 100 1024 -1 name:$(top)$(dev)$(d1)evn
use eaos 1248 967 100 0 eaos#114
xform 0 1376 1056
p 1328 1088 100 0 1 EGU:C
p 992 1038 100 0 0 OMSL:closed_loop
p 1328 1008 100 0 1 PREC:2
p 1360 960 100 1024 -1 name:$(top)$(dev)$(d5)
use eaos 1248 1319 100 0 eaos#113
xform 0 1376 1408
p 1328 1440 100 0 1 EGU:C
p 992 1390 100 0 0 OMSL:closed_loop
p 1328 1360 100 0 1 PREC:2
p 1360 1312 100 1024 -1 name:$(top)$(dev)$(d4)
use eaos 1248 1671 100 0 eaos#112
xform 0 1376 1760
p 1328 1792 100 0 1 EGU:C
p 992 1742 100 0 0 OMSL:closed_loop
p 1328 1712 100 0 1 PREC:2
p 1360 1664 100 1024 -1 name:$(top)$(dev)$(d3)
use eaos 1248 2023 100 0 eaos#111
xform 0 1376 2112
p 1328 2144 100 0 1 EGU:C
p 992 2094 100 0 0 OMSL:closed_loop
p 1328 2064 100 0 1 PREC:2
p 1360 2016 100 1024 -1 name:$(top)$(dev)$(d2)
use eaos 1248 2375 100 0 eaos#110
xform 0 1376 2464
p 1328 2496 100 0 1 EGU:C
p 1264 2304 100 0 1 EVNT:$(event)
p 992 2446 100 0 0 OMSL:closed_loop
p 1328 2416 100 0 1 PREC:2
p 1264 2336 100 0 1 SCAN:Event
p 1360 2368 100 1024 -1 name:$(top)$(dev)$(d1)
use outhier 1552 695 100 0 FLNK
xform 0 1568 736
use hwin 1824 2640 100 0 hwin#202
xform 0 1920 2656
p 1728 2673 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.SEVR
use hwin 1744 2288 100 0 hwin#204
xform 0 1840 2304
p 1648 2321 100 0 -1 val(in):$(top)$(dev)$(d2)Raw.SEVR
use hwin 1712 1936 100 0 hwin#206
xform 0 1808 1952
p 1616 1969 100 0 -1 val(in):$(top)$(dev)$(d3)Raw.SEVR
use hwin 1664 1584 100 0 hwin#208
xform 0 1760 1600
p 1568 1617 100 0 -1 val(in):$(top)$(dev)$(d4)Raw.SEVR
use hwin 1704 1232 100 0 hwin#210
xform 0 1800 1248
p 1608 1265 100 0 -1 val(in):$(top)$(dev)$(d5)Raw.SEVR
use hwin 48 1728 100 0 hwin#212
xform 0 144 1744
p -48 1761 100 0 -1 val(in):$(top)$(dev)$(d3)Raw.STAT
use hwin 24 1376 100 0 hwin#214
xform 0 120 1392
p -72 1409 100 0 -1 val(in):$(top)$(dev)$(d4)Raw.STAT
use hwin 24 1024 100 0 hwin#216
xform 0 120 1040
p -72 1057 100 0 -1 val(in):$(top)$(dev)$(d5)Raw.STAT
use hwin -16 2080 100 0 hwin#218
xform 0 80 2096
p -112 2113 100 0 -1 val(in):$(top)$(dev)$(d2)Raw.STAT
use hwin -24 2432 100 0 hwin#220
xform 0 72 2448
p -120 2465 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.STAT
[comments]
