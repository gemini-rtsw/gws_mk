[schematic2]
uniq 5
[tools]
[detail]
w 2784 1635 100 0 FLNK snDatalogVal.snDatalogVal#277.FLNK 2720 1632 2848 1632 outhier.FLNK.p
w 680 1891 100 0 n#1 next1.next1#246.FLNK 608 1888 752 1888 752 1472 2368 1472 snDatalogVal.snDatalogVal#277.SLNK
w 128 1763 100 0 SLNK inhier.SLNK.P 32 1760 224 1760 224 1888 352 1888 next1.next1#246.SLNK
w 1296 2019 100 0 n#2 wsVaisLogRec.wsVaisLogRec#278.FLNK 1280 2016 1312 2016 1312 2144 320 2144 320 1984 352 1984 next1.next1#246.SLNK1
w 712 1987 100 0 n#3 next1.next1#246.FLNK1 608 1984 816 1984 816 1800 928 1800 wsVaisLogRec.wsVaisLogRec#278.SLNK
w 355 1955 100 2 n#4 hwin.hwin#248.in 352 1952 352 1952 next1.next1#246.DISA1
s 2289 524 100 0 Pedro Gigoux
s 2306 489 100 0 26/Apr/02
s 2563 577 100 0 Vaisala Datalogger
s 2576 640 100 0 Gemini Weather Server
s 384 2208 100 0 Commands to the Datalogger are of the form 'READ\r' with no address
[cell use]
use bc200tr -320 360 -100 0 frame
xform 0 1360 1664
use snDatalogVal 2368 1431 100 0 snDatalogVal#277
xform 0 2544 1720
p 2416 1424 100 0 1 seta:event $(evv)
use hwin 160 1911 100 0 hwin#248
xform 0 256 1952
p -153 1943 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.DISA
use next1 352 1831 100 0 next1#246
xform 0 480 1936
p 368 1832 100 0 1 seta:src $(dev)n$(d1)
p 370 1806 100 0 1 setb:event $(evn)
use outhier 2816 1591 100 0 FLNK
xform 0 2832 1632
use inhier 16 1719 100 0 SLNK
xform 0 32 1760
use wsVaisLogRec 928 1760 100 0 wsVaisLogRec#278
xform 0 1104 1920
p 1000 1920 100 0 -1 set2:top $(top)$(dev)$(d1)
p 1000 1888 100 0 -1 set3:SCAN Passive
p 1000 1952 100 0 -1 set1:PORT $(port)
[comments]
