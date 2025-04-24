#!/bin/sh

#./app/pg_backup_and_send.sh
crontab /app/crontab.txt
cron
touch /var/log/cron.log
tail -f /var/log/cron.log
