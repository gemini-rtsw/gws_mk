[schematic2]
uniq 3
[tools]
[detail]
w 19 51 100 0 n#1 hwin.hwin#11.in 16 48 16 48 ecalcouts.ecalcouts#10.INPA
w 26 -6 -100 0 n#2 hwin.hwin#12.in 16 -16 16 -16 ecalcouts.ecalcouts#10.INPC
s 464 480 100 0 Humidity
s 144 480 100 0 Anemometers
s 608 272 100 0 Annex
s 464 272 100 0 RS-485
s 784 480 100 0 Particle Monitor
s -32 272 100 0 Annex
s 784 272 100 0 RS-232
s -176 272 100 0 RS-485
s 740 -48 100 0 Gemini Weather Server
s 698 -110 100 0 Telescope Sensor Serial Buses
s 458 -163 100 0 Pedro Gigoux
s 478 -197 100 0 03/May/02
s 288 272 100 0 Annex
s 144 272 100 0 RS-485
s -176 480 100 0 Temperature
s 928 272 100 0 Annex
[cell use]
use ba200tr -384 -328 -100 0 frame
xform 0 416 296
use snTelBus4 768 231 100 0 snTelBus4#6
xform 0 880 384
p 768 224 100 0 1 seta:port PARTMON
p 768 192 100 0 1 setb:bus 4
p 768 160 100 0 1 setd:dev tp
use snTelBus2 136 231 100 0 snTelBus2#5
xform 0 248 384
p 136 224 100 0 1 seta:port YNGA
p 136 192 100 0 1 setb:bus 2
p 136 160 100 0 1 setd:dev tp
use snTelBus3 448 231 100 0 snTelBus3#3
xform 0 560 384
p 448 224 100 0 1 seta:port VHS
p 448 192 100 0 1 setb:bus 3
p 448 160 100 0 1 setd:dev tp
use snTelBus1 -192 231 100 0 snTelBus1#1
xform 0 -80 384
p -192 224 100 0 1 seta:port DGHT
p -192 192 100 0 1 setb:bus 1
p -192 160 100 0 1 setd:dev tp
use ecalcouts 16 -112 100 0 ecalcouts#10
xform 0 176 -16
p 80 -136 100 0 1 name:$(top)dustHumidity
p 88 -104 100 0 1 CALC:((A > 10) && (C > 70))
p 104 96 100 0 1 SCAN:.5 second
use hwin -176 32 100 0 hwin#11
xform 0 -80 48
p -220 64 100 0 -1 val(in):tws:tpPmPxChan8
use hwin -176 -32 100 0 hwin#12
xform 0 -80 -16
p -217 0 100 0 -1 val(in):tws:dlD1Rh1
[comments]
