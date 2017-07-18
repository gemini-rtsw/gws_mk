[schematic2]
uniq 80
[tools]
[detail]
w 1032 875 100 0 SLNK inhier.SLNK.P 960 864 1152 864 esirs.esirs#2.SLNK
s 1670 492 100 0 Gemini Weather Server
s 1718 428 100 0 Debug Level
s 1398 380 100 0 Pedro Gigoux
s 1414 348 100 0 19/Aug/03
[cell use]
use inhier 944 823 100 0 SLNK
xform 0 960 864
use ba200tr 544 216 -100 0 frame
xform 0 1344 840
use esirs 1152 775 100 0 esirs#2
xform 0 1360 928
p 1216 736 100 0 1 FTVL:LONG
p 1216 704 100 0 1 SNAM:debugSir
p 1344 768 100 1024 1 name:$(top)debugLevel$(sys)
[comments]
