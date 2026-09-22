#!/usr/bin/env sh

touch /home/piercewang/last_backup_start

echo "Mount drive to /home/piercewang/mount"
sudo mount /dev/disk/by-uuid/d46fcfd7-b897-47be-a3bb-bc2252a15593 /home/piercewang/mount
echo "rsync to mounted drive"
rsync -av --delete /var/lib/nextcloud/data/pgwang/files/ /home/piercewang/mount/NextCloud_Data
echo "Unmount drive"
sudo umount /dev/disk/by-uuid/d46fcfd7-b897-47be-a3bb-bc2252a15593

touch /home/piercewang/last_backup_complete
