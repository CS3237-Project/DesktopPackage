#!/bin/bash

# This script subscribes to a MQTT topic using mosquitto_sub.
# On each message received, you can execute whatever you want.

##directory where jar file is located    
dir=./

##jar file name
jar_name=finespine.jar

##store if alert already open
is_alert_open=false

while true  # Keep an infinite loop to reconnect when connection lost/broker unavailable
do
    mosquitto_sub -h "34.81.217.13" -p "1884" -t "posture" -u "Device6" -P "Password123" | while read -r payload
    do
        # Here is the callback to execute whenever you receive a message:
        size=${#payload} 
        if [ $is_alert_open == "true" ]
        then
            kill -TERM $(cat MyApp.pid)
            is_alert_open=false
        fi
        if [[ ${size} -gt 30 ]]
        then 
            echo "Rx MQTT: bad_posture"
            echo ${payload} > base64.txt
            python3 badPosture.py $payload
            if [ $is_alert_open == "false" ]
            then       
                java -jar $dir/$jar_name &
                echo $! > MyApp.pid
                is_alert_open=true
            fi
        else
            echo "Rx MQTT: ${payload}" 
        fi
    done
    sleep 10  # Wait 10 seconds until reconnection
done # &  # Uncomment the & to run in background (but you should rather run THIS script in background)
