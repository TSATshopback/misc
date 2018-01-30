#!/bin/bash


echo "This is for developer's environment only!!!!!"
if [ $# -ne 2 ];
  then
    echo "usage: ./restoreMySQL.sh <Date> <COUNTRY>"
    echo "example: ./restoreMySQL.sh 2018-01-25 TW"
    exit 1
fi

Date=$1
Country=$2

dbs=(adminAnalyticsDB analyticsDB commissionsDB offDB shopilyDB stingrayDB)

PathDBFiles=s3://sbdatabases/Production$Country
#aws s3 ls $PathMongoFiles

LenFiles=${#dbs[@]}

for (( i=0;i<$LenFiles;i++)); do
    aws s3 cp $PathDBFiles/${dbs[${i}]}/$Date.sql.gz  ${dbs[${i}]}.sql.gz
    gunzip  ${dbs[${i}]}.sql.gz
    mysql -uroot -p000000 < ${dbs[${i}]}.sql
done

