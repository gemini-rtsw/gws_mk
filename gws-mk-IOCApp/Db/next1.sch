[schematic2]
uniq 179
[tools]
[detail]
w 1122 555 100 0 n#177 eaos.eaos#131.OUT 1088 544 1216 544 1216 352 junction
w 1250 363 100 0 n#177 eaos.eaos#172.OUT 1088 352 1472 352 egenSubC.egenSubC#120.O
w 1476 187 100 2 n#178 hwin.hwin#154.in 1472 192 1472 192 egenSubC.egenSubC#120.INPT
w 706 427 100 0 n#175 hwin.hwin#173.in 640 416 832 416 eaos.eaos#172.DOL
w 706 395 100 0 SLNK1 inhier.SLNK1.P 640 384 832 384 eaos.eaos#172.SLNK
w 2258 587 100 0 FLNK efanouts.efanouts#11.LNK6 2112 576 2464 576 outhier.FLNK.p
w 2258 427 100 0 FLNK1 efanouts.efanouts#11.LNK1 2112 416 2464 416 outhier.FLNK1.p
w 1266 779 100 0 DISA1 inhier.DISA1.P 1120 768 1472 768 egenSubC.egenSubC#120.INPB
w 1476 507 100 2 n#168 hwin.hwin#160.in 1472 512 1472 512 egenSubC.egenSubC#120.INPJ
w 1476 571 100 2 n#167 hwin.hwin#159.in 1472 576 1472 576 egenSubC.egenSubC#120.INPH
w 1476 635 100 2 n#166 hwin.hwin#158.in 1472 640 1472 640 egenSubC.egenSubC#120.INPF
w 1476 699 100 2 n#165 hwin.hwin#157.in 1472 704 1472 704 egenSubC.egenSubC#120.INPD
w 1890 75 100 0 n#152 egenSubC.egenSubC#120.FLNK 1760 64 2080 64 eevents.eevents#147.SLNK
w 2084 91 100 2 n#151 hwin.hwin#150.in 2080 96 2080 96 eevents.eevents#147.INP
w 706 587 100 0 SLNK inhier.SLNK.P 640 576 832 576 eaos.eaos#131.SLNK
w 706 619 100 0 n#133 hwin.hwin#132.in 640 608 832 608 eaos.eaos#131.DOL
w 1810 427 100 0 n#124 egenSubC.egenSubC#120.VALM 1760 416 1920 416 efanouts.efanouts#11.SELL
s 2296 -195 100 0 Gemini Weather Server
s 2384 -256 100 0 Next 1
s 1998 -309 100 0 Pedro Gigoux
s 2015 -342 100 0 16/Apr/02
s 1792 176 100 0 VALP through VALT are used for timestamps
[cell use]
use inhier 624 343 100 0 SLNK1
xform 0 640 384
use inhier 624 535 100 0 SLNK
xform 0 640 576
use inhier 1104 727 100 0 DISA1
xform 0 1120 768
use hwin 448 375 100 0 hwin#173
xform 0 544 416
p 451 408 100 0 -1 val(in):1
use hwin 1280 471 100 0 hwin#160
xform 0 1376 512
p 1283 504 100 0 -1 val(in):1
use hwin 1280 535 100 0 hwin#159
xform 0 1376 576
p 1283 568 100 0 -1 val(in):1
use hwin 1280 599 100 0 hwin#158
xform 0 1376 640
p 1283 632 100 0 -1 val(in):1
use hwin 1280 663 100 0 hwin#157
xform 0 1376 704
p 1283 696 100 0 -1 val(in):1
use hwin 1280 151 100 0 hwin#154
xform 0 1376 192
p 1088 192 100 0 -1 val(in):$(top)debugLevel
use hwin 448 567 100 0 hwin#132
xform 0 544 608
p 451 600 100 0 -1 val(in):0
use hwin 1888 55 100 0 hwin#150
xform 0 1984 96
p 1891 88 100 0 -1 val(in):$(event)
use eaos 832 295 100 0 eaos#172
xform 0 960 384
p 576 366 100 0 0 OMSL:closed_loop
p 944 288 100 1024 -1 name:$(top)$(src)ao1
p 1088 352 75 768 -1 pproc(OUT):PP
use eaos 832 487 100 0 eaos#131
xform 0 960 576
p 576 558 100 0 0 OMSL:closed_loop
p 944 480 100 1024 -1 name:$(top)$(src)ao0
p 1088 544 75 768 -1 pproc(OUT):PP
use eevents 2080 -25 100 0 eevents#147
xform 0 2224 64
p 2112 -64 100 0 0 EVNT:0
p 2192 -32 100 1024 -1 name:$(top)$(src)evn
use egenSubC 1472 7 100 0 egenSubC#120
xform 0 1616 432
p 1568 800 100 0 0 FTA:DOUBLE
p 1568 800 100 0 1 FTB:SHORT
p 1568 768 100 0 0 FTC:DOUBLE
p 1568 768 100 0 1 FTD:SHORT
p 1568 736 100 0 1 FTF:SHORT
p 1568 704 100 0 1 FTH:SHORT
p 1568 672 100 0 1 FTJ:SHORT
p 1568 640 100 0 1 FTO:DOUBLE
p 1552 176 100 0 1 FTT:LONG
p 1568 608 100 0 1 FTVM:USHORT
p 1249 -475 100 0 0 FTVP:LONG
p 1249 -475 100 0 0 FTVQ:LONG
p 1249 -475 100 0 0 FTVR:LONG
p 1249 -475 100 0 0 FTVS:LONG
p 1249 -475 100 0 0 FTVT:LONG
p 1504 -32 100 0 1 SNAM:nextProc
p 1584 0 100 1024 -1 name:$(top)$(src)gs
use outhier 2432 375 100 0 FLNK1
xform 0 2448 416
use outhier 2432 535 100 0 FLNK
xform 0 2448 576
use bb200tr 192 -472 -100 0 frame
xform 0 1472 352
use efanouts 1872 633 100 0 efanouts#11
xform 6 1992 480
p 1920 224 100 0 1 EVNT:$(event)
p 1920 256 100 0 1 SCAN:Event
p 1920 288 100 0 1 SELM:Specified
p 2000 320 100 1024 -1 name:$(top)$(src)fo
[comments]
