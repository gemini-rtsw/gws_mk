[schematic2]
uniq 2
[tools]
[detail]
w -322 11 100 0 n#1 timer.timer#1.FLNK -392 40 -304 40 -304 0 -224 0 gwsPrecipitationIO.gwsPrecipitationIO#0.SLNK
s -800 288 100 0 The precipitation sensors are read from the GIS using channel access
[cell use]
use ba200tr -1056 -648 -100 0 frame
xform 0 -256 -24
use timer -576 -89 100 0 timer#1
xform 0 -480 0
p -586 -43 100 0 1 setdev:dev pt
p -586 -66 100 0 1 setd:delay 5
use gwsPrecipitationIO -224 -57 100 0 gwsPrecipitationIO#0
xform 0 -48 96
p -160 -53 100 0 1 setd:dev pt
p -160 -79 100 0 1 setov:onam on
p -160 -105 100 0 1 setzv:znam off
[comments]
