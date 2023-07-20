#!/bin/bash
# Obsidian Cron
obsidian_cron="* 9 * * * obsidian push -a"
echo "$obsidian_cron" > /tmp/obsidian_cron_file
crontab /tmp/obsidian_cron_file
# clean
rm /tmp/obsidian_cron_file