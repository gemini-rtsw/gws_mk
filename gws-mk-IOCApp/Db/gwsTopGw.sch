[schematic2]
uniq 1
[tools]
[detail]
s 224 -320 100 0 17/Oct/01
s 208 -288 100 0 Pedro Gigoux
s 496 -176 100 0 Gemini Telescopes
s 480 -240 100 0 Gemini Weather Server
[cell use]
use ba200tr -640 -456 -100 0 frame
xform 0 160 168
use gws 128 343 100 0 gws#0
xform 0 192 456
p -16 336 100 0 1 seta:top wsg:
p -16 304 100 0 1 setb:GOOD 0
p -16 272 100 0 1 setc:WARNING 1
p -16 240 100 0 1 setd:BAD 2
p 192 336 100 0 1 sete:BOOT 0
p 192 304 100 0 1 setf:INIT 1
p 192 272 100 0 1 setg:RUN 2
p 192 240 100 0 1 seth:BUSY 2
p 192 208 100 0 1 seti:IDLE 0
[comments]
