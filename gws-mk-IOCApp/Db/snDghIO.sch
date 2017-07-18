[schematic2]
uniq 22
[tools]
[detail]
w 2768 963 100 0 FLNK snDghVal.snDghVal#174.FLNK 2688 960 2848 960 outhier.FLNK.p
w 611 2211 100 2 n#1 next5.next5#210.DISA5 608 2208 608 2208 hwin.hwin#18.in
w 611 2339 100 2 n#2 next5.next5#210.DISA1 608 2336 608 2336 hwin.hwin#10.in
w 896 2147 100 0 n#3 next5.next5#210.FLNK 864 2144 928 2144 928 960 2336 960 snDghVal.snDghVal#174.SLNK
w 1996 1035 100 0 n#4 wsDhgRec.wsDhgRec#219.TEMP 1880 1032 2112 1032 2112 1312 2336 1312 snDghVal.snDghVal#174.VAL5
w 2012 1371 100 0 n#5 wsDhgRec.wsDhgRec#217.TEMP 1880 1368 2144 1368 2144 1344 2336 1344 snDghVal.snDghVal#174.VAL4
w 2028 1715 100 0 n#6 wsDhgRec.wsDhgRec#215.TEMP 1880 1712 2176 1712 2176 1376 2336 1376 snDghVal.snDghVal#174.VAL3
w 2044 2067 100 0 n#7 wsDhgRec.wsDhgRec#213.TEMP 1880 2064 2208 2064 2208 1408 2344 1408 snDghVal.snDghVal#174.VAL2
w 2056 2411 100 0 n#8 wsDhgRec.wsDhgRec#211.TEMP 1880 2408 2240 2408 2240 1440 2336 1440 snDghVal.snDghVal#174.VAL1
w 1924 2587 100 0 n#9 wsDhgRec.wsDhgRec#211.FLNK 1880 2584 1976 2584 1976 2832 576 2832 576 2528 608 2528 next5.next5#210.SLNK1
w 1928 2243 100 0 n#10 wsDhgRec.wsDhgRec#213.FLNK 1872 2240 1984 2240 1984 2688 544 2688 544 2496 608 2496 next5.next5#210.SLNK2
w 912 2275 100 0 n#11 next5.next5#210.FLNK5 864 2272 960 2272 960 1000 1528 1000 wsDhgRec.wsDhgRec#219.SLNK
w 944 2339 100 0 n#12 next5.next5#210.FLNK4 864 2336 1024 2336 1024 1336 1528 1336 wsDhgRec.wsDhgRec#217.SLNK
w 976 2403 100 0 n#13 next5.next5#210.FLNK3 864 2400 1088 2400 1088 1680 1528 1680 wsDhgRec.wsDhgRec#215.SLNK
w 1008 2467 100 0 n#14 next5.next5#210.FLNK2 864 2464 1152 2464 1152 2032 1528 2032 wsDhgRec.wsDhgRec#213.SLNK
w 1044 2531 100 0 n#15 next5.next5#210.FLNK1 864 2528 1224 2528 1224 2376 1528 2376 wsDhgRec.wsDhgRec#211.SLNK
w 352 2147 100 0 SLNK inhier.SLNK.P 96 2144 608 2144 next5.next5#210.SLNK
w 544 2243 100 0 n#16 hwin.hwin#17.in 480 2240 608 2240 next5.next5#210.DISA4
w 472 2275 100 0 n#17 hwin.hwin#14.in 336 2272 608 2272 next5.next5#210.DISA3
w 544 2307 100 0 n#18 hwin.hwin#12.in 480 2304 608 2304 next5.next5#210.DISA2
w 1980 1211 100 0 n#19 wsDhgRec.wsDhgRec#219.FLNK 1880 1208 2080 1208 2080 2784 448 2784 448 2400 608 2400 next5.next5#210.SLNK5
w 1964 1547 100 0 n#20 wsDhgRec.wsDhgRec#217.FLNK 1880 1544 2048 1544 2048 2752 480 2752 480 2432 608 2432 next5.next5#210.SLNK4
w 1948 1891 100 0 n#21 wsDhgRec.wsDhgRec#215.FLNK 1880 1888 2016 1888 2016 2720 512 2720 512 2464 608 2464 next5.next5#210.SLNK3
s 2336 768 100 0 VALK - VALO Error messages
s 2176 2640 100 0 Commands to the DHS boxes are of the form $<address>RD\r
s 2384 2256 100 0 All Waveform records have:
s 2384 2224 100 0 FTVL = UCHAR
s 2384 2192 100 0 NELM = $(nmax)
s 2384 2160 100 0 DTYP = Stream
s 2576 640 100 0 Gemini Weather Server
s 2608 576 100 0 DGH Sensor I/O
s 2301 488 100 0 26/Apr/02
s 2287 525 100 0 Pedro Gigoux
s 2336 832 100 0 VALA - VALE Temperature values
s 2336 800 100 0 VALF - VALJ Healths
s 2336 736 100 0 VALP - VALT Processing delays
[cell use]
use bc200tr -320 360 -100 0 frame
xform 0 1360 1664
use next5 608 2087 100 0 next5#210
xform 0 736 2336
p 625 2087 100 0 1 seta:src $(dev)n$(d1)
p 625 2060 100 0 1 setb:event $(evn)
use outhier 2816 919 100 0 FLNK
xform 0 2832 960
use snDghVal 2336 983 100 0 snDghVal#174
xform 0 2512 1200
p 2400 896 100 0 1 seta:event $(evv)
use hwin 416 2295 100 0 hwin#10
xform 0 512 2336
p 107 2332 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.DISA
use hwin 288 2263 100 0 hwin#12
xform 0 384 2304
p -21 2299 100 0 -1 val(in):$(top)$(dev)$(d2)Raw.DISA
use hwin 144 2231 100 0 hwin#14
xform 0 240 2272
p -164 2263 100 0 -1 val(in):$(top)$(dev)$(d3)Raw.DISA
use hwin 288 2199 100 0 hwin#17
xform 0 384 2240
p -23 2230 100 0 -1 val(in):$(top)$(dev)$(d4)Raw.DISA
use hwin 416 2167 100 0 hwin#18
xform 0 512 2208
p 105 2197 100 0 -1 val(in):$(top)$(dev)$(d5)Raw.DISA
use inhier 80 2103 100 0 SLNK
xform 0 96 2144
use wsDhgRec 1528 2360 100 0 wsDhgRec#211
xform 0 1704 2512
p 1600 2504 100 0 -1 set2:top $(top)$(dev)$(d1)
p 1600 2472 100 0 -1 set3:SCAN Passive
p 1600 2408 100 0 -1 set5:CHAN $(a1)
p 1600 2536 100 0 -1 set1:PORT $(port)
use wsDhgRec 1528 2016 100 0 wsDhgRec#213
xform 0 1704 2168
p 1600 2160 100 0 -1 set2:top $(top)$(dev)$(d2)
p 1600 2128 100 0 -1 set3:SCAN Passive
p 1600 2064 100 0 -1 set5:CHAN $(a2)
p 1600 2192 100 0 -1 set1:PORT $(port)
use wsDhgRec 1528 1664 100 0 wsDhgRec#215
xform 0 1704 1816
p 1600 1808 100 0 -1 set2:top $(top)$(dev)$(d3)
p 1600 1776 100 0 -1 set3:SCAN Passive
p 1600 1712 100 0 -1 set5:CHAN $(a3)
p 1600 1840 100 0 -1 set1:PORT $(port)
use wsDhgRec 1528 1320 100 0 wsDhgRec#217
xform 0 1704 1472
p 1600 1464 100 0 -1 set2:top $(top)$(dev)$(d4)
p 1600 1432 100 0 -1 set3:SCAN Passive
p 1600 1368 100 0 -1 set5:CHAN $(a4)
p 1600 1496 100 0 -1 set1:PORT $(port)
use wsDhgRec 1528 984 100 0 wsDhgRec#219
xform 0 1704 1136
p 1600 1128 100 0 -1 set2:top $(top)$(dev)$(d5)
p 1600 1096 100 0 -1 set3:SCAN Passive
p 1600 1032 100 0 -1 set5:CHAN $(a5)
p 1600 1160 100 0 -1 set1:PORT $(port)
[comments]
