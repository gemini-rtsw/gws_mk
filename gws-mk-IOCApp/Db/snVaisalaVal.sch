[schematic2]
uniq 10
[tools]
[detail]
w 1904 1027 100 0 n#1 estringouts.estringouts#308.FLNK 1856 1024 1952 1024 1952 896 1504 896 1504 672 1600 672 esirs.esirs#164.SLNK
w 1904 1251 100 0 n#2 eaos.eaos#267.FLNK 1856 1248 1952 1248 1952 1088 1504 1088 1504 1008 1600 1008 estringouts.estringouts#308.SLNK
w 1904 1699 100 0 n#3 eaos.eaos#114.FLNK 1856 1696 1952 1696 1952 1536 1504 1536 1504 1440 1600 1440 eaos.eaos#204.SLNK
w 1904 1475 100 0 n#4 eaos.eaos#204.FLNK 1856 1472 1952 1472 1952 1312 1504 1312 1504 1216 1600 1216 eaos.eaos#267.SLNK
w 1904 1923 100 0 n#5 eaos.eaos#113.FLNK 1856 1920 1952 1920 1952 1760 1504 1760 1504 1664 1600 1664 eaos.eaos#114.SLNK
w 1904 2147 100 0 n#6 eaos.eaos#112.FLNK 1856 2144 1952 2144 1952 1984 1504 1984 1504 1888 1600 1888 eaos.eaos#113.SLNK
w 1904 2371 100 0 n#7 eaos.eaos#111.FLNK 1856 2368 1952 2368 1952 2208 1504 2208 1504 2112 1600 2112 eaos.eaos#112.SLNK
w 1904 2659 100 0 n#8 eaos.eaos#110.FLNK 1856 2656 1952 2656 1952 2432 1504 2432 1504 2336 1600 2336 eaos.eaos#111.SLNK
w 304 1923 100 0 n#9 hwin.hwin#141.in 288 1920 320 1920 320 1888 416 1888 eevents.eevents#140.INP
w 292 1859 100 0 SLNK inhier.SLNK.P 160 1856 416 1856 eevents.eevents#140.SLNK
w 776 1891 100 0 FLNK eevents.eevents#140.FLNK 704 1888 848 1888 outhier.FLNK.p
w 1440 1043 100 0 ERR hwin.hwin#309.in 1280 1040 1600 1040 estringouts.estringouts#308.DOL
w 1440 835 100 0 HLTH1 hwin.hwin#311.in 1280 832 1600 832 esirs.esirs#164.INP
s 1984 1008 100 0 Error message
s 2298 487 100 0 26/Jul/02
s 2283 524 100 0 Pedro Gigoux
s 1984 1216 100 0 Dew Point Difference
s 1984 1440 100 0 Wet Bulb Temperature
s 1984 1664 100 0 Mixing Ratio
s 1984 1888 100 0 Absolute Humidity
s 1984 2624 100 0 Relative Humidity
s 1984 2336 100 0 Temperature
s 1984 2112 100 0 Dew Point
s 2560 640 100 0 Gemini Weather Server
s 2496 576 90 0 Vaisala Humidity Sensor Health & Values
[cell use]
use bc200tr -320 360 -100 0 frame
xform 0 1360 1664
use estringouts 1600 935 100 0 estringouts#308
xform 0 1728 1008
p 1536 814 100 0 0 OMSL:closed_loop
p 1712 928 100 1024 -1 name:$(top)$(dev)$(d1)Err
use eaos 1600 1351 100 0 eaos#204
xform 0 1728 1440
p 1680 1472 100 0 1 EGU:C
p 1344 1422 100 0 0 OMSL:closed_loop
p 1680 1392 100 0 1 PREC:2
p 1728 1344 100 1024 -1 name:$(top)$(dev)$(d1)Tw
use eaos 1600 2535 100 0 eaos#110
xform 0 1728 2624
p 1680 2656 100 0 1 EGU:%
p 1616 2464 100 0 1 EVNT:$(event)
p 1344 2606 100 0 0 OMSL:closed_loop
p 1680 2576 100 0 1 PREC:2
p 1616 2496 100 0 1 SCAN:Event
p 1712 2528 100 1024 -1 name:$(top)$(dev)$(d1)Rh
use eaos 1600 2247 100 0 eaos#111
xform 0 1728 2336
p 1680 2368 100 0 1 EGU:C
p 1344 2318 100 0 0 OMSL:closed_loop
p 1680 2288 100 0 1 PREC:2
p 1712 2240 100 1024 -1 name:$(top)$(dev)$(d1)T
use eaos 1600 2023 100 0 eaos#112
xform 0 1728 2112
p 1680 2144 100 0 1 EGU:C
p 1344 2094 100 0 0 OMSL:closed_loop
p 1680 2064 100 0 1 PREC:2
p 1712 2016 100 1024 -1 name:$(top)$(dev)$(d1)Td
use eaos 1600 1799 100 0 eaos#113
xform 0 1728 1888
p 1680 1920 100 0 1 EGU:g/m3
p 1344 1870 100 0 0 OMSL:closed_loop
p 1680 1840 100 0 1 PREC:2
p 1712 1792 100 1024 -1 name:$(top)$(dev)$(d1)A
use eaos 1600 1575 100 0 eaos#114
xform 0 1728 1664
p 1680 1696 100 0 1 EGU:g/Kg
p 1344 1646 100 0 0 OMSL:closed_loop
p 1680 1616 100 0 1 PREC:2
p 1712 1568 100 1024 -1 name:$(top)$(dev)$(d1)X
use eaos 1600 1127 100 0 eaos#267
xform 0 1728 1216
p 1680 1248 100 0 1 EGU:C
p 1344 1198 100 0 0 OMSL:closed_loop
p 1680 1168 100 0 1 PREC:2
p 1728 1120 100 1024 -1 name:$(top)$(dev)$(d1)Dt
use inhier 144 1815 100 0 SLNK
xform 0 160 1856
use esirs 1600 583 100 0 esirs#164
xform 0 1808 736
p 1728 672 100 0 1 FTVL:LONG
p 1728 704 100 0 1 SNAM:healthSir
p 1712 576 100 1024 -1 name:$(top)$(dev)$(d1)Hlth
use hwin 96 1879 100 0 hwin#141
xform 0 192 1920
p 99 1912 100 0 -1 val(in):$(event)
use eevents 416 1767 100 0 eevents#140
xform 0 560 1856
p 528 1760 100 1024 -1 name:$(top)$(dev)$(d1)evn
use outhier 816 1847 100 0 FLNK
xform 0 832 1888
use hwin 1088 1024 100 0 hwin#309
xform 0 1184 1040
p 1037 1063 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.STAT
use hwin 1088 816 100 0 hwin#311
xform 0 1184 832
p 1037 855 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.SEVR
[comments]
