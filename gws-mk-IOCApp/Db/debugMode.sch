[schematic2]
uniq 105
[tools]
[detail]
w -206 1947 100 0 OUT estringouts.estringouts#99.OUT -288 1936 -64 1936 outhier.OUT.p
w -638 1931 100 0 n#103 embbos.embbos#79.FLNK -768 1952 -672 1952 -672 1920 -544 1920 estringouts.estringouts#99.SLNK
w -686 1899 100 0 n#102 embbos.embbos#79.VAL -768 1888 -544 1888 estringouts.estringouts#99.DOL
s -232 1514 100 0 Gemini Weather Server
s -166 1455 100 0 Debug Mode
s -504 1402 100 0 Pedro Gigoux
s -488 1370 100 0 24/Jul/98
[cell use]
use estringouts -544 1993 100 0 estringouts#99
xform 6 -416 1920
p -608 2114 100 0 0 OMSL:closed_loop
p -416 1840 100 1024 -1 name:$(top)debugSo$(sys)
use ba200tr -1344 1240 -100 0 frame
xform 0 -544 1864
use outhier -96 1895 100 0 OUT
xform 0 -80 1936
use embbos -1024 1831 100 0 embbos#79
xform 0 -896 1920
p -1040 1760 100 0 1 ONST:MIN
p -896 1760 100 0 1 ONVL:1
p -1040 1728 100 0 1 TWST:FULL
p -896 1728 100 0 1 TWVL:2
p -1040 1792 100 0 1 ZRST:NONE
p -896 1792 100 0 1 ZRVL:0
p -912 1824 100 1024 -1 name:$(top)debugMode$(sys)
[comments]
