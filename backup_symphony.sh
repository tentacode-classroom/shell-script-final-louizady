CURRENT_DIRECTORY=`dirname $0`
echo current : $CURRENT_DIRECTORY

#!/bin/bash

DOTENV=$CURRENT_DIRECTORY/Symfony/.env

DBUSER= ` cat $DOTENV | grep -o -P '(?<=://).*(?=:) '` 
DBPASSWORD= ` cat $DOTENV | cut -d: -f2 | grep -o -P '(?<=:).*(?=@)' ` 
DBNAME= `cat $DOTENV | cut -d: -f3 | grep -o -P '(?<=/)'` 

# date du jour
backupdate=$(date +%Y-%m-%d)

#répertoire de backup
dirbackup= $CURRENT_DIRECTORY/backups

# création du répertoire de backup
mkdir -p $dirbackup

# sauvegarde mysql
mysqldump --user=$DBUSER --password=$DBPASSWORD --databases=$DBNAME | gzip $dirbackup/$backupdate-backup.sql.gz 