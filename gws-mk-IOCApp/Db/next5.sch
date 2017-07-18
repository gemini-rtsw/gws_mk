[schematic2]
uniq 156
[tools]
[detail]
w 1042 427 100 0 n#153 eaos.eaos#98.OUT 992 416 1152 416 junction
w 1042 107 100 0 n#153 eaos.eaos#103.OUT 992 96 1152 96 junction
w 1042 -53 100 0 n#153 eaos.eaos#104.OUT 992 -64 1152 -64 junction
w 1042 -213 100 0 n#153 eaos.eaos#105.OUT 992 -224 1152 -224 1152 256 junction
w 1042 587 100 0 n#153 eaos.eaos#131.OUT 992 576 1152 576 1152 256 junction
w 1250 267 100 0 n#153 eaos.eaos#99.OUT 992 256 1568 256 egenSubC.egenSubC#120.O
w 1572 91 100 2 n#155 hwin.hwin#154.in 1568 96 1568 96 egenSubC.egenSubC#120.INPT
w 1986 -21 100 0 n#152 egenSubC.egenSubC#120.FLNK 1856 -32 2176 -32 eevents.eevents#147.SLNK
w 2180 -5 100 2 n#151 hwin.hwin#150.in 2176 0 2176 0 eevents.eevents#147.INP
w 2418 203 100 0 FLNK1 efanouts.efanouts#11.LNK1 2208 320 2336 320 2336 192 2560 192 outhier.FLNK1.p
w 2434 299 100 0 FLNK2 efanouts.efanouts#11.LNK2 2208 352 2368 352 2368 288 2560 288 outhier.FLNK2.p
w 610 619 100 0 SLNK inhier.SLNK.P 544 608 736 608 eaos.eaos#131.SLNK
w 610 651 100 0 n#133 hwin.hwin#132.in 544 640 736 640 eaos.eaos#131.DOL
w 2402 811 100 0 FLNK efanouts.efanouts#11.LNK6 2208 480 2304 480 2304 800 2560 800 outhier.FLNK.p
w 1906 331 100 0 n#124 egenSubC.egenSubC#120.VALM 1856 320 2016 320 efanouts.efanouts#11.SELL
w 882 747 100 0 DISA5 inhier.DISA5.P 544 736 1280 736 1280 416 1568 416 egenSubC.egenSubC#120.INPJ
w 938 811 100 0 DISA4 inhier.DISA4.P 624 800 1312 800 1312 480 1568 480 egenSubC.egenSubC#120.INPH
w 986 875 100 0 DISA3 inhier.DISA3.P 688 864 1344 864 1344 544 1568 544 egenSubC.egenSubC#120.INPF
w 1034 939 100 0 DISA2 inhier.DISA2.P 752 928 1376 928 1376 608 1568 608 egenSubC.egenSubC#120.INPD
w 1082 1003 100 0 DISA1 inhier.DISA1.P 816 992 1408 992 1408 672 1568 672 egenSubC.egenSubC#120.INPB
w 616 -181 100 0 SLNK5 inhier.SLNK5.P 544 -192 736 -192 eaos.eaos#105.SLNK
w 616 -21 100 0 SLNK4 inhier.SLNK4.P 544 -32 736 -32 eaos.eaos#104.SLNK
w 616 139 100 0 SLNK3 inhier.SLNK3.P 544 128 736 128 eaos.eaos#103.SLNK
w 616 299 100 0 SLNK2 inhier.SLNK2.P 544 288 736 288 eaos.eaos#99.SLNK
w 616 459 100 0 SLNK1 inhier.SLNK1.P 544 448 736 448 eaos.eaos#98.SLNK
w 2434 491 100 0 FLNK4 efanouts.efanouts#11.LNK4 2208 416 2368 416 2368 480 2560 480 outhier.FLNK4.p
w 2418 587 100 0 FLNK5 efanouts.efanouts#11.LNK5 2208 448 2336 448 2336 576 2560 576 outhier.FLNK5.p
w 2354 395 100 0 FLNK3 efanouts.efanouts#11.LNK3 2208 384 2560 384 outhier.FLNK3.p
w 616 -149 100 0 n#25 hwin.hwin#24.in 544 -160 736 -160 eaos.eaos#105.DOL
w 616 11 100 0 n#21 hwin.hwin#20.in 544 0 736 0 eaos.eaos#104.DOL
w 616 171 100 0 n#17 hwin.hwin#16.in 544 160 736 160 eaos.eaos#103.DOL
w 622 331 100 0 n#9 hwin.hwin#8.in 544 320 736 320 eaos.eaos#99.DOL
w 622 491 100 0 n#4 hwin.hwin#3.in 544 480 736 480 eaos.eaos#98.DOL
s 1248 -288 100 0 the FLNK record is triggered
s 1248 -256 100 0 processing of the fanout record several times
s 1248 -224 100 0 The purpose of the event record is to allow
s 2296 -195 100 0 Gemini Weather Server
s 2384 -256 100 0 Next 5
s 1998 -309 100 0 Pedro Gigoux
s 2015 -342 100 0 16/Apr/02
s 1904 80 100 0 VALP through VALT are used for timestamps
[cell use]
use hwin 1376 55 100 0 hwin#154
xform 0 1472 96
p 1184 96 100 0 -1 val(in):$(top)debugLevel
use hwin 352 599 100 0 hwin#132
xform 0 448 640
p 355 632 100 0 -1 val(in):0
use hwin 352 439 100 0 hwin#3
xform 0 448 480
p 355 472 100 0 -1 val(in):1
use hwin 352 279 100 0 hwin#8
xform 0 448 320
p 355 312 100 0 -1 val(in):2
use hwin 352 119 100 0 hwin#16
xform 0 448 160
p 355 152 100 0 -1 val(in):3
use hwin 352 -41 100 0 hwin#20
xform 0 448 0
p 355 -8 100 0 -1 val(in):4
use hwin 352 -201 100 0 hwin#24
xform 0 448 -160
p 355 -168 100 0 -1 val(in):5
use hwin 1984 -41 100 0 hwin#150
xform 0 2080 0
p 1987 -8 100 0 -1 val(in):$(event)
use eevents 2176 -121 100 0 eevents#147
xform 0 2320 -32
p 2208 -160 100 0 0 EVNT:0
p 2288 -128 100 1024 -1 name:$(top)$(src)evn
use inhier 528 567 100 0 SLNK
xform 0 544 608
use inhier 528 -233 100 0 SLNK5
xform 0 544 -192
use inhier 528 -73 100 0 SLNK4
xform 0 544 -32
use inhier 528 87 100 0 SLNK3
xform 0 544 128
use inhier 528 247 100 0 SLNK2
xform 0 544 288
use inhier 528 407 100 0 SLNK1
xform 0 544 448
use inhier 800 951 100 0 DISA1
xform 0 816 992
use inhier 736 887 100 0 DISA2
xform 0 752 928
use inhier 672 823 100 0 DISA3
xform 0 688 864
use inhier 608 759 100 0 DISA4
xform 0 624 800
use inhier 528 695 100 0 DISA5
xform 0 544 736
use eaos 736 519 100 0 eaos#131
xform 0 864 608
p 480 590 100 0 0 OMSL:closed_loop
p 848 512 100 1024 -1 name:$(top)$(src)ao0
p 992 576 75 768 -1 pproc(OUT):PP
use eaos 736 -281 100 0 eaos#105
xform 0 864 -192
p 480 -210 100 0 0 OMSL:closed_loop
p 848 -288 100 1024 -1 name:$(top)$(src)ao5
p 992 -224 75 768 -1 pproc(OUT):PP
use eaos 736 -121 100 0 eaos#104
xform 0 864 -32
p 480 -50 100 0 0 OMSL:closed_loop
p 848 -128 100 1024 -1 name:$(top)$(src)ao4
p 992 -64 75 768 -1 pproc(OUT):PP
use eaos 736 39 100 0 eaos#103
xform 0 864 128
p 480 110 100 0 0 OMSL:closed_loop
p 848 32 100 1024 -1 name:$(top)$(src)ao3
p 992 96 75 768 -1 pproc(OUT):PP
use eaos 736 199 100 0 eaos#99
xform 0 864 288
p 480 270 100 0 0 OMSL:closed_loop
p 848 192 100 1024 -1 name:$(top)$(src)ao2
p 992 256 75 768 -1 pproc(OUT):PP
use eaos 736 359 100 0 eaos#98
xform 0 864 448
p 480 430 100 0 0 OMSL:closed_loop
p 848 352 100 1024 -1 name:$(top)$(src)ao1
p 992 416 75 768 -1 pproc(OUT):PP
use egenSubC 1568 -89 100 0 egenSubC#120
xform 0 1712 336
p 1664 704 100 0 0 FTA:DOUBLE
p 1664 704 100 0 1 FTB:SHORT
p 1664 672 100 0 0 FTC:DOUBLE
p 1664 672 100 0 1 FTD:SHORT
p 1664 640 100 0 1 FTF:SHORT
p 1664 608 100 0 1 FTH:SHORT
p 1664 576 100 0 1 FTJ:SHORT
p 1664 544 100 0 1 FTO:DOUBLE
p 1648 96 100 0 1 FTT:LONG
p 1664 512 100 0 1 FTVM:USHORT
p 1345 -571 100 0 0 FTVP:LONG
p 1345 -571 100 0 0 FTVQ:LONG
p 1345 -571 100 0 0 FTVR:LONG
p 1345 -571 100 0 0 FTVS:LONG
p 1345 -571 100 0 0 FTVT:LONG
p 1600 -128 100 0 1 SNAM:nextProc
p 1680 -96 100 1024 -1 name:$(top)$(src)gs
use outhier 2528 151 100 0 FLNK1
xform 0 2544 192
use outhier 2528 247 100 0 FLNK2
xform 0 2544 288
use outhier 2528 343 100 0 FLNK3
xform 0 2544 384
use outhier 2528 439 100 0 FLNK4
xform 0 2544 480
use outhier 2528 535 100 0 FLNK5
xform 0 2544 576
use outhier 2528 759 100 0 FLNK
xform 0 2544 800
use bb200tr 192 -472 -100 0 frame
xform 0 1472 352
use efanouts 1968 537 100 0 efanouts#11
xform 6 2088 384
p 2016 128 100 0 1 EVNT:$(event)
p 2016 160 100 0 1 SCAN:Event
p 2016 192 100 0 1 SELM:Specified
p 2096 224 100 1024 -1 name:$(top)$(src)fo
[comments]
