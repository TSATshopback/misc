#!/bin/bash


if [ $# -ne 2 ];
  then
    echo "usage: ./restoreMongo.sh <Date> <COUNTRY>"
    echo "example: ./restoreMongo.sh 2018-01-25 TW"
    exit 1
fi

Date=$1
Country=$2

MongoFiles=(accounts.bson accounts.metadata.json accounttokens.bson accounttokens.metadata.json counters.bson counters.metadata.json domains.bson domains.metadata.json)
#MongoFiles=(accounts.metadata.json accounttokens.metadata.json counters.metadata.json domains.metadata.json)

PathMongoFiles=s3://sbdatabases/ProductionMongo$Country/$Date/accounts/
#aws s3 ls $PathMongoFiles

LenFiles=${#MongoFiles[@]}

for (( i=0;i<$LenFiles;i++)); do
    aws s3 cp $PathMongoFiles${MongoFiles[${i}]}  .
done 
for (( i=0;i<$LenFiles;i++)); do
mongorestore --db $Country$Date ${MongoFiles[${i}]}
done 

