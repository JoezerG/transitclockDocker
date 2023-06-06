#!/usr/bin/env bash
echo 'THETRANSITCLOCK DOCKER: Create Tables'

java -cp /usr/local/transitclock/Core.jar org.transitclock.applications.SchemaGenerator -p org.transitclock.db.structs -o /usr/local/transitclock/db
java -cp /usr/local/transitclock/Core.jar org.transitclock.applications.SchemaGenerator -p org.transitclock.db.webstructs -o /usr/local/transitclock/db

# ls -la /usr/local/transitclock/db

mariadb --host "$DB_HOST" --port "$DB_PORT" --user "$DB_USER" -e "CREATE DATABASE $AGENCYNAME;"
mariadb \
	--host "$DB_HOST" \
	--port "$DB_PORT" \
	--user "$DB_USER" \
	--database $AGENCYNAME \
	< /usr/local/transitclock/db/ddl_mysql_org_transitclock_db_structs.sql

mariadb \
	--host "$DB_HOST" \
	--port "$DB_PORT" \
	--user "$DB_USER" \
	--database $AGENCYNAME \
	< /usr/local/transitclock/db/ddl_mysql_org_transitclock_db_webstructs.sql
