#!/usr/bin/env bash
echo 'THETRANSITCLOCK DOCKER: Import GTFS file.'
# This is to substitute into config file the env values.
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_HOST"#"$DB_HOST"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_PORT"#"$DB_PORT"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_USER"#"$DB_USER"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_PASS"#"$MYSQL_PWD"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"AGENCYNAME"#"$AGENCYNAME"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"AGENCYID"#"$AGENCYID"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"GTFSRTVEHICLEPOSITIONS"#"$GTFSRTVEHICLEPOSITIONS"#g {} \;

DATA_EXIST=$(mariadb --host "$DB_HOST" --port "$DB_PORT" --user "$DB_USER" --database "$AGENCYNAME" --execute "SELECT COUNT(*) from ActiveRevisions where configRev = -1;" --batch --skip-column-names)

echo "$DATA_EXIST"

if [ "$DATA_EXIST" -ne 0 ]
	then
		echo "GTFS IMPORT"
		java -Xmx4g -Dtransitclock.core.agencyId=$AGENCYID -Dtransitclock.configFiles=/usr/local/transitclock/config/transitclock.properties -Dtransitclock.logging.dir=/usr/local/transitclock/logs/ -Dlogback.configurationFile=$TRANSITCLOCK_CORE/transitclock/src/main/resouces/logbackGtfs.xml -cp /usr/local/transitclock/Core.jar org.transitclock.applications.GtfsFileProcessor -gtfsUrl $GTFS_URL  -maxTravelTimeSegmentLength 50000.0 -maxDistanceBetweenStops 50000.0 -disableSpecialLoopBackToBeginningCase true
		mariadb \
			--host "$DB_HOST" \
			--port "$DB_PORT" \
			--user "$DB_USER" \
			--database "$AGENCYNAME" \
			-e "UPDATE ActiveRevisions SET configRev=0 WHERE configRev = -1; UPDATE ActiveRevisions SET travelTimesRev=0 WHERE travelTimesRev = -1;"
	else
		echo "Ya hay datos GTFS"
fi

