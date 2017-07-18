[schematic2]
uniq 16
[tools]
[detail]
w 1060 1979 100 2 n#15 hwin.hwin#14.in 1056 1984 1056 1984 esirs.esirs#4.INP
w 1060 1563 100 2 n#13 hwin.hwin#12.in 1056 1568 1056 1568 esirs.esirs#5.INP
w 100 1147 100 2 n#11 hwin.hwin#10.in 96 1152 96 1152 esirs.esirs#3.INP
w 100 1563 100 2 n#9 hwin.hwin#8.in 96 1568 96 1568 esirs.esirs#1.INP
w 100 1979 100 2 n#7 hwin.hwin#6.in 96 1984 96 1984 esirs.esirs#0.INP
[cell use]
use hwin -96 1943 100 0 hwin#6
xform 0 0 1984
p -128 2016 100 0 -1 val(in):$(ws)wsTemp
use hwin -96 1527 100 0 hwin#8
xform 0 0 1568
p -176 1600 100 0 -1 val(in):$(ws)wsWindSpeed
use hwin -96 1111 100 0 hwin#10
xform 0 0 1152
p -160 1184 100 0 -1 val(in):$(ws)wsWindDir
use hwin 864 1527 100 0 hwin#12
xform 0 960 1568
p 816 1600 100 0 -1 val(in):$(ws)wsHumid
use hwin 864 1943 100 0 hwin#14
xform 0 960 1984
p 832 2016 100 0 -1 val(in):$(ws)wsPress
use bb200tr -416 616 -100 0 frame
xform 0 864 1440
use esirs 96 1735 100 0 esirs#0
xform 0 304 1888
p 256 1824 100 0 1 EGU:C
p 256 1856 100 0 1 FTVL:DOUBLE
p 160 1696 100 0 1 SCAN:10 second
p 240 1728 100 1024 -1 name:$(top)outTemp
use esirs 96 1319 100 0 esirs#1
xform 0 304 1472
p 256 1408 100 0 1 EGU:m/s
p 256 1440 100 0 1 FTVL:DOUBLE
p 160 1280 100 0 1 SCAN:10 second
p 272 1312 100 1024 -1 name:$(top)outWindSpeed
use esirs 96 903 100 0 esirs#3
xform 0 304 1056
p 256 992 100 0 1 EGU:degrees
p 256 1024 100 0 1 FTVL:DOUBLE
p 160 864 100 0 1 SCAN:10 second
p 240 896 100 1024 -1 name:$(top)outWindDir
use esirs 1056 1735 100 0 esirs#4
xform 0 1264 1888
p 1216 1824 100 0 1 EGU:hPa
p 1216 1856 100 0 1 FTVL:DOUBLE
p 1120 1696 100 0 1 SCAN:10 second
p 1200 1728 100 1024 -1 name:$(top)outPress
use esirs 1056 1319 100 0 esirs#5
xform 0 1264 1472
p 1216 1408 100 0 1 EGU:%
p 1216 1440 100 0 1 FTVL:DOUBLE
p 1120 1280 100 0 1 SCAN:10 second
p 1200 1312 100 1024 -1 name:$(top)outHumid
[comments]
