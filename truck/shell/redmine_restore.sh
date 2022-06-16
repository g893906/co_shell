#!/bin/bash

docker-compose stop

cd /root/Redmine
cp -v /root/Data_Backup/redmine.config.tar .
cp -v /root/Data_Backup/redmine.files.tar .
cp -v /root/Data_Backup/postgres.data.tar .

docker run --rm --volumes-from shell_redmine_1 -v $(pwd):/backup redmine tar xvf /backup/redmine.config.tar
docker run --rm --volumes-from shell_redmine_1 -v $(pwd):/backup redmine tar xvf /backup/redmine.files.tar
docker run --rm --volumes-from shell_postgres_1 -v $(pwd):/backup postgres tar xvf /backup/postgres.data.tar

cd /home/pi/jonathan/co_shell/truck/shell
docker-compose up -d

cd /root/Redmine
docker cp redmine.files.tar shell_redmine_1:/

docker exec -it shell_redmine_1 bash -c "cd /; tar xvf redmine.files.tar; exit"

rm -f redmine.config.tar redmine.files.tar postgres.data.tar
