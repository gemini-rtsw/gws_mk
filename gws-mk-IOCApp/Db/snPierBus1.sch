[schematic2]
uniq 2
[tools]
[detail]
w 1768 747 100 0 n#1 timer.timer#20.FLNK 1752 776 1792 776 1792 736 1824 736 snDghPier.snDghPier#22.SLNK
s 1921 231 100 0 03/May/02
s 1902 269 100 0 Pedro Gigoux
s 2160 320 100 0 Telescope Sensors Bus #1
s 2187 379 100 0 Gemini Weather Server
[cell use]
use ba200tr 1056 104 -100 0 frame
xform 0 1856 728
use snDghPier 1824 679 100 0 snDghPier#22
xform 0 2000 832
use timer 1568 647 100 0 timer#20
xform 0 1664 736
p 1557 693 100 0 1 setdev:dev $(dev)$(bus)
[comments]
