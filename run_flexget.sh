#/bin/bash
# Basic Config
host="HOST"
username="USERNAME"
password="PASSWORD"

# Login
cookies=`curl -i --silent --data "username=${username}&password=${password}" "${host}/login" | grep Set-Cookie | awk -F': ' '{print \$2}' | awk -F';' '{print \$1}'`
echo ${cookies}

# Get Torrent List
dl_list=`curl --silent "${host}/query/torrents?filter=downloading" --cookie "${cookies}" | awk -F'}' '{print NF}'`
let dl_list-=1

# Get qBittorrent preferences
prefer=`curl --silent "${host}/query/preferences" --cookie "${cookies}"`
max_download=`echo ${prefer} | sed -n 's/.*"max_active_downloads":\([0-9]*\),.*/\1/p'`
queue_enabled=`echo ${prefer} | sed -n 's/.*"queueing_enabled":\(true\|false\),.*/\1/p'`

flexget=`which flexget`

if [ "$queue_enabled" = "true" ]; then
  echo "Queueing is enabled."
  echo "Downloading:"${dl_list}" / Limit:"${max_download}
  if [ $dl_list -ge $max_download ]; then
    ${flexget} --cron execute --learn
  else
    ${flexget} --cron execute
  fi
else
  echo "Queueing is disabled."
  ${flexget} --cron execute
fi

