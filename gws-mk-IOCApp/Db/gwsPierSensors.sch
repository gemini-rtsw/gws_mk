[schematic2]
uniq 1
[tools]
[detail]
s -160 480 100 0 Temperature
s 478 -197 100 0 18/Feb/15
s 458 -163 100 0 C. Urrutia
s 698 -110 100 0 Pier lab. Sensor Serial Buses
s 740 -48 100 0 Gemini Weather Server
s -160 272 100 0 RS-485
s -32 272 100 0 Annex
s 288 480 100 0 Barometric
s 288 272 100 0 RS-485
s 416 272 100 0 Annex
[cell use]
use ba200tr -384 -328 -100 0 frame
xform 0 416 296
use snPierBus2 256 231 100 0 snPierBus2#10
xform 0 368 384
p 256 224 100 0 1 seta:port PLB
p 256 192 100 0 1 setb:bus 2
p 256 160 100 0 1 setd:dev pl
use snPierBus1 -176 231 100 0 snPierBus1#7
xform 0 -64 384
p -176 224 100 0 1 seta:port PLT
p -176 192 100 0 1 setb:bus 1
p -176 160 100 0 1 setd:dev pl
[comments]
