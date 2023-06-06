#!/usr/bin/env bash
# export MYSQL_PWD=$muufTransit.

echo 'THETRANSITCLOCK DOCKER: Check if database is runnng.'
RET=1
SUCCESS=0
until [ "$RET" -eq "$SUCCESS" ]; do
	
	mariadb --host "$DB_HOST" --port "$DB_PORT" --user "$DB_USER" --execute "SELECT EXTRACT(DAY FROM TIMESTAMP '2001-02-16 20:38:40');"
	RET="$?"

	if [ "$RET" -ne "$SUCCESS" ]
		then
			echo 'Database is not running.'
			sleep 10
	fi
done
echo 'THETRANSITCLOCK DOCKER: Database is now running.'
