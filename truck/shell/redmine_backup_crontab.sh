#!/bin/bash
LOCAL_SUFFIX="`date "+%Y%m%d_%H%M"`"
mkdir -p /root/Data_Backup/${LOCAL_SUFFIX}

cd /root/Redmine

docker run --rm --volumes-from redmine_redmine_1 -v $(pwd):/backup redmine tar cvf /backup/redmine.files.tar /usr/src/redmine/files

docker-compose stop

docker run --rm --volumes-from redmine_redmine_1 -v $(pwd):/backup redmine tar cvf /backup/redmine.config.tar /usr/src/redmine/config
docker run --rm --volumes-from redmine_postgres_1 -v $(pwd):/backup postgres tar cvf /backup/postgres.data.tar /var/lib/postgresql/data

docker-compose up -d

cp -v redmine.config.tar /root/Data_Backup/${LOCAL_SUFFIX}/redmine.config_${LOCAL_SUFFIX}.tar
cp -v redmine.files.tar  /root/Data_Backup/${LOCAL_SUFFIX}/redmine.files_${LOCAL_SUFFIX}.tar
cp -v postgres.data.tar  /root/Data_Backup/${LOCAL_SUFFIX}/postgres.data_${LOCAL_SUFFIX}.tar

mv redmine.config.tar /root/Data_Backup/
mv redmine.files.tar  /root/Data_Backup/
mv postgres.data.tar  /root/Data_Backup/
