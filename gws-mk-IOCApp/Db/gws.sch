[schematic2]
uniq 11
[tools]
[detail]
s 560 -240 100 0 Top Level
s 226 -326 100 0 17/Oct/01
s 208 -288 100 0 Pedro Gigoux
s 480 -176 100 0 Gemini Weather Server
[cell use]
use gwsPrecipitation 384 263 100 0 gwsPrecipitation#10
xform 0 496 384
p 384 256 100 0 -1 seta:pstop bps:
use gwsMonitors 384 -25 100 0 gwsMonitors#9
xform 0 496 96
use gwsSensorIO 32 -25 100 0 gwsSensorIO#8
xform 0 144 96
use gwsCommands -320 263 100 0 gwsCommands#6
xform 0 -208 384
use gwsWS -320 -25 100 0 gwsWS#5
xform 0 -208 96
use gwsStatus 32 263 100 0 gwsStatus#2
xform 0 144 384
use ba200tr -640 -456 -100 0 frame
xform 0 160 168
[comments]
