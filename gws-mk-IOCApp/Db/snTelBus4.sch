[schematic2]
uniq 1
[tools]
[detail]
s 2187 379 100 0 Gemini Weather Server
s 2176 320 100 0 Telescope Sensors Bus #3
s 1902 269 100 0 Pedro Gigoux
s 1921 231 100 0 03/May/02
[cell use]
use ba200tr 1056 104 -100 0 frame
xform 0 1856 728
use snMetOne 1896 703 100 0 snMetOne#26
xform 0 2072 856
p 1864 600 100 0 1 setd:dev $(dev)Pm
use timer 1504 679 100 0 timer#22
xform 0 1600 768
p 1494 722 100 0 1 setdev:dev $(dev)$(bus)
p 1494 688 100 0 1 setd:delay 30
[comments]
