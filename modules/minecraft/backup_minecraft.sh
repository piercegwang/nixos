#!/usr/bin/env sh

touch /home/piercewang/last_minecraft_backup_start

tar -cvf Rain_`date +"%Y%m%d"`.zip /var/lib/minecraft/world
cp Rain_`date +"%Y%m%d"`.zip ~/minecraft-backups

touch /home/piercewang/last_minecraft_backup_complete
