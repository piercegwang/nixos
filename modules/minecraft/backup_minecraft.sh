#!/usr/bin/env sh

touch /home/piercewang/last_minecraft_backup_start

tar -cvf Matcha_`date +"%Y%m%d"`.zip /var/lib/minecraft/world
cp Matcha_`date +"%Y%m%d"`.zip /home/piercewang/minecraft-backups

touch /home/piercewang/last_minecraft_backup_complete
