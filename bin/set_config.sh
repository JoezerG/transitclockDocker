#!/usr/bin/env bash
echo 'THETRANSITCLOCK DOCKER: Set Config.'

find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_HOST"#"$DB_HOST"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_PORT"#"$DB_PORT"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_USER"#"$DB_USER"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_PASS"#"$MYSQL_PWD"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"AGENCYNAME"#"$AGENCYNAME"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"GTFSRTVEHICLEPOSITIONS"#"$GTFSRTVEHICLEPOSITIONS"#g {} \;
