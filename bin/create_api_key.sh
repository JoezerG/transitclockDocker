#!/usr/bin/env bash
echo 'THETRANSITCLOCK DOCKER: Create API key.'
# This is to substitute into config file the env values
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_HOST"#"$DB_HOST"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_PORT"#"$DB_PORT"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_USER"#"$DB_USER"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_PASS"#"$MYSQL_PWD"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"AGENCYNAME"#"$AGENCYNAME"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"AGENCYID"#"$AGENCYID"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"GTFSRTVEHICLEPOSITIONS"#"$GTFSRTVEHICLEPOSITIONS"#g {} \;

KEY_EXIST=$(mariadb --host "$DB_HOST" --port "$DB_PORT" --user "$DB_USER" --database "$AGENCYNAME" --execute "SELECT COUNT(*) from ApiKeys where email = 'muuf@muuf.app'" --batch --skip-column-names)

if [ "$KEY_EXIST" -eq 0 ]
  then
    echo "CREANDO KEY"
    java -cp /usr/local/transitclock/Core.jar org.transitclock.applications.CreateAPIKey -c "/usr/local/transitclock/config/transitclock.properties" -d "foo" -e "muuf@muuf.app" -n "Muuf" -p "123456" -u "https://muuf.app"
  else
    echo "YA EXISTE UNA KEY"
fi