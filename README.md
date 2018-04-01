# Run Flexget

![Size](http://img.badgesize.io/jerrymakesjelly/run-flexget/master/run_flexget.sh.svg)

FlexGet will always add torrents, but sometimes we don't want too many torrents in the downloading queue in order to prevent high I/O usage and guarantee UL/DL speed. This script will help you check whether the number of torrents being downloaded is over the limit. If not, run flexget to continue adding torrents. Otherwise ignore them.

**Note that** this script only supports qBittorrent.

## Requirements
* Linux
* [FlexGet](https://github.com/Flexget/Flexget)
* [qBittorrent](https://github.com/qbittorrent/qBittorrent)

## Run
Modify the script, and replace *HOST*, *USERNAME* and *PASSWORD* into your own. And then,

```bash
    ./run_flexget.sh
```

You can simply add this script to the configuration file of crontab.

## Principle
The script looks at the maximum active downloads in the settings, as shown below.

![settings_screenshot](https://user-images.githubusercontent.com/6760674/38170420-d1b47852-35b7-11e8-9217-5973891467ca.png)

If torrent queueing is enabled and reach the maximum limit, the script will run:

```bash
    flexget --cron execute --learn
```

Otherwise, the script will run:

```bash
    flexget --cron execute
```