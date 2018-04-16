#/bin/bash

# Host
host=`./host.sh`

# Login Information
username="USERNAME"
password="PASSWORD"

# Login
result=`curl -i --silent --data "username=${username}&password=${password}" "${host}/login" | grep Set-Cookie | awk -F': ' '{print \$2}' | awk -F';' '{print \$1}'`
echo ${result}

if [ -z "$result" ]; then
    exit 255
fi