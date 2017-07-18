[schematic2]
uniq 84
[tools]
[detail]
w 1080 1451 100 0 n#83 esirs.esirs#2.FLNK 1664 1120 1728 1120 1728 1440 480 1440 480 1344 608 1344 esubs.esubs#79.SLNK
w 612 987 100 2 n#81 hwin.hwin#80.in 608 992 608 992 esubs.esubs#79.INPB
w 472 971 100 0 n#64 junction 384 544 384 960 608 960 esubs.esubs#79.INPA
w 536 555 100 0 n#64 ecad2.ecad2#1.VALA 160 384 384 384 384 544 736 544 eseqs.eseqs#48.DOL2
w 1176 587 100 0 n#76 eseqs.eseqs#48.LNK1 1056 576 1344 576 ecars.ecars#65.IVAL
w 1272 139 100 0 n#76 eseqs.eseqs#67.LNK1 1248 -96 1376 -96 1376 128 1216 128 1216 576 junction
w 1288 -117 100 0 n#76 eseqs.eseqs#67.LNK2 1248 -128 1376 -128 1376 -96 junction
w 1112 523 100 0 n#76 eseqs.eseqs#48.LNK3 1056 512 1216 512 junction
w 1080 555 100 0 n#78 eseqs.eseqs#48.LNK2 1056 544 1152 544 1152 960 1248 960 esirs.esirs#2.SLNK
w 1696 587 100 0 stat ecars.ecars#65.VAL 1664 576 1776 576 outhier.stat.p
w 1696 363 100 0 flnk ecars.ecars#65.FLNK 1664 352 1776 352 outhier.flnk.p
w 1696 523 100 0 mess ecars.ecars#65.OMSS 1664 512 1776 512 outhier.mess.p
w 760 -405 100 0 n#72 simMask.simMask#46.VSM 480 224 640 224 640 -416 928 -416 eseqs.eseqs#67.SLNK
w 536 203 100 0 n#72 simMask.simMask#46.FAST 480 192 640 192 junction
w 536 171 100 0 n#72 simMask.simMask#46.FULL 480 160 640 160 junction
w 932 -101 100 2 n#71 hwin.hwin#68.in 928 -96 928 -96 eseqs.eseqs#67.DOL1
w 932 -133 100 2 n#70 hwin.hwin#69.in 928 -128 928 -128 eseqs.eseqs#67.DOL2
w 584 267 100 0 n#63 simMask.simMask#46.NONE 480 256 736 256 eseqs.eseqs#48.SLNK
w 740 571 100 2 n#52 hwin.hwin#49.in 736 576 736 576 eseqs.eseqs#48.DOL1
w 740 507 100 2 n#51 hwin.hwin#50.in 736 512 736 512 eseqs.eseqs#48.DOL3
w 184 107 100 0 n#47 ecad2.ecad2#1.STLK 160 96 256 96 simMask.simMask#46.SLNK
w -344 459 100 0 n#32 estringouts.estringouts#22.OUT -384 448 -256 448 -256 384 -160 384 ecad2.ecad2#1.A
w -816 475 100 0 n#31 embbos.embbos#0.FLNK -848 464 -736 464 -736 432 -640 432 estringouts.estringouts#22.SLNK
w -768 411 100 0 n#30 embbos.embbos#0.VAL -848 400 -640 400 estringouts.estringouts#22.DOL
w -156 283 100 2 n#20 hwin.hwin#3.in -160 288 -160 288 ecad2.ecad2#1.INPB
s 1296 -784 100 0 25/Feb/02
s 1280 -752 100 0 Pedro Gigoux
s 1536 -704 100 0 Weather Station Selection
s 1552 -640 100 0 Gemini Weather Server
[cell use]
use hwin 416 951 100 0 hwin#80
xform 0 512 992
p 224 992 100 0 -1 val(in):$(top)debugLevel
use hwin -352 247 100 0 hwin#3
xform 0 -256 288
p -544 288 100 0 -1 val(in):$(top)debugLevel
use hwin 544 535 100 0 hwin#49
xform 0 640 576
p 547 568 100 0 -1 val(in):$(BUSY)
use hwin 544 471 100 0 hwin#50
xform 0 640 512
p 547 504 100 0 -1 val(in):$(IDLE)
use hwin 736 -137 100 0 hwin#68
xform 0 832 -96
p 739 -104 100 0 -1 val(in):$(BUSY)
use hwin 736 -169 100 0 hwin#69
xform 0 832 -128
p 739 -136 100 0 -1 val(in):$(IDLE)
use esubs 608 1433 100 0 esubs#79
xform 6 752 1168
p 624 880 100 0 1 INAM:nullSub
p 624 848 100 0 1 SNAM:wsMask
p 704 896 100 1024 -1 name:$(top)wsSelMask
use bc200tr -1344 -920 -100 0 frame
xform 0 336 384
use eseqs 736 167 100 0 eseqs#48
xform 0 896 416
p 800 128 100 0 1 DLY2:0.5
p 800 96 100 0 1 DLY3:1.0
p 880 160 100 1024 -1 name:$(top)wsSelNone
p 704 576 75 1280 -1 pproc(DOL1):NPP
p 704 544 75 1280 -1 pproc(DOL2):NPP
p 704 512 75 1280 -1 pproc(DOL3):NPP
p 1072 576 75 1024 -1 pproc(LNK1):PP
p 1072 544 75 1024 -1 pproc(LNK2):PP
p 1072 512 75 1024 -1 pproc(LNK3):PP
use eseqs 928 -505 100 0 eseqs#67
xform 0 1088 -256
p 992 -544 100 0 1 DLY2:0.5
p 1104 -512 100 1024 -1 name:$(top)wsSelNotNone
p 896 -96 75 1280 -1 pproc(DOL1):NPP
p 896 -128 75 1280 -1 pproc(DOL2):NPP
p 1264 -96 75 1024 -1 pproc(LNK1):PP
p 1264 -128 75 1024 -1 pproc(LNK2):PP
use ecars 1344 295 100 0 ecars#65
xform 0 1504 464
p 1456 288 100 1024 -1 name:$(top)wsSelC
use simMask 256 39 100 0 simMask#46
xform 0 368 176
p 320 32 100 0 1 seta:sim wsSel
use outhier 1744 471 100 0 mess
xform 0 1760 512
use outhier 1744 311 100 0 flnk
xform 0 1760 352
use outhier 1744 535 100 0 stat
xform 0 1760 576
use estringouts -640 505 100 0 estringouts#22
xform 6 -512 432
p -704 626 100 0 0 OMSL:closed_loop
p -464 352 100 1024 1 name:$(top)wsSelSo
use esirs 1248 871 100 0 esirs#2
xform 0 1456 1024
p 1312 832 100 0 1 FTVL:LONG
p 1312 800 100 0 1 SNAM:wsSelSir
p 1440 864 100 1024 1 name:$(top)wsCurrent
use ecad2 -160 7 100 0 ecad2#1
xform 0 0 320
p -96 -32 100 0 1 FTVA:LONG
p -96 -64 100 0 0 INAM:
p -96 -64 100 0 1 SNAM:wsSelCad
p 16 0 100 1024 1 name:$(top)wsSelCad
use embbos -1104 343 100 0 embbos#0
xform 0 -976 432
p -1040 176 100 0 1 FRST:UKIRT
p -896 176 100 0 1 FRVL:4
p -896 176 100 0 0 FTVL:0
p -1040 176 100 0 0 FVST:
p -896 176 100 0 0 FVVL:
p -1040 272 100 0 1 ONST:SOAR
p -896 272 100 0 1 ONVL:1
p -1040 208 100 0 1 THST:CFHT
p -896 208 100 0 1 THVL:3
p -1040 240 100 0 1 TWST:CTIO
p -896 240 100 0 1 TWVL:2
p -1040 304 100 0 1 ZRST:PACHON
p -896 304 100 0 1 ZRVL:0
p -912 336 100 1024 1 name:$(top)wsSelInput
[comments]
