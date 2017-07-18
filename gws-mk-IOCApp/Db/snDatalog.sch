[schematic2]
uniq 4
[tools]
[detail]
w 1678 843 100 0 SLNK inhier.SLNK.P 1600 832 1792 832 snDatalogIO.snDatalogIO#0.SLNK
s 2300 479 100 0 Gemini Weather Server
s 2038 366 100 0 Pedro Gigoux
s 2322 418 100 0 Vaisala Datalogger
s 2055 330 100 0 20/May/15
[cell use]
use inhier 1584 791 100 0 SLNK
xform 0 1600 832
use ba200tr 1184 200 -100 0 frame
xform 0 1984 824
use snDatalogIO 1792 775 100 0 snDatalogIO#0
xform 0 1968 928
p 2016 768 100 0 1 seta1:a1 na
p 1792 672 100 0 1 setd:dev $(dev)
p 1792 768 100 0 1 setd1:d1 $(vsldl)
p 1792 736 100 0 1 seten:evn $(vslevndl)
p 1792 704 100 0 1 setev:evv $(vslevvdl)
[comments]
