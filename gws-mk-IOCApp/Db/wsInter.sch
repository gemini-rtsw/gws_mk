[schematic2]
uniq 194
[tools]
[detail]
w 674 699 100 0 n#193 eaos.eaos#3.VAL 608 688 800 688 800 960 864 960 egenSub.egenSub#191.INPA
w 1010 1099 100 0 n#192 egenSub.egenSub#191.FLNK 1152 256 1312 256 1312 1088 768 1088 768 784 256 784 256 912 352 912 eaos.eaos#2.SLNK
w 178 -149 100 0 n#189 egenSubC.egenSubC#68.VALT -64 368 64 368 64 -160 352 -160 estringouts.estringouts#171.DOL
w -462 603 100 0 MESS inhier.MESS.P -512 592 -352 592 egenSubC.egenSubC#68.M
w -462 667 100 0 HLTH inhier.HLTH.P -512 656 -352 656 egenSubC.egenSubC#68.K
w 994 1147 100 0 n#176 eaos.eaos#0.VAL 608 1136 1440 1136 1440 816 1536 816 ecalcs.ecalcs#148.INPB
w 994 27 100 0 n#177 eaos.eaos#131.VAL 608 16 1440 16 1440 784 1536 784 ecalcs.ecalcs#148.INPA
w 1042 1179 100 0 n#175 eaos.eaos#0.FLNK 608 1168 1536 1168 ecalcs.ecalcs#148.SLNK
w 530 -309 100 0 n#173 esirs.esirs#96.FLNK 768 -432 864 -432 864 -320 256 -320 256 -192 352 -192 estringouts.estringouts#171.SLNK
w 418 -101 100 0 n#172 estringouts.estringouts#171.FLNK 608 -176 640 -176 640 -112 256 -112 256 16 352 16 eaos.eaos#131.SLNK
w -478 475 100 0 UPDT inhier.UPDT.P -544 464 -352 464 egenSubC.egenSubC#68.Q
w -430 379 100 0 n#159 wsDebugComb.wsDebugComb#157.DEBUG -448 368 -352 368 egenSubC.egenSubC#68.INPT
w 210 59 100 0 n#146 egenSubC.egenSubC#68.VALF -64 816 128 816 128 48 352 48 eaos.eaos#131.DOL
w 18 859 100 0 n#145 egenSubC.egenSubC#68.VALE -64 848 160 848 160 272 352 272 eaos.eaos#4.DOL
w 34 891 100 0 n#144 egenSubC.egenSubC#68.VALD -64 880 192 880 192 496 352 496 eaos.eaos#5.DOL
w 50 923 100 0 n#143 egenSubC.egenSubC#68.VALC -64 912 224 912 224 720 352 720 eaos.eaos#3.DOL
w 50 987 100 0 n#142 egenSubC.egenSubC#68.VALA -64 976 224 976 224 1168 352 1168 eaos.eaos#0.DOL
w 114 955 100 0 n#141 egenSubC.egenSubC#68.VALB -64 944 352 944 eaos.eaos#2.DOL
w 418 1019 100 0 n#136 eaos.eaos#2.FLNK 608 944 640 944 640 1008 256 1008 256 1136 352 1136 eaos.eaos#0.SLNK
w 658 731 100 0 n#135 eaos.eaos#3.FLNK 608 720 768 720 768 288 864 288 egenSub.egenSub#191.SLNK
w 418 571 100 0 n#134 eaos.eaos#5.FLNK 608 496 640 496 640 560 256 560 256 688 352 688 eaos.eaos#3.SLNK
w 418 347 100 0 n#133 eaos.eaos#4.FLNK 608 272 640 272 640 336 256 336 256 464 352 464 eaos.eaos#5.SLNK
w 418 123 100 0 n#132 eaos.eaos#131.FLNK 608 48 640 48 640 112 256 112 256 240 352 240 eaos.eaos#4.SLNK
w 146 -421 100 0 n#129 egenSubC.egenSubC#68.VALU -64 336 0 336 0 -432 352 -432 esirs.esirs#96.INP
w 130 -581 100 0 n#128 egenSubC.egenSubC#68.FLNK -64 240 -32 240 -32 -592 352 -592 esirs.esirs#96.SLNK
w -456 731 100 0 HUMID inhier.HUMID.P -512 720 -352 720 egenSubC.egenSubC#68.I
w -456 795 100 0 PRESS inhier.PRESS.P -512 784 -352 784 egenSubC.egenSubC#68.G
w -456 859 100 0 DIR inhier.DIR.P -512 848 -352 848 egenSubC.egenSubC#68.E
w -456 923 100 0 SPEED inhier.SPEED.P -512 912 -352 912 egenSubC.egenSubC#68.C
w -456 987 100 0 TEMP inhier.TEMP.P -512 976 -352 976 egenSubC.egenSubC#68.A
w -456 283 100 0 FLNK inhier.FLNK.P -512 272 -352 272 egenSubC.egenSubC#68.SLNK
s 1776 -816 100 0 28/Feb/02
s 1744 -784 100 0 Pedro Gigoux
s 2016 -672 100 0 Gemini Weather Server
s 1984 -736 100 0 Weather Station Interface
s -320 1088 100 0 VALG to VALP are used to
s -320 1056 100 0 output the statistics
[cell use]
use egenSub 864 199 100 0 egenSub#191
xform 0 1008 624
p 641 -27 100 0 0 FTVA:STRING
p 896 1040 100 0 1 SNAM:setWindDirAlarm
p 1008 176 100 1024 -1 name:$(top)setWindDirAlarm
use gwsTcs 1904 -217 100 0 gwsTcs#186
xform 0 1984 -112
use estringouts 352 -265 100 0 estringouts#171
xform 0 480 -192
p 288 -386 100 0 0 OMSL:closed_loop
p 464 -272 100 1024 -1 name:$(top)wsErrMsg
use inhier -528 551 100 0 MESS
xform 0 -512 592
use inhier -528 615 100 0 HLTH
xform 0 -512 656
use inhier -528 231 100 0 FLNK
xform 0 -512 272
use inhier -528 679 100 0 HUMID
xform 0 -512 720
use inhier -528 743 100 0 PRESS
xform 0 -512 784
use inhier -528 807 100 0 DIR
xform 0 -512 848
use inhier -528 871 100 0 SPEED
xform 0 -512 912
use inhier -528 935 100 0 TEMP
xform 0 -512 976
use inhier -560 423 100 0 UPDT
xform 0 -544 464
use wsDebugComb -672 279 100 0 wsDebugComb#157
xform 0 -544 368
use ecalcs 1536 1257 100 0 ecalcs#148
xform 6 1680 992
p 1632 1040 100 0 1 CALC:B-A
p 1504 1010 100 0 0 HIGH:0.0
p 1504 946 100 0 0 HIHI:0.0
p 1504 1170 100 0 0 LLSV:MAJOR
p 1504 978 100 0 0 LOLO:2.0
p 1504 1042 100 0 0 LOW:3.0
p 1504 1138 100 0 0 LSV:MINOR
p 1248 1138 100 0 0 PREC:1
p 1648 720 100 1024 -1 name:$(top)wsDewDiff
use eaos 352 -73 100 0 eaos#131
xform 0 480 16
p 432 -32 100 0 1 EGU:C
p 320 -98 100 0 0 HHSV:NO_ALARM
p 320 -34 100 0 0 HIGH:0.0
p 320 30 100 0 0 HIHI:0.0
p 320 -130 100 0 0 HSV:NO_ALARM
p 96 -482 100 0 0 HYST:0.0
p 96 -2 100 0 0 OMSL:closed_loop
p 96 -130 100 0 0 PREC:1
p 464 -80 100 1024 -1 name:$(top)wsDew
use eaos 352 1047 100 0 eaos#0
xform 0 480 1136
p 432 1088 100 0 1 EGU:C
p 96 1118 100 0 0 OMSL:closed_loop
p 96 990 100 0 0 PREC:1
p 480 1040 100 1024 -1 name:$(top)wsTemp
use eaos 352 823 100 0 eaos#2
xform 0 480 912
p 432 864 100 0 1 EGU:m/s
p 96 702 100 0 0 EGUL:0.0000000e+00
p 320 798 100 0 0 HHSV:MAJOR
p 320 862 100 0 0 HIGH:10.0
p 320 926 100 0 0 HIHI:20.0
p 320 766 100 0 0 HSV:MINOR
p 96 414 100 0 0 HYST:1.0
p 96 894 100 0 0 OMSL:closed_loop
p 96 766 100 0 0 PREC:1
p 512 816 100 1024 -1 name:$(top)wsWindSpeed
use eaos 352 599 100 0 eaos#3
xform 0 480 688
p 432 640 100 0 1 EGU:degrees
p 96 670 100 0 0 OMSL:closed_loop
p 96 542 100 0 0 PREC:0
p 496 592 100 1024 -1 name:$(top)wsWindDir
use eaos 352 151 100 0 eaos#4
xform 0 480 240
p 432 192 100 0 1 EGU:%
p 320 126 100 0 0 HHSV:MAJOR
p 320 190 100 0 0 HIGH:80.0
p 320 254 100 0 0 HIHI:90.0
p 320 94 100 0 0 HSV:MINOR
p 96 -258 100 0 0 HYST:0.000000000000000e+00
p 96 222 100 0 0 OMSL:closed_loop
p 96 94 100 0 0 PREC:0
p 480 144 100 1024 -1 name:$(top)wsHumid
use eaos 352 375 100 0 eaos#5
xform 0 480 464
p 432 416 100 0 1 EGU:hPa
p 96 446 100 0 0 OMSL:closed_loop
p 96 318 100 0 0 PREC:0
p 480 368 100 1024 -1 name:$(top)wsPress
use bc200tr -864 -952 -100 0 frame
xform 0 816 352
use esirs 352 -681 100 0 esirs#96
xform 0 560 -528
p 464 -464 100 0 1 FTVL:LONG
p 464 -496 100 0 1 SNAM:healthSir
p 464 -688 100 1024 -1 name:$(top)wsHealth
use egenSubC -352 183 100 0 egenSubC#68
xform 0 -208 608
p -320 80 100 0 1 DISV:1
p -256 944 100 0 1 FTK:LONG
p -256 912 100 0 1 FTM:STRING
p -256 880 100 0 0 FTP:DOUBLE
p -256 880 100 0 1 FTQ:LONG
p -256 848 100 0 1 FTT:LONG
p -272 448 100 0 0 FTVG:DOUBLE
p -256 912 100 0 0 FTVK:DOUBLE
p -272 448 100 0 1 FTVT:STRING
p -272 416 100 0 1 FTVU:LONG
p -320 144 100 0 1 INAM:wsFilterInit
p -640 734 100 0 0 PREC:1
p -320 112 100 0 1 SNAM:wsFilterProc
p -240 176 100 1024 -1 name:$(top)wsFilter
p -400 378 75 0 -1 pproc(INPT):PP
[comments]
