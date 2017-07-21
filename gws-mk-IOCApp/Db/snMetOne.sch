[schematic2]
uniq 3
[tools]
[detail]
w 1316 1987 100 0 n#1 wsPartMonRec.wsPartMonRec#317.FLNK 1288 1984 1344 1984 1344 1552 1856 1552 snMetOneVal.snMetOneVal#315.SLNK
w 866 1986 -100 0 n#2 inhier.SLNK.P 856 1984 936 1984 wsPartMonRec.wsPartMonRec#317.SLNK
s 1984 1180 100 0 Gemini Weather Server
s 1744 1032 100 0 13/Apr/2012
s 1748 1068 100 0 Tom Cumming
s 1984 1124 100 0 Met One Dust Monitor
[cell use]
use snMetOneVal 1856 1495 100 0 snMetOneVal#315
xform 0 2080 1792
use wsPartMonRec 968 1728 100 0 wsPartMonRec#317
xform 0 1112 1888
p 1016 1889 100 0 -1 set2:top $(top)$(dev)$(d1)
p 1015 1861 100 0 -1 set3:SCAN 10 second
p 1014 1912 100 0 -1 set1:PORT $(port)
p 1016 1834 100 0 -1 set4:ADDR $(ADDR)
use inhier 835 1952 100 0 SLNK
xform 0 856 1984
[comments]
