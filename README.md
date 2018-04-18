# Run Flexget

![Size](http://img.badgesize.io/jerrymakesjelly/run-flexget/master/run_flexget.sh.svg)

FlexGet will always add torrents, but sometimes we don't want too many torrents in the downloading queue in order to prevent high I/O usage and guarantee UL/DL speed. This script will help you check whether the number of torrents being downloaded or the download speed is over the limit. If not, run flexget to continue adding torrents. Otherwise ignore them.

**Note that** this script only supports qBittorrent.

## Requirements
* Linux
* [qBittorrent](https://github.com/qbittorrent/qBittorrent)

## Setup
```bash
cd run-flexget
```
### Setting up the host
Open the file *host.sh*, and replace *HOST* into your WebUI address. For example:
```bash
host="http://127.0.0.1:8080"
```
### Setting up the username and password
Open the file *login.sh*, and replace *USERNAME* and *PASSWORD* into your username and password of the WebUI. For example:
```bash
username="admin"
password="adminadmin"
```
### Setting up the permission
```bash
chmod +x *.sh
```
### Test your configuration
```bash
./login.sh && echo success || echo fail
```
If you can see **success** on your screen, it means that everything is ok. Otherwise, you should check your configuration.

## Usage
```bash
./check_max_dl_limit.sh && ./check_max_dl_speed.sh && flexget execute || flexget execute --learn
```
You can add it to your crontab file, but don't forget to use absolute path.

You can simply add this script to the configuration file of crontab.

## Additional Notes
The *check_max_dl_limit.sh* looks up the Maximum active downloads:

![settings_screenshot](https://user-images.githubusercontent.com/6760674/38170420-d1b47852-35b7-11e8-9217-5973891467ca.png)

And *check_max_dl_speed.sh* looks up the Global Download Rate Limit:

![screenshot2](https://user-images.githubusercontent.com/6760674/38940548-f3f7b872-435c-11e8-8023-ea2279416f53.png)