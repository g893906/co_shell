#!/bin/bash
LOCAL_SUFFIX="`date "+%Y%m%d_%H%M"`"
mkdir -p /root/Data_Backup/${LOCAL_SUFFIX}
mkdir -p /mnt/Synology_NAS/Drive/raspberry_bakeup/${LOCAL_SUFFIX}

cd /root/Redmine

docker run --rm --volumes-from shell_redmine_1 -v $(pwd):/backup redmine tar cvf /backup/redmine.files.tar /usr/src/redmine/files

cd /home/pi/jonathan/co_shell/truck/shell/ 
docker-compose stop

cd /root/Redmine
docker run --rm --volumes-from shell_redmine_1 -v $(pwd):/backup redmine tar cvf /backup/redmine.config.tar /usr/src/redmine/config
docker run --rm --volumes-from shell_postgres_1 -v $(pwd):/backup postgres tar cvf /backup/postgres.data.tar /var/lib/postgresql/data

cd /home/pi/jonathan/co_shell/truck/shell/ 
docker-compose up -d

cd /root/Redmine
cp -v redmine.config.tar /root/Data_Backup/${LOCAL_SUFFIX}/redmine.config_${LOCAL_SUFFIX}.tar
cp -v redmine.files.tar  /root/Data_Backup/${LOCAL_SUFFIX}/redmine.files_${LOCAL_SUFFIX}.tar
cp -v postgres.data.tar  /root/Data_Backup/${LOCAL_SUFFIX}/postgres.data_${LOCAL_SUFFIX}.tar
cp -v redmine.config.tar /mnt/Synology_NAS/Drive/raspberry_bakeup/${LOCAL_SUFFIX}/redmine.config_${LOCAL_SUFFIX}.tar
cp -v redmine.files.tar  /mnt/Synology_NAS/Drive/raspberry_bakeup/${LOCAL_SUFFIX}/redmine.files_${LOCAL_SUFFIX}.tar
cp -v postgres.data.tar  /mnt/Synology_NAS/Drive/raspberry_bakeup/${LOCAL_SUFFIX}/postgres.data_${LOCAL_SUFFIX}.tar

mv redmine.config.tar /root/Data_Backup/
mv redmine.files.tar  /root/Data_Backup/
mv postgres.data.tar  /root/Data_Backup/
