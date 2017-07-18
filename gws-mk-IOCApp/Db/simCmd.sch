[schematic2]
uniq 84
[tools]
[detail]
w 1032 -277 100 0 n#83 eseqs.eseqs#62.LNK3 960 -288 1152 -288 1152 -448 1344 -448 esirs.esirs#2.SLNK
w 1624 -693 100 0 stat ecars.ecars#72.VAL 1568 -704 1728 -704 outhier.stat.p
w -312 491 100 0 n#80 estringouts.estringouts#77.OUT -416 720 -352 720 -352 480 -224 480 ecad2.ecad2#1.A
w -808 747 100 0 n#79 embbos.embbos#0.FLNK -832 736 -736 736 -736 704 -672 704 estringouts.estringouts#77.SLNK
w -776 683 100 0 n#78 embbos.embbos#0.VAL -832 672 -672 672 estringouts.estringouts#77.DOL
w 1624 -917 100 0 flnk ecars.ecars#72.FLNK 1568 -928 1728 -928 outhier.flnk.p
w 1624 -757 100 0 mess ecars.ecars#72.OMSS 1568 -768 1728 -768 outhier.mess.p
w 1144 -693 100 0 n#73 eseqs.eseqs#62.LNK1 960 -224 1088 -224 1088 -704 1248 -704 ecars.ecars#72.IVAL
w 1000 -309 100 0 n#73 eseqs.eseqs#62.LNK4 960 -320 1088 -320 junction
w 424 -533 100 0 n#70 ecad2.ecad2#1.STLK 96 192 256 192 256 -544 640 -544 eseqs.eseqs#62.SLNK
w 648 491 100 0 n#67 ecad2.ecad2#1.VALA 96 480 1248 480 esubs.esubs#56.INPA
w 504 -277 100 0 n#67 eseqs.eseqs#62.DOL3 640 -288 416 -288 416 480 junction
w 1032 -245 100 0 n#69 eseqs.eseqs#62.LNK2 960 -256 1152 -256 1152 96 1248 96 esubs.esubs#56.SLNK
w 644 -325 100 2 n#66 hwin.hwin#64.in 640 -320 640 -320 eseqs.eseqs#62.DOL4
w 644 -229 100 2 n#65 hwin.hwin#63.in 640 -224 640 -224 eseqs.eseqs#62.DOL1
w 1252 443 100 2 n#57 esubs.esubs#56.INPB 1248 448 1248 448 hwin.hwin#51.in
w -220 379 100 2 n#20 hwin.hwin#3.in -224 384 -224 384 ecad2.ecad2#1.INPB
s 1248 -1360 100 0 24/Jul/98
s 1232 -1328 100 0 Pedro Gigoux
s 1552 -1280 100 0 Simulation Level
s 1504 -1216 100 0 Gemini Weather Server
[cell use]
use estringouts -672 777 100 0 estringouts#77
xform 6 -544 704
p -736 898 100 0 0 OMSL:closed_loop
p -576 624 100 1024 -1 name:$(top)simSo
use outhier 1696 -745 100 0 stat
xform 0 1712 -704
use outhier 1696 -809 100 0 mess
xform 0 1712 -768
use outhier 1696 -969 100 0 flnk
xform 0 1712 -928
use ecars 1248 -985 100 0 ecars#72
xform 0 1408 -816
p 1360 -992 100 1024 -1 name:$(top)simC
use bc200tr -1376 -1496 -100 0 frame
xform 0 304 -192
use hwin 1056 407 100 0 hwin#51
xform 0 1152 448
p 976 400 100 0 -1 val(in):$(top)debugLevel
use hwin -416 343 100 0 hwin#3
xform 0 -320 384
p -608 384 100 0 -1 val(in):$(top)debugLevel
use hwin 448 -265 100 0 hwin#63
xform 0 544 -224
p 451 -232 100 0 -1 val(in):$(BUSY)
use hwin 448 -361 100 0 hwin#64
xform 0 544 -320
p 451 -328 100 0 -1 val(in):$(IDLE)
use eseqs 640 -633 100 0 eseqs#62
xform 0 800 -384
p 688 -672 100 0 1 DLY2:0.5
p 688 -704 100 0 1 DLY3:1.0
p 688 -736 100 0 1 DLY4:1.5
p 752 -640 100 1024 -1 name:$(top)simSeq
p 976 -224 75 1024 -1 pproc(LNK1):PP
p 976 -256 75 1024 -1 pproc(LNK2):PP
p 976 -288 75 1024 -1 pproc(LNK3):PP
p 976 -320 75 1024 -1 pproc(LNK4):PP
use esubs 1248 7 100 0 esubs#56
xform 0 1392 272
p 1312 -32 100 0 1 INAM:nullSub
p 1312 -64 100 0 1 SNAM:simMask
p 1424 0 100 1024 1 name:$(top)simMask
use esirs 1344 -537 100 0 esirs#2
xform 0 1552 -384
p 1408 -576 100 0 1 FTVL:LONG
p 1408 -608 100 0 1 SNAM:simSir
p 1536 -544 100 1024 1 name:$(top)simLevel
use ecad2 -224 103 100 0 ecad2#1
xform 0 -64 416
p -160 32 100 0 1 FTVA:LONG
p -160 64 100 0 1 SNAM:simCad
p -48 96 100 1024 1 name:$(top)simCad
use embbos -1088 615 100 0 embbos#0
xform 0 -960 704
p -1024 544 100 0 1 ONST:VSM
p -896 544 100 0 1 ONVL:1
p -1024 480 100 0 1 THST:FULL
p -896 480 100 0 1 THVL:3
p -1024 512 100 0 1 TWST:FAST
p -896 512 100 0 1 TWVL:2
p -1024 576 100 0 1 ZRST:NONE
p -896 576 100 0 1 ZRVL:0
p -896 608 100 1024 1 name:$(top)simMode
[comments]
