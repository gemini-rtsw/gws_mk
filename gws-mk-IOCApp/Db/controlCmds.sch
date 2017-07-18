[schematic2]
uniq 69
[tools]
[detail]
w -584 523 100 0 n#24 snMetOneCmd.snMetOneCmd#66.flnk -608 512 -512 512 junction
w -216 683 100 0 n#68 snMetOneCmd.snMetOneCmd#66.mess -608 576 -448 576 -448 672 64 672 egenSubD.egenSubD#13.INPD
w -232 715 100 0 n#67 snMetOneCmd.snMetOneCmd#66.stat -608 608 -480 608 -480 704 64 704 egenSubD.egenSubD#13.INPC
w 68 571 100 2 n#64 hwin.hwin#63.in 64 576 64 576 egenSubD.egenSubD#13.INPG
w 68 635 100 2 n#62 hwin.hwin#61.in 64 640 64 640 egenSubD.egenSubD#13.INPE
w 920 523 100 0 flnk ecars.ecars#25.FLNK 896 512 992 512 outhier.flnk.p
w 920 683 100 0 mess ecars.ecars#25.OMSS 896 672 992 672 outhier.mess.p
w 920 747 100 0 stat ecars.ecars#25.VAL 896 736 992 736 outhier.stat.p
w 68 155 100 2 n#52 hwin.hwin#43.in 64 160 64 160 egenSubD.egenSubD#13.INPT
w 68 347 100 2 n#55 hwin.hwin#46.in 64 352 64 352 egenSubD.egenSubD#13.INPN
w 68 283 100 2 n#54 hwin.hwin#45.in 64 288 64 288 egenSubD.egenSubD#13.INPP
w 68 219 100 2 n#53 hwin.hwin#44.in 64 224 64 224 egenSubD.egenSubD#13.INPR
w 68 411 100 2 n#51 hwin.hwin#42.in 64 416 64 416 egenSubD.egenSubD#13.INPL
w 68 507 100 2 n#50 hwin.hwin#49.in 64 512 64 512 egenSubD.egenSubD#13.INPI
w -216 779 100 0 n#35 wsSelCmd.wsSelCmd#65.stat -608 832 -448 832 -448 768 64 768 egenSubD.egenSubD#13.INPA
w -232 747 100 0 n#34 wsSelCmd.wsSelCmd#65.mess -608 800 -480 800 -480 736 64 736 egenSubD.egenSubD#13.INPB
w 392 43 100 0 n#29 egenSubD.egenSubD#13.FLNK 352 32 480 32 480 544 576 544 ecars.ecars#25.SLNK
w 440 683 100 0 n#27 egenSubD.egenSubD#13.OUTB 352 672 576 672 ecars.ecars#25.IMSS
w 440 747 100 0 n#26 egenSubD.egenSubD#13.OUTA 352 736 576 736 ecars.ecars#25.IVAL
w -248 75 100 0 n#24 wsSelCmd.wsSelCmd#65.flnk -608 736 -512 736 -512 64 64 64 egenSubD.egenSubD#13.SLNK
s 992 -384 100 0 Control Commands
s 976 -320 100 0 Gemini Weather Server
s 693 -432 100 0 Pedro Gigoux
s 712 -470 100 0 25/Feb/02
[cell use]
use snMetOneCmd -896 455 100 0 snMetOneCmd#66
xform 0 -752 560
use wsSelCmd -832 679 100 0 wsSelCmd#65
xform 0 -720 784
use hwin -128 375 100 0 hwin#42
xform 0 -32 416
p -125 408 100 0 -1 val(in):$(IDLE)
use hwin -128 183 100 0 hwin#44
xform 0 -32 224
p -125 216 100 0 -1 val(in):$(IDLE)
use hwin -128 247 100 0 hwin#45
xform 0 -32 288
p -125 280 100 0 -1 val(in):$(IDLE)
use hwin -128 311 100 0 hwin#46
xform 0 -32 352
p -125 344 100 0 -1 val(in):$(IDLE)
use hwin -128 471 100 0 hwin#49
xform 0 -32 512
p -125 504 100 0 -1 val(in):$(IDLE)
use hwin -128 119 100 0 hwin#43
xform 0 -32 160
p -224 112 100 0 -1 val(in):$(top)debugLevel
use hwin -128 599 100 0 hwin#61
xform 0 -32 640
p -125 632 100 0 -1 val(in):$(IDLE)
use hwin -128 535 100 0 hwin#63
xform 0 -32 576
p -125 568 100 0 -1 val(in):$(IDLE)
use outhier 960 695 100 0 stat
xform 0 976 736
use outhier 960 631 100 0 mess
xform 0 976 672
use outhier 960 471 100 0 flnk
xform 0 976 512
use ecars 576 455 100 0 ecars#25
xform 0 736 624
p 688 448 100 1024 -1 name:$(top)ctrlC
use egenSubD 64 -25 100 0 egenSubD#13
xform 0 208 400
p -159 -251 100 0 0 FTA:LONG
p -159 -251 100 0 0 FTB:STRING
p -159 -283 100 0 0 FTC:LONG
p -159 -315 100 0 0 FTD:STRING
p -159 -347 100 0 0 FTE:LONG
p -159 -411 100 0 0 FTF:STRING
p -159 -411 100 0 0 FTG:LONG
p -159 -443 100 0 0 FTH:STRING
p -159 -475 100 0 0 FTI:LONG
p -159 -507 100 0 0 FTJ:DOUBLE
p -159 -251 100 0 0 FTK:STRING
p -159 -251 100 0 0 FTL:LONG
p -159 -283 100 0 0 FTM:STRING
p -159 -315 100 0 0 FTN:LONG
p -159 -347 100 0 0 FTO:STRING
p -159 -411 100 0 0 FTP:LONG
p -159 -411 100 0 0 FTQ:STRING
p -159 -443 100 0 0 FTR:LONG
p -159 -475 100 0 0 FTS:STRING
p -159 -507 100 0 0 FTT:LONG
p -159 -507 100 0 0 FTU:DOUBLE
p -159 -251 100 0 0 FTVA:LONG
p -159 -251 100 0 0 FTVB:STRING
p 96 -64 100 0 1 SNAM:carCombine
p 176 -32 100 1024 -1 name:$(top)ctrlCarComb
use bb200tr -1120 -600 -100 0 frame
xform 0 160 224
[comments]
