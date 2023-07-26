#!/usr/bin/env bash
echo 'THETRANSITCLOCK DOCKER: Create WebAgency.'
# This is to substitute into config file the env values
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_HOST"#"$DB_HOST"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_PORT"#"$DB_PORT"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_USER"#"$DB_USER"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_PASS"#"$MYSQL_PWD"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"AGENCYNAME"#"$AGENCYNAME"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"AGENCYID"#"$AGENCYID"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"GTFSRTVEHICLEPOSITIONS"#"$GTFSRTVEHICLEPOSITIONS"#g {} \;

AGENCY_EXIST=$(mariadb --host "$DB_HOST" --port "$DB_PORT" --user "$DB_USER" --database $AGENCYNAME --execute "SELECT COUNT(*) from WebAgencies WHERE agencyId = '$AGENCYID';" --batch --skip-column-names)

if [ "$AGENCY_EXIST" -eq 0 ]
  then
    echo "CREANDO AGENCIA"
    java -Dtransitclock.db.dbName=$AGENCYNAME -Dtransitclock.hibernate.configFile=/usr/local/transitclock/config/hibernate.cfg.xml -Dtransitclock.db.dbHost=$DB_HOST:$DB_PORT -Dtransitclock.db.dbUserName=$DB_USER -Dtransitclock.db.dbPassword=$MYSQL_PWD -Dtransitclock.db.dbType=mysql -cp /usr/local/transitclock/Core.jar org.transitclock.db.webstructs.WebAgency $AGENCYID 127.0.0.1 $AGENCYNAME mysql $DB_HOST $DB_USER $MYSQL_PWD
  else
    echo "LA AGENCIA $AGENCYNAME : $AGENCYID YA EXISTE" 
fi