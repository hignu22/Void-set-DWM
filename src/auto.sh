#!/usr/bin/env bash
 
 
while true; do
        date '+  %a %d %b   %R ' > /tmp/CurTime.tmp
        sleep 60s
done &
 
while true; do
 
		LOCALTIME=$(echo $(< /tmp/CurTime.tmp))
 
 
		MEM=$(echo $(free -h --kilo | awk '/^Mem:/ {print $3 "/" $2}'))
		CPU=$(echo "CPU: "$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"%")
 
		BTC=$(echo "1 BTC = $(curl -s https://api.coindesk.com/v1/bpi/currentprice/usd.json | grep -o 'rate":"[^"]*' | cut -d\" -f3) USD")
 
 
 
        xsetroot -name "☭ [ $BTC ][ RAM: $MEM ][ $CPU ][ $LOCALTIME ] ☭" 
        sleep 5s
done &
