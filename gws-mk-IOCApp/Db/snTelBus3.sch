[schematic2]
uniq 2
[tools]
[detail]
w 1728 835 100 0 n#1 timer.timer#22.FLNK 1648 864 1728 864 1728 832 1824 832 snVaisala.snVaisala#23.SLNK
s 2187 379 100 0 Gemini Weather Server
s 2176 320 100 0 Telescope Sensors Bus #2
s 1902 269 100 0 Pedro Gigoux
s 1921 231 100 0 23/Nov/04
[cell use]
use ba200tr 1056 104 -100 0 frame
xform 0 1856 728
use snVaisala 1824 775 100 0 snVaisala#23
xform 0 2000 928
use timer 1464 735 100 0 timer#22
xform 0 1560 824
p 1455 782 100 0 1 setdev:dev $(dev)$(bus)
p 1454 744 100 0 1 setd:delay 1
[comments]
