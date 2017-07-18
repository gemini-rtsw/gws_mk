[schematic2]
uniq 101
[tools]
[detail]
w 1202 1227 100 0 n#100 eseqs.eseqs#48.LNK2 1056 544 1152 544 1152 1216 1312 1216 esirs.esirs#2.SLNK
w 1096 523 100 0 n#99 eseqs.eseqs#48.LNK3 1056 512 1184 512 1184 800 1312 800 esirs.esirs#93.SLNK
w 552 523 100 0 n#92 ecad4.ecad4#84.VALB 160 320 416 320 416 512 736 512 eseqs.eseqs#48.DOL3
w 740 475 100 2 n#91 hwin.hwin#50.in 736 480 736 480 eseqs.eseqs#48.DOL4
w 1112 491 100 0 n#76 eseqs.eseqs#48.LNK4 1056 480 1216 480 junction
w 1288 -117 100 0 n#76 eseqs.eseqs#67.LNK2 1248 -128 1376 -128 1376 -96 junction
w 1272 139 100 0 n#76 eseqs.eseqs#67.LNK1 1248 -96 1376 -96 1376 128 1216 128 1216 576 junction
w 1176 587 100 0 n#76 eseqs.eseqs#48.LNK1 1056 576 1344 576 ecars.ecars#65.IVAL
w -424 235 100 0 n#90 hwin.hwin#89.in -736 64 -640 64 -640 224 -160 224 ecad4.ecad4#84.INPC
w 184 107 100 0 n#88 ecad4.ecad4#84.FLNK 160 96 256 96 simMask.simMask#46.SLNK
w -156 155 100 2 n#85 hwin.hwin#3.in -160 160 -160 160 ecad4.ecad4#84.INPD
w 536 555 100 0 n#64 ecad4.ecad4#84.VALA 160 384 384 384 384 544 736 544 eseqs.eseqs#48.DOL2
w 1696 587 100 0 stat ecars.ecars#65.VAL 1664 576 1776 576 outhier.stat.p
w 1696 363 100 0 flnk ecars.ecars#65.FLNK 1664 352 1776 352 outhier.flnk.p
w 1696 523 100 0 mess ecars.ecars#65.OMSS 1664 512 1776 512 outhier.mess.p
w 536 171 100 0 n#72 simMask.simMask#46.FULL 480 160 640 160 junction
w 536 203 100 0 n#72 simMask.simMask#46.FAST 480 192 640 192 junction
w 760 -405 100 0 n#72 simMask.simMask#46.VSM 480 224 640 224 640 -416 928 -416 eseqs.eseqs#67.SLNK
w 932 -101 100 2 n#71 hwin.hwin#68.in 928 -96 928 -96 eseqs.eseqs#67.DOL1
w 932 -133 100 2 n#70 hwin.hwin#69.in 928 -128 928 -128 eseqs.eseqs#67.DOL2
w 584 267 100 0 n#63 simMask.simMask#46.NONE 480 256 736 256 eseqs.eseqs#48.SLNK
w 740 571 100 2 n#52 hwin.hwin#49.in 736 576 736 576 eseqs.eseqs#48.DOL1
w -344 459 100 0 n#32 estringouts.estringouts#22.OUT -384 448 -256 448 -256 384 -160 384 ecad4.ecad4#84.A
w -816 475 100 0 n#31 embbos.embbos#86.FLNK -848 464 -736 464 -736 432 -640 432 estringouts.estringouts#22.SLNK
w -768 411 100 0 n#30 embbos.embbos#86.VAL -848 400 -640 400 estringouts.estringouts#22.DOL
s 1552 -640 100 0 Gemini Weather Server
s 1536 -704 100 0 Particle Monitor Configuration
s 1280 -752 100 0 Pedro Gigoux
s 1287 -791 100 0 30/Dec/04
s -96 704 100 0 A Particle size
s -96 672 100 0 B Sampling time
[cell use]
use esirs 1312 711 100 0 esirs#93
xform 0 1520 864
p 1376 672 100 0 1 FTVL:LONG
p 1472 704 100 1024 -1 name:$(top)metTime
use esirs 1312 1127 100 0 esirs#2
xform 0 1520 1280
p 1376 1088 100 0 1 FTVL:LONG
p 1376 1056 100 0 1 SNAM:metSizeSir
p 1504 1120 100 1024 1 name:$(top)metSize
use hwin 736 -169 100 0 hwin#69
xform 0 832 -128
p 739 -136 100 0 -1 val(in):$(IDLE)
use hwin 736 -137 100 0 hwin#68
xform 0 832 -96
p 739 -104 100 0 -1 val(in):$(BUSY)
use hwin 544 439 100 0 hwin#50
xform 0 640 480
p 547 472 100 0 -1 val(in):$(IDLE)
use hwin 544 535 100 0 hwin#49
xform 0 640 576
p 547 568 100 0 -1 val(in):$(BUSY)
use hwin -352 119 100 0 hwin#3
xform 0 -256 160
p -544 160 100 0 -1 val(in):$(top)debugLevel
use hwin -928 23 100 0 hwin#89
xform 0 -832 64
p -1136 48 100 0 -1 val(in):$(top)tp4TmrGs.A
use embbos -1104 343 100 0 embbos#86
xform 0 -976 432
p -496 32 100 0 0 FFVL:0
p -1088 224 100 0 0 FRST:
p -432 32 100 0 0 FRVL:0
p -1088 288 100 0 1 ONST:1.0 micron
p -867 287 100 0 1 ONVL:1
p -1088 224 100 0 1 THST:5.0 micron
p -864 224 100 0 1 THVL:3
p -1088 256 100 0 1 TWST:2.0 micron
p -867 256 100 0 1 TWVL:2
p -1089 316 100 0 1 ZRST:0.5 micron
p -865 316 100 0 1 ZRVL:0
p -992 336 100 1024 -1 name:$(top)metSetupSize
use ecad4 -160 -121 100 0 ecad4#84
xform 0 0 256
p -32 384 100 0 1 FTVA:LONG
p -32 320 100 0 1 FTVB:LONG
p -96 -160 100 0 1 SNAM:metSetupCad
p 0 -128 100 1024 -1 name:$(top)metSetupCad
use bc200tr -1344 -920 -100 0 frame
xform 0 336 384
use eseqs 928 -505 100 0 eseqs#67
xform 0 1088 -256
p 992 -544 100 0 1 DLY2:0.5
p 1104 -512 100 1024 -1 name:$(top)metSetupNotNone
p 896 -96 75 1280 -1 pproc(DOL1):NPP
p 896 -128 75 1280 -1 pproc(DOL2):NPP
p 1264 -96 75 1024 -1 pproc(LNK1):PP
p 1264 -128 75 1024 -1 pproc(LNK2):PP
use eseqs 736 167 100 0 eseqs#48
xform 0 896 416
p 800 128 100 0 1 DLY2:0.5
p 800 96 100 0 1 DLY3:1.0
p 800 64 100 0 1 DLY4:1.0
p 880 160 100 1024 -1 name:$(top)metSetupNone
p 704 576 75 1280 -1 pproc(DOL1):NPP
p 704 544 75 1280 -1 pproc(DOL2):NPP
p 704 512 75 1280 -1 pproc(DOL3):NPP
p 1072 576 75 1024 -1 pproc(LNK1):PP
p 1072 544 75 1024 -1 pproc(LNK2):PP
p 1072 512 75 1024 -1 pproc(LNK3):PP
p 1072 480 75 1024 -1 pproc(LNK4):PP
use ecars 1344 295 100 0 ecars#65
xform 0 1504 464
p 1456 288 100 1024 -1 name:$(top)metSetupC
use simMask 256 39 100 0 simMask#46
xform 0 368 176
p 320 32 100 0 1 seta:sim metSetup
use outhier 1744 535 100 0 stat
xform 0 1760 576
use outhier 1744 311 100 0 flnk
xform 0 1760 352
use outhier 1744 471 100 0 mess
xform 0 1760 512
use estringouts -640 505 100 0 estringouts#22
xform 6 -512 432
p -704 626 100 0 0 OMSL:closed_loop
p -464 352 100 1024 1 name:$(top)metSetupSo
[comments]
