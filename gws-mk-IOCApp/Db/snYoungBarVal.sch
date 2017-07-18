[schematic2]
uniq 4
[tools]
[detail]
w 1296 1987 100 0 ERR hwin.hwin#344.in 1152 1984 1440 1984 estringouts.estringouts#343.DOL
w 1744 1971 100 0 n#1 estringouts.estringouts#343.FLNK 1696 1968 1792 1968 1792 1776 1344 1776 1344 1456 1440 1456 esirs.esirs#164.SLNK
w 1744 2275 100 0 n#2 eaos.eaos#114.FLNK 1696 2272 1792 2272 1792 2048 1344 2048 1344 1952 1440 1952 estringouts.estringouts#343.SLNK
w 1296 1619 100 0 HLTH1 hwin.hwin#346.in 1152 1616 1440 1616 esirs.esirs#164.INP
w 304 1923 100 0 n#3 hwin.hwin#141.in 288 1920 320 1920 320 1888 416 1888 eevents.eevents#140.INP
w 256 1859 100 0 SLNK inhier.SLNK.P 96 1856 416 1856 eevents.eevents#140.SLNK
w 776 1891 100 0 FLNK eevents.eevents#140.FLNK 704 1888 848 1888 outhier.FLNK.p
s 2299 489 100 0 26/Jul/02
s 2281 523 100 0 Pedro Gigoux
s 2511 580 100 0 Young Anemometer Health & Values
s 2570 640 100 0 Gemini Weather Sensor
[cell use]
use bc200tr -320 360 -100 0 frame
xform 0 1360 1664
use inhier 80 1815 100 0 SLNK
xform 0 96 1856
use estringouts 1440 1879 100 0 estringouts#343
xform 0 1568 1952
p 1376 1758 100 0 0 OMSL:closed_loop
p 1552 1872 100 1024 -1 name:$(top)$(dev)$(d1)Err
use eaos 1440 2151 100 0 eaos#114
xform 0 1568 2240
p 1520 2272 100 0 0 EGU:
p 1504 2080 100 0 1 EVNT:$(event)
p 1184 2222 100 0 0 OMSL:closed_loop
p 1520 2192 100 0 1 PREC:2
p 1504 2112 100 0 1 SCAN:Event
p 1552 2144 100 1024 -1 name:$(top)$(dev)$(d1)Pressure
use esirs 1440 1367 100 0 esirs#164
xform 0 1648 1520
p 1568 1456 100 0 1 FTVL:LONG
p 1568 1488 100 0 1 SNAM:healthSir
p 1552 1360 100 1024 -1 name:$(top)$(dev)$(d1)Hlth
use hwin 96 1879 100 0 hwin#141
xform 0 192 1920
p 99 1912 100 0 -1 val(in):$(event)
use eevents 416 1767 100 0 eevents#140
xform 0 560 1856
p 528 1760 100 1024 -1 name:$(top)$(dev)$(d1)evn
use outhier 816 1847 100 0 FLNK
xform 0 832 1888
use hwin 960 1968 100 0 hwin#344
xform 0 1056 1984
p 892 2006 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.STAT
use hwin 960 1600 100 0 hwin#346
xform 0 1056 1616
p 892 1638 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.NSEV
[comments]
