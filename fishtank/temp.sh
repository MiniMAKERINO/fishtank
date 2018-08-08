#!/bin/sh

LOW_ALARM=20
HIGH_ALARM=28

get_temp()
{
	 sed -n 's/.*t=\([0-9][0-9]\)\([0-9][0-9]\).*/\1.\2/p' /sys/bus/w1/devices/28-000005fad4d3/w1_slave 

}

	temp=`get_temp`
	echo $temp > current_temp
	int_temp=`expr $temp : '\([0-9][0-9]\).*'`
	rrdtool update temperature.rrd N:$temp
	cat >currtemp.html <<EOF
<h2> Current temperature:
${temp}&deg;C </h2>
EOF

	./graph.sh
	if  test $int_temp -lt $LOW_ALARM || test $int_temp -ge $HIGH_ALARM
	then
		{
		 cat <<EOF
		   Temperature alarm n Fishtank at work
		   Temp is $temp
EOF
		} | echo mail -s 'Temp alaert' peter.chubb@data61.csiro.au
        fi
