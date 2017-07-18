[schematic2]
uniq 15
[tools]
[detail]
w -216 683 100 0 n#1 controlCmds.controlCmds#68.mess -608 576 -448 576 -448 672 64 672 egenSubD.egenSubD#13.INPD
w -232 715 100 0 n#2 controlCmds.controlCmds#68.stat -608 608 -480 608 -480 704 64 704 egenSubD.egenSubD#13.INPC
w -584 523 100 0 n#12 controlCmds.controlCmds#68.flnk -608 512 -512 512 junction
w 68 155 100 2 n#3 hwin.hwin#43.in 64 160 64 160 egenSubD.egenSubD#13.INPT
w 68 347 100 2 n#4 hwin.hwin#46.in 64 352 64 352 egenSubD.egenSubD#13.INPN
w 68 283 100 2 n#5 hwin.hwin#45.in 64 288 64 288 egenSubD.egenSubD#13.INPP
w 68 219 100 2 n#6 hwin.hwin#44.in 64 224 64 224 egenSubD.egenSubD#13.INPR
w -216 779 100 0 n#7 softCmds.softCmds#56.stat -608 832 -448 832 -448 768 64 768 egenSubD.egenSubD#13.INPA
w -232 747 100 0 n#8 softCmds.softCmds#56.mess -608 800 -480 800 -480 736 64 736 egenSubD.egenSubD#13.INPB
w 392 43 100 0 n#9 egenSubD.egenSubD#13.FLNK 352 32 480 32 480 544 576 544 ecars.ecars#25.SLNK
w 440 683 100 0 n#10 egenSubD.egenSubD#13.OUTB 352 672 576 672 ecars.ecars#25.IMSS
w 440 747 100 0 n#11 egenSubD.egenSubD#13.OUTA 352 736 576 736 ecars.ecars#25.IVAL
w -248 75 100 0 n#12 softCmds.softCmds#56.flnk -608 736 -512 736 -512 64 64 64 egenSubD.egenSubD#13.SLNK
w 68 507 100 2 n#13 hwin.hwin#49.in 64 512 64 512 egenSubD.egenSubD#13.INPI
w 68 411 100 2 n#14 hwin.hwin#42.in 64 416 64 416 egenSubD.egenSubD#13.INPL
s 992 -384 100 0 Commands
s 976 -320 100 0 Gemini Weather Server
s 693 -432 100 0 Pedro Gigoux
s 712 -470 100 0 25/Jan/02
[cell use]
use bb200tr -1120 -600 -100 0 frame
xform 0 160 224
use controlCmds -832 455 100 0 controlCmds#68
xform 0 -720 560
use hwin -128 183 100 0 hwin#44
xform 0 -32 224
p -125 216 100 0 -1 val(in):$(IDLE)
use hwin -128 247 100 0 hwin#45
xform 0 -32 288
p -125 280 100 0 -1 val(in):$(IDLE)
use hwin -128 311 100 0 hwin#46
xform 0 -32 352
p -125 344 100 0 -1 val(in):$(IDLE)
use hwin -128 119 100 0 hwin#43
xform 0 -32 160
p -224 112 100 0 -1 val(in):$(top)debugLevel
use softCmds -832 679 100 0 softCmds#56
xform 0 -720 784
use ecars 576 455 100 0 ecars#25
xform 0 736 624
p 688 448 100 1024 -1 name:$(top)activeC
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
p 176 -32 100 1024 -1 name:$(top)carComb
use hwin -128 471 100 0 hwin#49
xform 0 -32 512
p -125 504 100 0 -1 val(in):$(IDLE)
use hwin -128 375 100 0 hwin#42
xform 0 -32 416
p -125 408 100 0 -1 val(in):$(IDLE)
[comments]
