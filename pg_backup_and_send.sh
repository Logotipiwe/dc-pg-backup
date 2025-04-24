#!/bin/bash

PG_HOST=$PG_HOST
PG_PORT=$PG_PORT
PG_DB=$PG_DB
PG_USER=$PG_USER
PG_PASS=$PG_PASS
BACKUP_DIR="/backup"
FILE_NAME="pg_backup$PG_DB_$(date +%Y-%m-%d_%H-%M).sql"
TG_BOT_TOKEN=$TG_BOT_TOKEN
TG_CHAT_ID=$TG_CHAT_ID

# === BACKUP ===
echo $PG_USER
echo '-----'
PGPASSWORD="$PG_PASS" pg_dumpall \
  --no-privileges --inserts \
  -d postgresql://$PG_USER@$PG_HOST:$PG_PORT \
  > "$BACKUP_DIR/$FILE_NAME"

# === SEND TO TELEGRAM ===
curl -v -F chat_id="$TG_CHAT_ID" \
     -F document=@"$BACKUP_DIR/$FILE_NAME" \
     "https://api.telegram.org/bot$TG_BOT_TOKEN/sendDocument"

# === CLEANUP ===
rm "$BACKUP_DIR/$FILE_NAME"
