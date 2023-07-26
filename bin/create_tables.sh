#!/usr/bin/env bash
echo 'THETRANSITCLOCK DOCKER: Create Tables'

# ls -la /usr/local/transitclock/db
mariadb --host "$DB_HOST" --port "$DB_PORT" --user "$DB_USER" -e "CREATE DATABASE IF NOT EXISTS $AGENCYNAME;"

TABLES_EXIST=$(mariadb --host "$DB_HOST" --port "$DB_PORT" --user "$DB_USER" -e "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '$AGENCYNAME' AND TABLE_NAME = 'ActiveRevisions'" --batch --skip-column-names)

if [ "$TABLES_EXIST" -eq 0 ]
	then
		echo "CREAR TABLAS"
		java -cp /usr/local/transitclock/Core.jar org.transitclock.applications.SchemaGenerator -p org.transitclock.db.structs -o /usr/local/transitclock/db
		java -cp /usr/local/transitclock/Core.jar org.transitclock.applications.SchemaGenerator -p org.transitclock.db.webstructs -o /usr/local/transitclock/db
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
	else
		echo "Ya las tablas existen"
fi



