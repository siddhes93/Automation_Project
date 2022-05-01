#!/bin/sh

sudo crontab -l > cron_bkp
sudo echo "0 0 * * * sudo /root/Automation_Project/automation.sh >/dev/null 2>&1" >> cron_bkp
sudo crontab cron_bkp
sudo rm cron_bkp



