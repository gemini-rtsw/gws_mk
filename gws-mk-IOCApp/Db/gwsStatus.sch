[schematic2]
uniq 6
[tools]
[detail]
w 142 1771 100 0 n#2 ecalcs.ecalcs#0.VAL 320 1504 384 1504 384 1760 -64 1760 -64 1696 32 1696 ecalcs.ecalcs#0.INPA
s 1712 544 100 0 General Status
s 1664 608 100 0 Gemini Weather Server
s 1407 457 100 0 17/Jan/02
s 1393 491 100 0 Pedro Gigoux
[cell use]
use estringouts 1120 871 100 0 estringouts#5
xform 0 1248 944
p 1232 864 100 1024 -1 name:$(top)version
use esirs 32 711 100 0 esirs#3
xform 0 240 864
p 192 832 100 0 1 FTVL:STRING
p 80 672 100 0 1 SNAM:healthSir
p 144 704 100 1024 -1 name:$(top)health
use esirs 544 711 100 0 esirs#4
xform 0 752 864
p 704 832 100 0 1 FTVL:STRING
p 592 672 100 0 1 SNAM:stateSir
p 656 704 100 1024 -1 name:$(top)state
use ecalcs 32 1223 100 0 ecalcs#0
xform 0 176 1488
p 64 1184 100 0 1 CALC:(A%100)+1
p 64 1152 100 0 1 SCAN:1 second
p 144 1216 100 1024 -1 name:$(top)present
use bb200tr -416 328 -100 0 frame
xform 0 864 1152
[comments]
