[schematic2]
uniq 1
[tools]
[detail]
s -48 608 100 0 but it was structured like that to reuse the architecture used in the other sensors
s -48 640 100 0 The datalogger has its own IP address so it's not really a serial bus
s 272 272 100 0 Ethernet
s 740 -48 100 0 Gemini Weather Server
s 698 -110 100 0 Pier lab. Sensor Serial Buses
s 458 -163 100 0 C. Urrutia
s 478 -197 100 0 18/Feb/15
[cell use]
use ba200tr -384 -328 -100 0 frame
xform 0 416 296
use snDatalogBus1 224 231 100 0 snDatalogBus1#11
xform 0 336 384
p 224 224 100 0 1 seta:port VDL
p 224 192 100 0 1 setb:bus 1
p 224 160 100 0 1 setd:dev dl
[comments]
