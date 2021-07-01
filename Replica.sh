#!/usr/bin/env bash

PG_DATA="/etc/postgresql/12/main"
PG_CONF=$PG_DATA/postgresql.conf
PG_CONF_HBA=$PG_DATA/pg_hba.conf
ip=$1

#if [ -f "$PG_CONF" ] 
#
#then
#	echo "$PG_CONF exists."
#	echo "Creating Backup."
#	cp $PG_CONF $PG_CONF.BAK
#	echo "Removing old config."
#	rm -f $PG_CONF
 #  	echo "Creating new config file."
#	touch $PG_DATA/postgresql.conf

echo "listen_addresses = '$ip'" >> $PG_DATA/postgresql.conf
echo "max_prepared_transactions = 100" >> $PG_DATA/postgresql.conf
echo "max_wal_senders = 3" >> $PG_DATA/postgresql.conf
echo "wal_level = replica" >> $PG_DATA/postgresql.conf
echo "max_connections = 100" >> $PG_DATA/postgresql.conf
echo "wal_log_hints = on" >> $PG_DATA/postgresql.conf
echo "max_wal_senders = 8" >> $PG_DATA/postgresql.conf

#elif  [ -f "$PG_CONF_HBA" ] 

#then
#	echo "$PG_CONF_HBA exists."
#	echo "Creating Backup."
#	cp $PG_CONF_HBA $PG_CONF_HBA.BAK
#	echo "Removing old config."
#	rm -f $PG_CONF_HBA
#   	echo "Creating new config file."
#  	touch $PG_DATA/pg_hba.conf

echo "# TYPE   DATABASE         USER            ADDRESS            METHOD" >> $PG_DATA/pg_hba.conf
echo "host    replication     replication         $ip                 md5" >> $PG_DATA/pg_hba.conf

cat /etc/postgresql/12/main/postgresql.conf > /home/devops/PG_test/PG/postgresql.conf
cat /etc/postgresql/12/main/pg_hba.conf > /home/devops/PG_test/PG/pg_hba.conf

systemctl restart postgresql

git add .
git commit -m "Replica"
git push -u origin Replica

#fi
