#!/usr/bin/env sh

touch /home/piercewang/last_backup_start

echo "Mount drive to /home/piercewang/mount"
if ! sudo mount /dev/disk/by-uuid/d46fcfd7-b897-47be-a3bb-bc2252a15593 /home/piercewang/mount; then
    echo "Mount failed; skipping rsync" >&2
    exit 1
fi

echo "rsync to mounted drive"
rsync -av --delete /var/lib/nextcloud/data/pgwang/files/ /home/piercewang/mount/NextCloud_Data
rsync_status=$?

echo "Unmount drive"
sudo umount /home/piercewang/mount

if [ "$rsync_status" -ne 0 ]; then
    echo "rsync failed" >&2
    exit "$rsync_status"
fi

touch /home/piercewang/last_backup_complete

