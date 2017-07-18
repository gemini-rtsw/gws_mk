[schematic2]
uniq 1
[tools]
[detail]
w -162 251 100 0 SLNK inhier.SLNK.P -288 240 0 240 estringouts.estringouts#0.SLNK
w 392 331 100 0 FLNK estringouts.estringouts#0.FLNK 256 256 320 256 320 320 512 320 outhier.FLNK.p
w -210 331 100 0 DOL inhier.DOL.P -288 320 -96 320 -96 272 0 272 estringouts.estringouts#0.DOL
w 366 235 100 0 OUT estringouts.estringouts#0.OUT 256 224 512 224 outhier.OUT.p
[cell use]
use ba200tr -672 -424 -100 0 frame
xform 0 128 200
use outhier 480 183 100 0 OUT
xform 0 496 224
use outhier 480 279 100 0 FLNK
xform 0 496 320
use inhier -304 199 100 0 SLNK
xform 0 -288 240
use inhier -304 279 100 0 DOL
xform 0 -288 320
use estringouts 0 167 100 0 estringouts#0
xform 0 128 240
p -64 46 100 0 0 OMSL:closed_loop
p 112 160 100 1024 1 name:$(top)$(src)So
[comments]
