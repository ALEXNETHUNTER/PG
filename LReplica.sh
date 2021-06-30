#!/usr/bin/env bash

PG_DATA="/home/devops/PG_test/PG"
U=`whoami`
ip=$1
touch $PG_DATA/postgresql.conf

echo "listen_addresses = '$ip'" >> $PG_DATA/postgresql.conf
echo "max_prepared_transactions = 100" >> $PG_DATA/postgresql.conf
echo "max_wal_senders = 3" >> $PG_DATA/postgresql.conf
echo "wal_level = logical" >> $PG_DATA/postgresql.conf
echo "max_connections = 100" >> $PG_DATA/postgresql.conf
echo "wal_log_hints = on" >> $PG_DATA/postgresql.conf
echo "max_wal_senders = 8" >> $PG_DATA/postgresql.conf
echo "hot_standby = on" >> $PG_DATA/postgresql.conf

touch $PG_DATA/pg_hba.conf

echo "# TYPE   DATABASE  USER  ADDRESS            METHOD" >> $PG_DATA/pg_hba.conf
echo "  host  replication $U    $ip              trust" >> $PG_DATA/pg_hba.conf 
echo "  host     all      $U    $ip              trust" >> $PG_DATA/pg_hba.conf

