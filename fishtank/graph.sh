#!/bin/sh
rrdtool graph smalltemperature.svg -A -a SVG \
	-L 4  --alt-y-grid \
	-h 100 \
	-w 300 \
	-c CANVAS#00000000 \
	-c BACK#00000000 \
	-c SHADEA#FFFFFFFF \
	-c SHADEB#FFFFFFFF \
	-c AXIS#FFFFFFFF \
	-c FONT#FFFFFFFF \
	-c FRAME#FFFFFFFF \
	-c ARROW#FFFFFFFF \
	--border 0 \
	--x-grid MINUTE:30:HOUR:1:HOUR:4:0:%H \
	DEF:temp=temperature.rrd:temp:AVERAGE \
	LINE1:temp#ff0000: \
	VDEF:tempmin=temp,MINIMUM \
	VDEF:tempmax=temp,MAXIMUM \
	VDEF:tempmean=temp,AVERAGE 
rrdtool graph temperature.svg -A -a SVG \
	-L 4  --alt-y-grid \
	-w 700 \
	--x-grid MINUTE:30:HOUR:1:HOUR:4:0:%H \
	DEF:temp=temperature.rrd:temp:AVERAGE \
	LINE1:temp#ff0000: \
	VDEF:tempmin=temp,MINIMUM \
	VDEF:tempmax=temp,MAXIMUM \
	VDEF:tempmean=temp,AVERAGE \
	COMMENT:"Last 24 Hour"\
	COMMENT:"Maximum    "\
	COMMENT:"Minimum    "\
	COMMENT:"Average    \l"\
	COMMENT:"           "\
	GPRINT:tempmax:"%6.2lf %SC"\
	GPRINT:tempmin:"%6.2lf %SC"\
	GPRINT:tempmean:"%6.2lf %SC\l"
MONTH=`date +%B`
rrdtool graph temperature-week.svg -a SVG \
	--end now --start end-1w \
	-L 4  --alt-y-grid \
	-w 700 \
	-A \
	DEF:temp=temperature.rrd:temp:AVERAGE \
	LINE1:temp#ff0000: \
	VDEF:tempmin=temp,MINIMUM \
	VDEF:tempmax=temp,MAXIMUM \
	VDEF:tempmean=temp,AVERAGE \
	COMMENT:"                                            $MONTH\l" \
	COMMENT:"Last Week  "\
	COMMENT:"Maximum    "\
	COMMENT:"Minimum    "\
	COMMENT:"Average    \l"\
	COMMENT:"           "\
	GPRINT:tempmax:"%6.2lf %SC"\
	GPRINT:tempmin:"%6.2lf %SC"\
	GPRINT:tempmean:"%6.2lf %SC\l"

rrdtool graph temperature-2day.svg -A -a SVG \
	-L 4  --alt-y-grid \
	-w 700 \
	--end now --start now-2d\
	--x-grid MINUTE:30:HOUR:1:HOUR:4:0:%H \
	DEF:temp=temperature.rrd:temp:AVERAGE \
	LINE1:temp#ff0000: \
	VDEF:tempmin=temp,MINIMUM \
	VDEF:tempmax=temp,MAXIMUM \
	VDEF:tempmean=temp,AVERAGE \
	COMMENT:"Last 48 Hour"\
	COMMENT:"Maximum    "\
	COMMENT:"Minimum    "\
	COMMENT:"Average    \l"\
	COMMENT:"           "\
	GPRINT:tempmax:"%6.2lf %SC"\
	GPRINT:tempmin:"%6.2lf %SC"\
	GPRINT:tempmean:"%6.2lf %SC\l"

#
# rrdtool create temperature.rrd --step 300 DS:temp:GAUGE:600:-10:40 RRA:AVERAGE:0.5:1:1200 RRA:MIN:0.5:12:2400 RRA:MAX:0.5:12:2400 RRA:AVERAGE:0.5:12:2400
