[schematic2]
uniq 23
[tools]
[detail]
w 1184 227 100 0 n#1 eaos.eaos#49.FLNK 1152 224 1216 224 1216 272 800 272 800 384 896 384 eaos.eaos#48.SLNK
w 1184 611 100 0 n#2 eaos.eaos#47.FLNK 1152 608 1216 608 1216 656 800 656 800 768 896 768 eaos.eaos#46.SLNK
w 1184 419 100 0 n#3 eaos.eaos#48.FLNK 1152 416 1216 416 1216 464 800 464 800 576 896 576 eaos.eaos#47.SLNK
w -432 147 100 0 n#4 hwin.hwin#39.in -512 144 -352 144 ebis.ebis#4.INP
w -432 371 100 0 n#5 hwin.hwin#38.in -512 368 -352 368 ebis.ebis#3.INP
w -432 595 100 0 n#6 hwin.hwin#37.in -512 592 -352 592 ebis.ebis#2.INP
w -488 739 100 0 SLNK inhier.SLNK.P -544 736 -432 736 -432 784 -352 784 ebis.ebis#0.SLNK
w -432 819 100 0 n#7 hwin.hwin#32.in -512 816 -352 816 ebis.ebis#0.INP
w 48 131 100 0 n#8 ebis.ebis#4.FLNK -96 128 192 128 192 96 288 96 egenSub.egenSub#5.SLNK
w 640 611 100 0 n#9 egenSub.egenSub#5.VALD 576 608 704 608 704 224 896 224 eaos.eaos#49.DOL
w 656 675 100 0 n#10 egenSub.egenSub#5.VALC 576 672 736 672 736 416 896 416 eaos.eaos#48.DOL
w 672 739 100 0 n#11 egenSub.egenSub#5.VALB 576 736 768 736 768 608 896 608 eaos.eaos#47.DOL
w 736 803 100 0 n#12 egenSub.egenSub#5.VALA 576 800 896 800 eaos.eaos#46.DOL
w 16 99 100 0 n#13 ebis.ebis#4.VAL -96 96 128 96 128 576 288 576 egenSub.egenSub#5.INPD
w 0 323 100 0 n#14 ebis.ebis#3.VAL -96 320 96 320 96 640 288 640 egenSub.egenSub#5.INPC
w -16 547 100 0 n#15 ebis.ebis#2.VAL -96 544 64 544 64 704 288 704 egenSub.egenSub#5.INPB
w 96 771 100 0 n#16 ebis.ebis#0.VAL -96 768 288 768 egenSub.egenSub#5.INPA
w -48 355 100 0 n#17 ebis.ebis#3.FLNK -96 352 0 352 0 192 -480 192 -480 112 -352 112 ebis.ebis#4.SLNK
w -48 579 100 0 n#18 ebis.ebis#2.FLNK -96 576 0 576 0 416 -480 416 -480 336 -352 336 ebis.ebis#3.SLNK
w -48 803 100 0 n#19 ebis.ebis#0.FLNK -96 800 0 800 0 640 -480 640 -480 560 -352 560 ebis.ebis#2.SLNK
w 624 547 100 0 n#20 egenSub.egenSub#5.VALE 576 544 672 544 672 32 896 32 eaos.eaos#50.DOL
w 1162 42 -100 0 n#21 eaos.eaos#50.FLNK 1152 32 1184 32 1184 32 1216 32 1216 80 800 80 800 192 896 192 eaos.eaos#49.SLNK
w 586 74 -100 0 n#22 egenSub.egenSub#5.FLNK 576 64 608 64 608 0 896 0 eaos.eaos#50.SLNK
s -944 -64 100 0 These records were used to simulate the precipitation sensors when they were not available
[cell use]
use bb200tr -1088 -536 -100 0 frame
xform 0 192 288
use eaos 896 103 100 0 eaos#49
xform 0 1024 192
p 640 174 100 0 0 OMSL:closed_loop
p 1008 96 100 1024 -1 name:$(top)$(dev)Alarm4
use eaos 896 295 100 0 eaos#48
xform 0 1024 384
p 640 366 100 0 0 OMSL:closed_loop
p 1008 288 100 1024 -1 name:$(top)$(dev)Alarm3
use eaos 896 487 100 0 eaos#47
xform 0 1024 576
p 640 558 100 0 0 OMSL:closed_loop
p 1008 480 100 1024 -1 name:$(top)$(dev)Alarm2
use eaos 896 679 100 0 eaos#46
xform 0 1024 768
p 640 750 100 0 0 OMSL:closed_loop
p 1008 672 100 1024 -1 name:$(top)$(dev)Alarm1
use ebis -512 -377 100 0 ebis#45
xform 0 -384 -304
p -736 -466 100 0 0 ONAM:on
p -736 -434 100 0 0 ZNAM:off
p -400 -384 100 1024 -1 name:$(top)$(dev)Sim4
use ebis -512 -217 100 0 ebis#44
xform 0 -384 -144
p -736 -306 100 0 0 ONAM:on
p -736 -274 100 0 0 ZNAM:off
p -400 -224 100 1024 -1 name:$(top)$(dev)Sim2
use ebis -896 -377 100 0 ebis#43
xform 0 -768 -304
p -1120 -466 100 0 0 ONAM:on
p -1120 -434 100 0 0 ZNAM:off
p -784 -384 100 1024 -1 name:$(top)$(dev)Sim3
use ebis -896 -217 100 0 ebis#42
xform 0 -768 -144
p -1120 -306 100 0 0 ONAM:$(onam)
p -1120 -274 100 0 0 ZNAM:$(znam)
p -784 -224 100 1024 -1 name:$(top)$(dev)Sim1
use ebis -352 711 100 0 ebis#0
xform 0 -224 784
p -304 685 100 0 1 ONAM:$(onam)
p -304 661 100 0 1 ZNAM:$(znam)
p -192 704 100 1024 -1 name:$(top)$(dev)Sensor1
use ebis -352 487 100 0 ebis#2
xform 0 -224 560
p -304 461 100 0 1 ONAM:$(onam)
p -304 437 100 0 1 ZNAM:$(znam)
p -192 480 100 1024 -1 name:$(top)$(dev)Sensor2
use ebis -352 263 100 0 ebis#3
xform 0 -224 336
p -304 237 100 0 1 ONAM:$(onam)
p -304 213 100 0 1 ZNAM:$(znam)
p -192 256 100 1024 -1 name:$(top)$(dev)Sensor3
use ebis -352 39 100 0 ebis#4
xform 0 -224 112
p -304 13 100 0 1 ONAM:$(onam)
p -304 -11 100 0 1 ZNAM:$(znam)
p -192 32 100 1024 -1 name:$(top)$(dev)Sensor4
use hwin -704 103 100 0 hwin#39
xform 0 -608 144
p -800 176 100 0 -1 val(in):$(pstop)threat4
use hwin -704 327 100 0 hwin#38
xform 0 -608 368
p -800 400 100 0 -1 val(in):$(pstop)threat3
use hwin -704 551 100 0 hwin#37
xform 0 -608 592
p -800 624 100 0 -1 val(in):$(pstop)threat2
use hwin -704 775 100 0 hwin#32
xform 0 -608 816
p -800 848 100 0 -1 val(in):$(pstop)threat1
use inhier -560 695 100 0 SLNK
xform 0 -544 736
use egenSub 288 7 100 0 egenSub#5
xform 0 432 432
p 368 784 100 0 1 FTA:LONG
p 368 752 100 0 1 FTB:LONG
p 368 720 100 0 1 FTC:LONG
p 368 688 100 0 1 FTD:LONG
p 368 624 100 0 1 FTVA:LONG
p 368 592 100 0 1 FTVB:LONG
p 368 560 100 0 1 FTVC:LONG
p 368 528 100 0 1 FTVD:LONG
p 288 -32 100 0 1 SNAM:precipitationAlarms
p 400 0 100 1024 -1 name:$(top)$(dev)Alarms
p 370 500 100 0 1 FTVE:LONG
use eaos 896 -64 100 0 eaos#50
xform 0 1024 0
p 640 -18 100 0 0 OMSL:closed_loop
p 1008 -96 100 1024 -1 name:$(top)$(dev)AlarmAll
[comments]
