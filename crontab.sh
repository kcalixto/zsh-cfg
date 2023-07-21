#!/bin/bash
# Obsidian Cron - WIP 
obsidian_cron="0 10 * * * /usr/local/bin/obsidian push -a >/tmp/obsidian.log 2>&1"
echo "$obsidian_cron" > /tmp/obsidian_cron_file
crontab /tmp/obsidian_cron_file
# clean
rm /tmp/obsidian_cron_file