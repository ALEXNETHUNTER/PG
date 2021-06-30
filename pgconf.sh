#!/usr/bin/env bash

PG_DATA="/etc/postgresql/12/main"
PG_CONF=$PG_DATA/postgresql.conf
ip=$1

if [ -f "$PG_CONF" ]; then
    echo "$PG_CONF exists."
	echo "Creating Backup."
	cp $PG_CONF $PG_CONF.BAK
	echo "Removing old config."
	rm -f $PG_CONF
    echo "Creating new config file."
	touch $PG_DATA/postgresql.conf

echo "listen_addresses = '$ip'" >> $PG_DATA/postgresql.conf
echo "max_prepared_transactions = 100" >> $PG_DATA/postgresql.conf
echo "max_wal_senders = 3" >> $PG_DATA/postgresql.conf
echo "wal_level = replica" >> $PG_DATA/postgresql.conf
echo "max_connections = 100" >> $PG_DATA/postgresql.conf
echo "wal_log_hints = on" >> $PG_DATA/postgresql.conf
echo "max_wal_senders = 8" >> $PG_DATA/postgresql.conf

touch $PG_DATA/pg_hba.conf

echo "# TYPE   DATABASE         USER            ADDRESS            METHOD" >> $PG_DATA/pg_hba.conf
echo "host    replication     replication         $ip                 md5" >> $PG_DATA/pg_hba.conf

systemctl restart postgresql

fi

