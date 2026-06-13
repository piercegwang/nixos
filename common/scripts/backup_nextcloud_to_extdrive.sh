#!/usr/bin/env sh

touch /home/piercewang/last_backup_start

echo "Mount drive to /home/piercewang/mount"
sudo mount /dev/sda1 /home/piercewang/mount                                          
echo "rsync to mounted drive"
rsync -av /var/lib/nextcloud/data/pgwang/files/ /home/piercewang/mount/NextCloud_Data
echo "Unmount drive"
sudo umount /dev/sda1

touch /home/piercewang/last_backup_complete
