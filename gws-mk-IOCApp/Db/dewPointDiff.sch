[schematic2]
uniq 8
[tools]
[detail]
w 422 235 100 0 FLNK ecalcs.ecalcs#0.FLNK 288 224 592 224 outhier.FLNK.p
w 366 203 100 0 DIFF ecalcs.ecalcs#0.VAL 288 192 480 192 outhier.DIFF.p
w -114 11 100 0 SLNK inhier.SLNK.P -192 0 0 0 ecalcs.ecalcs#0.SLNK
w -120 331 100 0 DEWT inhier.DEWT.P -192 320 0 320 ecalcs.ecalcs#0.INPC
w -114 395 100 0 TEMP inhier.TEMP.P -192 384 0 384 ecalcs.ecalcs#0.INPA
[cell use]
use outhier 448 151 100 0 DIFF
xform 0 464 192
use outhier 560 183 100 0 FLNK
xform 0 576 224
use ba200tr -704 -568 -100 0 frame
xform 0 96 56
use inhier -208 343 100 0 TEMP
xform 0 -192 384
use inhier -208 279 100 0 DEWT
xform 0 -192 320
use inhier -208 -41 100 0 SLNK
xform 0 -192 0
use ecalcs 0 -89 100 0 ecalcs#0
xform 0 144 176
p 96 224 100 0 1 CALC:A-C
p 176 -160 100 0 1 LLSV:MAJOR
p 0 -160 100 0 1 LOLO:$(lolo)
p 0 -128 100 0 1 LOW:$(low)
p 176 -128 100 0 1 LSV:MINOR
p 112 -96 100 1024 -1 name:$(name)
[comments]
