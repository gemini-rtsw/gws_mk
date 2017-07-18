[schematic2]
uniq 2
[tools]
[detail]
w 1284 1979 100 0 n#1 wsPartMonRec.wsPartMonRec#317.FLNK 1248 1976 1320 1976 1320 1552 1856 1552 snMetOneVal.snMetOneVal#315.SLNK
s 1984 1180 100 0 Gemini Weather Server
s 1744 1032 100 0 13/Apr/2012
s 1748 1068 100 0 Tom Cumming
s 1984 1124 100 0 Met One Dust Monitor
[cell use]
use snMetOneVal 1856 1495 100 0 snMetOneVal#315
xform 0 2080 1792
use wsPartMonRec 960 1720 100 0 wsPartMonRec#317
xform 0 1104 1880
p 967 1880 100 0 -1 set2:top $(top)$(dev)$(d1)
p 967 1848 100 0 -1 set3:SCAN 10 second
p 967 1912 100 0 -1 set1:PORT $(port)
[comments]
