#/bin/bash

# Host
host=`./host.sh`

# Login
cookies=`./login.sh`
if [ $? = 255 ]; then
    echo "$0: Login Failed."
    exit 255
fi

# Get Torrent List
dl_list=`curl --silent "${host}/query/torrents?filter=downloading" --cookie "${cookies}" | awk -F'}' '{print NF}'`
let dl_list-=1

# Get qBittorrent preferences
prefer=`curl --silent "${host}/query/preferences" --cookie "${cookies}"`
max_download=`echo ${prefer} | sed -n 's/.*"max_active_downloads":\([0-9]*\),.*/\1/p'`
queue_enabled=`echo ${prefer} | sed -n 's/.*"queueing_enabled":\(true\|false\),.*/\1/p'`

# Check parameters
if [ -z "$queue_enabled" -o -z "$dl_list" -o -z "$max_download" ]; then
    echo "$0: Cannot fetch any parameters."
    exit 255
fi

echo "$0: Enable Queue - ${queue_enabled}."

if [ "$queue_enabled" = "true" ]; then
    echo "$0: Downloading:"${dl_list}" / Limit:"${max_download}
    if [ $dl_list -ge $max_download ]; then
        exit 255
    fi
fi

