#!/bin/bash
set -e

REPO=""
VOLUMES=""
BACKUPS=""

read -s -p "enter restic password:" RESTIC_PASSWORD && export RESTIC_PASSWORD

echo -e "\nadding vaultwarden data to backup"
sqlite3 $VOLUMES/vaultwarden/db.sqlite3 ".backup '$BACKUPS/vaultwarden/db.sqlite3'"
rsync -ap $VOLUMES/vaultwarden/config.json $VOLUMES/vaultwarden/attachments $VOLUMES/vaultwarden/sends $VOLUMES/vaultwarden/rsa_key* $BACKUPS/vaultwarden/

# echo "adding mailcow data to backup"
# MAILCOW_BACKUP_LOCATION=$BACKUPS/mailcow THREADS=4 /mailcow-dockerized/helper-scripts/backup_and_restore.sh backup all --delete-days 1

echo "adding plex data to backup"
rsync -ap $VOLUMES/plex/config/ $BACKUPS/plex/ --exclude Cache

echo "adding overseerr data to backup"
rsync -ap $VOLUMES/overseerr $BACKUPS

echo "adding qbittorrent data to backup"
rsync -ap $VOLUMES/qbittorrent $BACKUPS/qbittorrent

echo "adding calibre-web data to backup"
rsync -ap $VOLUMES/calibre-web/app.db $BACKUPS/calibre-web

echo "adding grafana data to backup"
sqlite3 $VOLUMES/grafana/grafana.db ".backup '$BACKUPS/grafana/grafana.db'"

echo "adding docker daemon.json to backup"
cp /etc/docker/daemon.json $BACKUPS/docker/daemon.json

echo "deleting old sabnzbd backups"
cd $BACKUPS/sabnzbd
ls -tp | grep -v '/$' | tail -n +6 | xargs -d '\n' -r rm --

echo "cleaning backups"
restic -r "$REPO" forget --keep-daily 1 --keep-weekly 2 --keep-monthly 4 --keep-yearly 1 --prune --cleanup-cache
restic -r "$REPO" check

echo "backing everything up with restic"
restic -r "$REPO" backup /home/username --exclude-file=./exclude-files.txt
