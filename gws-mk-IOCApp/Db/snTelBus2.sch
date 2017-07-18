[schematic2]
uniq 2
[tools]
[detail]
w 1744 771 100 0 n#1 timer.timer#22.FLNK 1848 800 1964 800 1964 768 2016 768 snYoung.snYoung#19.SLNK
s 1921 231 100 0 03/May/02
s 1902 269 100 0 Pedro Gigoux
s 2160 320 100 0 Telescope Sensors Bus #2
s 2187 379 100 0 Gemini Weather Server
[cell use]
use ba200tr 1056 104 -100 0 frame
xform 0 1856 728
use timer 1664 671 100 0 timer#22
xform 0 1760 760
p 1653 713 100 0 1 setdev:dev $(dev)$(bus)
p 1654 680 100 0 1 setd:delay 1
use snYoung 2016 711 100 0 snYoung#19
xform 0 2192 864
[comments]
