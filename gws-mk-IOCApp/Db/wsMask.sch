[schematic2]
uniq 2
[tools]
[detail]
w 472 203 100 0 CFHT efanouts.efanouts#0.LNK4 304 224 416 224 416 192 576 192 outhier.CFHT.p
w 456 139 100 0 UKIRT efanouts.efanouts#0.LNK5 304 192 384 192 384 128 576 128 outhier.UKIRT.p
w 416 267 100 0 CTIO efanouts.efanouts#0.LNK3 304 256 576 256 outhier.CTIO.p
w 478 331 100 0 SOAR efanouts.efanouts#0.LNK2 304 288 416 288 416 320 576 320 outhier.SOAR.p
w 462 395 100 0 PACHON efanouts.efanouts#0.LNK1 304 320 384 320 384 384 576 384 outhier.PACHON.p
w 116 315 100 2 n#1 hwin.hwin#6.in 112 320 112 320 efanouts.efanouts#0.SELL
w -34 251 100 0 SLNK inhier.SLNK.P -96 240 64 240 efanouts.efanouts#0.SLNK
s 544 -144 100 0 Gemini Weather Server
[cell use]
use ba200tr -576 -424 -100 0 frame
xform 0 224 200
use outhier 544 279 100 0 SOAR
xform 0 560 320
use hwin -80 279 100 0 hwin#6
xform 0 16 320
p -272 320 100 0 -1 val(in):$(top)wsSelMask
use inhier -112 199 100 0 SLNK
xform 0 -96 240
use outhier 544 87 100 0 UKIRT
xform 0 560 128
use outhier 544 151 100 0 CFHT
xform 0 560 192
use outhier 544 215 100 0 CTIO
xform 0 560 256
use outhier 544 343 100 0 PACHON
xform 0 560 384
use efanouts 64 103 100 0 efanouts#0
xform 0 184 256
p 144 400 100 0 1 SELM:Mask
p 176 96 100 1024 1 name:$(top)$(src)Fanout
[comments]
