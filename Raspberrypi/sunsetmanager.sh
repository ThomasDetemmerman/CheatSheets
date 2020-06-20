#When should this script be checked
# - Not equal or less then 2.5 minutes, in such cases it's possible that the scrirpt runs two times whithin the same 5 minutes timeframe
# - Not more than 5 minutes, since it can miss the five minute time frame.
# recommended value: 4 (in crontab */4 * * * *)
fiveMin=$((5*60))

sunrise=$(curl -s 'wttr.in/Ninove?format="%S"')
sunset=$(curl -s 'wttr.in/Ninove?format="%s"')

sunrisedate=${sunrise//\"}
sunsetdate=${sunset//\"}$

sunrise=$(date --date=$sunrisedate +%s)
sunset=$(date --date=$sunrisedate +%s)
now=$(date +%s)

echo "$(date): sunrise at $sunrisedate and sunset at $sunsetdate (routine check)" >> /data/usr/sunsetmanager.log

if [ $(($sunrise - $now))  -lt $fiveMin ] && [ $(($sunrise - $now))  -gt 0 ]
then 
    echo "$(date): sunrise whitin 5 minutes ($sunrisedate). Dissabling camera led" >> /data/usr/sunsetmanager.log
    sed -i -e 's/disable_camera_led=0/disable_camera_led=1/g' /boot/config.txt
    shutdown -r +5 "toggeling infrared camera due to sunset. Rebooting withing 5 mins"
fi

if [ $(($sunset - $now))  -lt $fiveMin ] && [ $(($sunset - $now))  -gt 0 ]
then
    echo "$(date): sunset whitin 5 minutes ($sunsetdate). Enabling camera led" >> /data/usr/sunsetmanager.log
    sed -i -e 's/disable_camera_led=1/disable_camera_led=0/g' /boot/config.txt
    shutdown -r +5 "toggeling infrared camera due to sunset. Rebooting withing 5 mins"
fi
