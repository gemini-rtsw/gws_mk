[schematic2]
uniq 39
[tools]
[detail]
w 552 235 100 0 n#34 estringinval.estringinval#36.VAL 480 224 672 224 esirs.esirs#23.INP
w 584 75 100 0 n#33 estringinval.estringinval#36.FLNK 480 192 544 192 544 64 672 64 esirs.esirs#23.SLNK
w 584 491 100 0 n#30 eais.eais#26.FLNK 480 832 544 832 544 480 672 480 ecalcs.ecalcs#17.SLNK
w 552 875 100 0 n#29 eais.eais#26.VAL 480 864 672 864 ecalcs.ecalcs#17.INPA
s 1224 -368 100 0 15/Dec/2006
s 1216 -334 100 0 Pedro Gigoux
s 1486 -276 100 0 Water Vapour Interface
s 1489 -219 100 0 Gemini Weather Server
[cell use]
use estringinval 224 281 100 0 estringinval#36
xform 6 352 208
p 336 128 100 1024 -1 name:$(top)pwvStat
use eais 224 921 100 0 eais#26
xform 6 352 848
p 256 736 100 0 1 PINI:YES
p 320 768 100 1024 -1 name:$(top)pwvRaw
use bb200tr -608 -504 -100 0 frame
xform 0 672 320
use esirs 672 -25 100 0 esirs#23
xform 0 880 128
p 832 128 100 0 1 FTVL:LONG
p 784 -32 100 1024 -1 name:$(top)pwvHealth
use ecalcs 672 391 100 0 ecalcs#17
xform 0 816 656
p 736 352 100 0 1 CALC:A
p 736 320 100 0 1 EGU:mm
p 736 288 100 0 1 PREC:3
p 784 384 100 1024 -1 name:$(top)pwv
[comments]
