[schematic2]
uniq 11
[tools]
[detail]
w -40 203 100 0 FLNK efanouts.efanouts#0.FLNK -128 192 96 192 outhier.FLNK.p
w -34 75 100 0 FULL efanouts.efanouts#0.LNK4 -128 64 96 64 outhier.FULL.p
w -34 107 100 0 FAST efanouts.efanouts#0.LNK3 -128 96 96 96 outhier.FAST.p
w -34 139 100 0 VSM efanouts.efanouts#0.LNK2 -128 128 96 128 outhier.VSM.p
w -40 171 100 0 NONE efanouts.efanouts#0.LNK1 -128 160 96 160 outhier.NONE.p
w -482 91 100 0 SLNK inhier.SLNK.P -560 80 -368 80 efanouts.efanouts#0.SLNK
w -316 155 100 2 n#2 hwin.hwin#1.in -320 160 -320 160 efanouts.efanouts#0.SELL
s 144 -320 100 0 Gemini Weather Server
s 144 -384 100 0 Simulation Mask Fanout
s -144 -432 100 0 Pedro Gigoux
s -128 -464 100 0 29/Jul/98
[cell use]
use outhier 112 64 100 0 FULL
xform 0 80 64
use outhier 112 192 100 0 FLNK
xform 0 80 192
use outhier 112 160 100 0 NONE
xform 0 80 160
use outhier 112 128 100 0 VSM
xform 0 80 128
use outhier 112 96 100 0 FAST
xform 0 80 96
use inhier -640 80 100 0 SLNK
xform 0 -560 80
use ba200tr -992 -600 -100 0 frame
xform 0 -192 24
use hwin -512 119 100 0 hwin#1
xform 0 -416 160
p -672 160 100 0 -1 val(in):$(top)simMask
use efanouts -368 -57 100 0 efanouts#0
xform 0 -248 96
p -320 -96 100 0 1 SELM:Mask
p -208 -64 100 1024 1 name:$(top)$(sim)Fo
[comments]
