#!/bin/bash
cd /root/Redmine

docker-compose stop

cp -v /root/Data_Backup/redmine.config.tar .
cp -v /root/Data_Backup/redmine.files.tar .
cp -v /root/Data_Backup/postgres.data.tar .

docker run --rm --volumes-from redmine_redmine_1 -v $(pwd):/backup redmine tar xvf /backup/redmine.config.tar
docker run --rm --volumes-from redmine_postgres_1 -v $(pwd):/backup postgres tar xvf /backup/postgres.data.tar

docker-compose up -d

docker cp redmine.files.tar redmine_redmine_1:/

docker exec -it redmine_redmine_1 bash -c "cd /; tar xvf redmine.files.tar; exit"

rm -f redmine.config.tar redmine.files.tar postgres.data.tar