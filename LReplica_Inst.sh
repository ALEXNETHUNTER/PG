#!/usr/bin/env bash

PG_DATA="/etc/postgresql/12/main"
ip=$1
touch $PG_DATA/postgresql.conf

echo "listen_addresses = '$1'" >> $PG_DATA/postgresql.conf
echo "max_prepared_transactions = 100" >> $PG_DATA/postgresql.conf
echo "max_wal_senders = 3" >> $PG_DATA/postgresql.conf
echo "wal_level = replica" >> $PG_DATA/postgresql.conf
echo "max_connections = 100" >> $PG_DATA/postgresql.conf
echo "wal_log_hints = on" >> $PG_DATA/postgresql.conf
echo "max_wal_senders = 8" >> $PG_DATA/postgresql.conf

touch $PG_DATA/pg_hba.conf

echo "# TYPE   DATABASE         USER            ADDRESS            METHOD" >> $PG_DATA/pg_hba.conf
echo "host    replication     replication         $1                 md5" >> $PG_DATA/pg_hba.conf

systemctl restart postgresql
