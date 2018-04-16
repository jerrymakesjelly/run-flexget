#/bin/bash

# Host
host=`./host.sh`

# Login
cookies=`./login.sh`
if [ $? = 255 ]; then
    echo "login.sh: Login Failed."
    exit 255
fi

# Get qBittorrent speed preferences
transfer_info=`curl --silent "${host}/query/transferInfo" --cookie "${cookies}"`
global_speed=`echo ${transfer_info} | sed -n 's/.*"dl_info_speed":\([0-9]*\),.*/\1/p'`
global_speed_limit=`echo ${transfer_info} | sed -n 's/.*"dl_rate_limit":\([0-9]*\),.*/\1/p'`

# Check parameters
if [ -z "$global_speed" -o -z "$global_speed_limit" ]; then
    echo "$0: Cannot fetch any parameters."
    echo "$0: Debug Info: ${transfer_info}"
    exit 255
fi

global_speed=`expr $global_speed / 1024 / 1024`
global_speed_limit=`expr $global_speed_limit / 1024 / 1024`
rate=`expr 100 \* $global_speed / $global_speed_limit`

echo "$0: Download Speed:${global_speed}MB/s - Download Speed Limit:${global_speed_limit}MB/s - ${rate}%"

if [ $rate -ge 90 ]; then
    exit 255
fi

