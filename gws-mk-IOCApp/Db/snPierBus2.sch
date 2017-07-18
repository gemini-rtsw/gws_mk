[schematic2]
uniq 2
[tools]
[detail]
w 1716 795 100 0 n#1 timer.timer#22.FLNK 1696 800 1744 800 1744 768 2016 768 snYoungBarIO.snYoungBarIO#25.SLNK
s 1921 231 100 0 18/Feb/15
s 1902 269 100 0 C. Urrutia
s 2160 320 100 0 Pier Lab. Sensors Bus #2
s 2187 379 100 0 Gemini Weather Server
[cell use]
use ba200tr 1056 104 -100 0 frame
xform 0 1856 728
use snYoungBarIO 2016 711 100 0 snYoungBarIO#25
xform 0 2192 864
p 2240 704 100 0 1 seta1:a1 $(yngapl)
p 2016 704 100 0 1 setd1:d1 $(yngapl)
p 2240 672 100 0 1 setda1:da1 $(yngdPl)
p 2016 608 100 0 1 seten:evn $(yngevn05)
p 2016 576 100 0 1 setev:evv $(yngevv05)
use timer 1520 671 100 0 timer#22
xform 0 1616 760
p 1509 715 100 0 1 setdev:dev $(dev)$(bus)
[comments]
