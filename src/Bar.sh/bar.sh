#!/usr/bin/env bash

while true; do
        date '+  %a %d %b   %R ' > /tmp/CurTime.tmp
		
		echo "BTC = $(printf "%.f" $(curl -s https://api.coindesk.com/v1/bpi/currentprice/usd.json | grep -o 'rate":"[^"]*' | cut -d\" -f3 | sed s/\,//)) USD" > /tmp/Bitcoin_Price.tmp
		echo "POW: $(acpi -s | cut -d' ' -f4 | sed 's/.$//')" > /tmp/Batary.tmp
		bash /home/q/Programms/wether/wether1.sh

		sleep 60s
done &


while true; do

		LOCALTIME=$(echo $(< /tmp/CurTime.tmp))

		WETHER=$(echo $(< /tmp/wether.tmp))

		MEM=$(echo $(free -h --kilo | awk '/^Mem:/ {print $3 "/" $2}'))
		CPU=$(echo "CPU: "$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"%")

		BTC1=$(echo $(< /tmp/Bitcoin_Price.tmp))

		UPL=$(echo $(ifstat -i wlo1 1s 1| awk 'NR==3 {print $1}'))
		DOW=$(echo $(ifstat -i wlo1 1s 1| awk 'NR==3 {print $2}'))

		BAT=$(echo $(< /tmp/Batary.tmp))

		BATX=$(echo $(acpi -s | cut -d' ' -f3 | sed 's/.$//'))

		WOD=$(echo "Charging")

		if [ "$BATX" = "$WOD" ]
		then	
			BATZ=$(echo "+")

		else
			BATZ=$(echo "-")

		fi
        xsetroot -name "☭  { [ $BTC1 ][ RAM: $MEM ][ $CPU ][ $BAT$BATZ ][ $LOCALTIME ] }  ☭  " 
        sleep 1s
done &
