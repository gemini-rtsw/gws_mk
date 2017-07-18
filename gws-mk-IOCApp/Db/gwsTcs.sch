[schematic2]
uniq 204
[tools]
[detail]
w 1508 -69 100 2 n#203 hwin.hwin#194.in 1504 -64 1504 -64 eaos.eaos#53.DOL
w 1508 155 100 2 n#202 hwin.hwin#192.in 1504 160 1504 160 eaos.eaos#54.DOL
w 740 -293 100 2 n#201 hwin.hwin#190.in 736 -288 736 -288 eaos.eaos#50.DOL
w 740 -69 100 2 n#200 hwin.hwin#188.in 736 -64 736 -64 eaos.eaos#52.DOL
w 740 155 100 2 n#199 hwin.hwin#186.in 736 160 736 160 eaos.eaos#51.DOL
w 1508 -293 100 2 n#198 hwin.hwin#197.in 1504 -288 1504 -288 eaos.eaos#196.DOL
s 416 -672 100 0 This schematic can be removed if the TCS is modified to match the GWS someday
s 416 -640 100 0 It was easier to have this hack tahn to modify the TCS code.
s 416 -608 100 0 The records here were added to match the record names that the TCS expects.
s 2064 -736 100 0 TCS Interface
s 2016 -672 100 0 Gemini Weather Server
s 1744 -784 100 0 Pedro Gigoux
s 1772 -821 100 0 18/May/04
[cell use]
use hwin 1312 -329 100 0 hwin#197
xform 0 1408 -288
p 1168 -288 100 0 -1 val(in):$(top)wsDew
use hwin 544 119 100 0 hwin#186
xform 0 640 160
p 384 160 100 0 -1 val(in):$(top)wsTemp
use hwin 544 -105 100 0 hwin#188
xform 0 640 -64
p 320 -64 100 0 -1 val(in):$(top)wsWindSpeed
use hwin 544 -329 100 0 hwin#190
xform 0 640 -288
p 336 -288 100 0 -1 val(in):$(top)wsWindDir
use hwin 1312 119 100 0 hwin#192
xform 0 1408 160
p 1152 160 100 0 -1 val(in):$(top)wsPress
use hwin 1312 -105 100 0 hwin#194
xform 0 1408 -64
p 1152 -64 100 0 -1 val(in):$(top)wsHumid
use eaos 1504 -167 100 0 eaos#196
xform 6 1632 -256
p 1584 -304 100 0 1 EGU:%
p 1248 -238 100 0 0 OMSL:closed_loop
p 1552 -176 100 0 1 SCAN:2 second
p 1616 -352 100 1024 -1 name:$(top)dewPoint
use eaos 736 -167 100 0 eaos#50
xform 6 864 -256
p 816 -304 100 0 1 EGU:degrees
p 480 -238 100 0 0 OMSL:closed_loop
p 784 -176 100 0 1 SCAN:2 second
p 864 -352 100 1024 -1 name:$(top)windDirection
use eaos 736 281 100 0 eaos#51
xform 6 864 192
p 816 144 100 0 1 EGU:C
p 480 210 100 0 0 OMSL:closed_loop
p 480 338 100 0 0 PREC:1
p 800 272 100 0 1 SCAN:2 second
p 848 96 100 1024 -1 name:$(top)temp
use eaos 736 57 100 0 eaos#52
xform 6 864 -32
p 816 -80 100 0 1 EGU:m/s
p 480 -14 100 0 0 OMSL:closed_loop
p 480 114 100 0 0 PREC:1
p 784 48 100 0 1 SCAN:2 second
p 864 -128 100 1024 -1 name:$(top)windSpeed
use eaos 1504 57 100 0 eaos#53
xform 6 1632 -32
p 1584 -80 100 0 1 EGU:%
p 1248 -14 100 0 0 OMSL:closed_loop
p 1552 48 100 0 1 SCAN:2 second
p 1616 -128 100 1024 -1 name:$(top)humid
use eaos 1504 281 100 0 eaos#54
xform 6 1632 192
p 1584 144 100 0 1 EGU:hPa
p 1248 210 100 0 0 OMSL:closed_loop
p 1552 272 100 0 1 SCAN:2 second
p 1616 96 100 1024 -1 name:$(top)press
use bb200tr -64 -952 -100 0 frame
xform 0 1216 -128
[comments]
