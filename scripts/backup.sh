#!/bin/bash

echo "----------------------------"
echo $(date)
echo "----------------------------"

BACKUP_DIR="$MKITE/backups"
DST=$BACKUP_DIR/$(date +"%y%m%d")

kitedb dumpdata > $DST.json
tar -czf $DST.tar.gz $DST.json
rm $DST.json
