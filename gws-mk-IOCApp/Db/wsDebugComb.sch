[schematic2]
uniq 226
[tools]
[detail]
w 228 667 100 2 n#225 hwin.hwin#208.in 224 672 224 672 egenSub.egenSub#183.INPJ
w 228 731 100 2 n#224 hwin.hwin#207.in 224 736 224 736 egenSub.egenSub#183.INPI
w 228 795 100 2 n#223 hwin.hwin#206.in 224 800 224 800 egenSub.egenSub#183.INPH
w 228 859 100 2 n#222 hwin.hwin#205.in 224 864 224 864 egenSub.egenSub#183.INPG
w 228 923 100 2 n#221 hwin.hwin#202.in 224 928 224 928 egenSub.egenSub#183.INPF
w 194 1067 100 0 n#220 hwin.hwin#182.in 225 1056 224 1056 egenSub.egenSub#183.INPD
w 228 987 100 2 n#219 hwin.hwin#163.in 224 992 224 992 egenSub.egenSub#183.INPE
w 228 1115 100 2 n#218 hwin.hwin#161.in 224 1120 224 1120 egenSub.egenSub#183.INPC
w 228 1179 100 2 n#217 hwin.hwin#160.in 224 1184 224 1184 egenSub.egenSub#183.INPB
w 228 1243 100 2 n#216 hwin.hwin#158.in 224 1248 224 1248 egenSub.egenSub#183.INPA
w 610 1291 100 0 DEBUG egenSub.egenSub#183.VALA 512 1280 768 1280 outhier.DEBUG.p
s 992 144 100 0 07/Oct/03
s 960 176 100 0 Pedro Gigoux
s 1232 288 100 0 Gemini Weather Server
s 1200 224 100 0 Weather Station Debug Combine
[cell use]
use hwin 32 631 100 0 hwin#208
xform 0 128 672
p 35 664 100 0 -1 val(in):0
use hwin 32 695 100 0 hwin#207
xform 0 128 736
p 35 728 100 0 -1 val(in):0
use hwin 32 759 100 0 hwin#206
xform 0 128 800
p 35 792 100 0 -1 val(in):0
use hwin 32 823 100 0 hwin#205
xform 0 128 864
p 35 856 100 0 -1 val(in):0
use hwin 32 887 100 0 hwin#202
xform 0 128 928
p 35 920 100 0 -1 val(in):0
use hwin 33 1015 100 0 hwin#182
xform 0 129 1056
p -215 1051 100 0 -1 val(in):$(top)debugLevelSrWs
use hwin 32 951 100 0 hwin#163
xform 0 128 992
p -212 988 100 0 -1 val(in):$(top)debugLevelUkWs
use hwin 32 1079 100 0 hwin#161
xform 0 128 1120
p -212 1116 100 0 -1 val(in):$(top)debugLevelCtWs
use hwin 32 1143 100 0 hwin#160
xform 0 128 1184
p -212 1180 100 0 -1 val(in):$(top)debugLevelCpWs
use hwin 32 1207 100 0 hwin#158
xform 0 128 1248
p -212 1244 100 0 -1 val(in):$(top)debugLevelCfWs
use outhier 736 1239 100 0 DEBUG
xform 0 752 1280
use egenSub 224 487 100 0 egenSub#183
xform 0 368 912
p 1 261 100 0 0 FTA:LONG
p 1 261 100 0 0 FTB:LONG
p 1 229 100 0 0 FTC:LONG
p 1 197 100 0 0 FTD:LONG
p 1 165 100 0 0 FTE:LONG
p 1 101 100 0 0 FTF:LONG
p 1 101 100 0 0 FTG:LONG
p 1 69 100 0 0 FTH:LONG
p 1 37 100 0 0 FTI:LONG
p 1 5 100 0 0 FTJ:LONG
p 1 261 100 0 0 FTVA:LONG
p 256 448 100 0 1 SNAM:maxLongValue
p 384 480 100 1024 -1 name:$(top)wsDebCom
use bb200tr -864 8 -100 0 frame
xform 0 416 832
[comments]
