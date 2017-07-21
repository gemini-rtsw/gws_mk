[schematic2]
uniq 2
[tools]
[detail]
w 728 971 100 0 SLNK inhier.SLNK.P 48 968 1408 968 1408 1728 1728 1728 estringouts.estringouts#395.SLNK
w 1632 1971 100 0 RH inhier.RH.P 1536 1968 1728 1968 eaos.eaos#414.DOL
w 1696 1763 100 0 ERRMSG hwin.hwin#415.in 1664 1760 1728 1760 estringouts.estringouts#395.DOL
w 1696 1539 100 0 HEALTH hwin.hwin#417.in 1664 1536 1728 1536 esirs.esirs#164.INP
w 2032 1747 100 0 n#1 estringouts.estringouts#395.FLNK 1984 1744 2080 1744 2080 1600 1648 1600 1648 1376 1728 1376 esirs.esirs#164.SLNK
w 1632 2403 100 0 FLOW eaos.eaos#362.DOL 1728 2400 1536 2400 inhier.FLOW.P
w 1632 2195 100 0 TEMP eaos.eaos#363.DOL 1728 2192 1536 2192 inhier.TEMP.P
w 880 1267 100 0 TS inhier.TS.P 768 1264 992 1264 elongouts.elongouts#392.DOL
w 880 2403 100 0 CHN5 inhier.CHN5.P 768 2400 992 2400 elongouts.elongouts#386.DOL
w 880 2115 100 0 CHN6 inhier.CHN6.P 768 2112 992 2112 elongouts.elongouts#387.DOL
w 880 1827 100 0 CHN7 inhier.CHN7.P 768 1824 992 1824 elongouts.elongouts#388.DOL
w 880 1539 100 0 CHN8 inhier.CHN8.P 768 1536 992 1536 elongouts.elongouts#389.DOL
w 160 2403 100 0 CHN1 inhier.CHN1.P 48 2400 272 2400 elongouts.elongouts#391.DOL
w 160 2115 100 0 CHN2 inhier.CHN2.P 48 2112 272 2112 elongouts.elongouts#384.DOL
w 160 1827 100 0 CHN3 inhier.CHN3.P 48 1824 272 1824 elongouts.elongouts#385.DOL
w 160 1539 100 0 CHN4 inhier.CHN4.P 48 1536 272 1536 elongouts.elongouts#390.DOL
s 1778 1184 90 0 MetOne Particle Monitor Health & Values
s 1826 1208 100 0 Gemini Weather Server
s 1821 1156 100 0 Tom Cumming
s 1958 1153 100 0 13/Apr/2012
n 381 1852 383 1876 100

_
s 1772 1125 100 0 Modified by Mike Westfall 20 Jul 2017
[cell use]
use inhier 32 927 100 0 SLNK
xform 0 48 968
use inhier 1520 2151 100 0 TEMP
xform 0 1536 2192
use inhier 1520 2359 100 0 FLOW
xform 0 1536 2400
use inhier 752 1223 100 0 TS
xform 0 768 1264
use inhier 1520 1927 100 0 RH
xform 0 1536 1968
use inhier 752 2359 100 0 CHN5
xform 0 768 2400
use inhier 752 2071 100 0 CHN6
xform 0 768 2112
use inhier 752 1495 100 0 CHN8
xform 0 768 1536
use inhier 752 1783 100 0 CHN7
xform 0 768 1824
use inhier 32 2359 100 0 CHN1
xform 0 48 2400
use inhier 32 2071 100 0 CHN2
xform 0 48 2112
use inhier 32 1495 100 0 CHN4
xform 0 48 1536
use inhier 32 1783 100 0 CHN3
xform 0 48 1824
use eaos 1728 1847 100 0 eaos#414
xform 0 1856 1936
p 1696 1662 100 0 0 EGU:percent
p 1771 2011 100 0 1 OMSL:supervisory
p 1472 1790 100 0 0 PREC:1
p 1840 1840 100 1024 -1 name:$(top)$(dev)$(d1)RH
use eaos 1728 2071 100 0 eaos#363
xform 0 1856 2160
p 1808 2188 100 0 1 EGU:C
p 1744 2000 100 0 0 EVNT:
p 1775 2235 100 0 1 OMSL:supervisory
p 1808 2112 100 0 1 PREC:2
p 1840 2064 100 1024 -1 name:$(top)$(dev)$(d1)Temp
use eaos 1728 2279 100 0 eaos#362
xform 0 1856 2368
p 1808 2400 100 0 1 EGU:lps
p 1744 2208 100 0 0 EVNT:
p 1764 2443 100 0 1 OMSL:supervisory
p 1808 2320 100 0 1 PREC:2
p 1840 2272 100 1024 -1 name:$(top)$(dev)$(d1)Flow
use estringouts 1728 1655 100 0 estringouts#395
xform 0 1856 1728
p 1664 1534 100 0 0 OMSL:closed_loop
p 1840 1648 100 1024 -1 name:$(top)$(dev)$(d1)Err
use elongouts 272 2279 100 0 elongouts#391
xform 0 400 2368
p 112 2510 100 0 0 EGU:counts
p 316 2449 100 0 1 OMSL:supervisory
p 440 2256 100 512 1 SCAN:Passive
p 384 2272 100 1024 -1 name:$(top)$(dev)$(d1)Chan1
use elongouts 272 1415 100 0 elongouts#390
xform 0 400 1504
p 112 1646 100 0 0 EGU:counts
p 300 1582 100 0 1 OMSL:supervisory
p 384 1408 100 1024 -1 name:$(top)$(dev)$(d1)Chan4
use elongouts 992 1415 100 0 elongouts#389
xform 0 1120 1504
p 832 1646 100 0 0 EGU:counts
p 1028 1589 100 0 1 OMSL:supervisory
p 1104 1408 100 1024 -1 name:$(top)$(dev)$(d1)Chan8
use elongouts 992 1703 100 0 elongouts#388
xform 0 1120 1792
p 832 1934 100 0 0 EGU:counts
p 1030 1878 100 0 1 OMSL:supervisory
p 1104 1696 100 1024 -1 name:$(top)$(dev)$(d1)Chan7
use elongouts 992 1991 100 0 elongouts#387
xform 0 1120 2080
p 832 2222 100 0 0 EGU:counts
p 1030 2156 100 0 1 OMSL:supervisory
p 1104 1984 100 1024 -1 name:$(top)$(dev)$(d1)Chan6
use elongouts 992 2279 100 0 elongouts#386
xform 0 1120 2368
p 832 2510 100 0 0 EGU:counts
p 1035 2447 100 0 1 OMSL:supervisory
p 1104 2272 100 1024 -1 name:$(top)$(dev)$(d1)Chan5
use elongouts 272 1703 100 0 elongouts#385
xform 0 400 1792
p 112 1934 100 0 0 EGU:counts
p 320 1868 100 0 1 OMSL:supervisory
p 384 1696 100 1024 -1 name:$(top)$(dev)$(d1)Chan3
use elongouts 272 1991 100 0 elongouts#384
xform 0 400 2080
p 112 2222 100 0 0 EGU:counts
p 304 2150 100 0 1 OMSL:supervisory
p 384 1984 100 1024 -1 name:$(top)$(dev)$(d1)Chan2
use elongouts 992 1143 100 0 elongouts#392
xform 0 1120 1232
p 1048 1112 100 0 1 EGU:timestamp
p 1035 1319 100 0 1 OMSL:supervisory
p 1104 1136 100 1024 -1 name:$(top)$(dev)$(d1)TS
use esirs 1728 1287 100 0 esirs#164
xform 0 1936 1440
p 1856 1376 100 0 1 FTVL:LONG
p 1856 1408 100 0 1 SNAM:healthSir
p 1840 1280 100 1024 -1 name:$(top)$(dev)$(d1)Hlth
use hwin 1472 1744 100 0 hwin#415
xform 0 1568 1760
p 1423 1779 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.STAT
use hwin 1472 1520 100 0 hwin#417
xform 0 1568 1536
p 1423 1555 100 0 -1 val(in):$(top)$(dev)$(d1)Raw.SEVR
[comments]
