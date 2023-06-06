#!/usr/bin/env bash
echo 'THETRANSITCLOCK DOCKER: Process test AVL.'
# This is to substitute into config file the env values.
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_HOST"#"$DB_HOST"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_PORT"#"$DB_PORT"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_USER"#"$DB_USER"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"DB_PASS"#"$MYSQL_PWD"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"AGENCYNAME"#"$AGENCYNAME"#g {} \;
find /usr/local/transitclock/config/ -type f -exec sed -i s#"GTFSRTVEHICLEPOSITIONS"#"$GTFSRTVEHICLEPOSITIONS"#g {} \;


mariadb \
	--host "$DB_HOST" \
	--port "$DB_PORT" \
	--user "$DB_USER" \
	--database $AGENCYNAME \
	-e "SELECT distinct time::date as thedate FROM public.avlreports order by thedate;"

# psql -h "$DB_HOST" -p "$DB_PORT" -U postgres -d $AGENCYNAME -t -c "SELECT distinct time::date as mydate FROM public.avlreports order by mydate;"|xargs -I {} echo {}


# This will process AVL using the set of transitime config files in the test directory.
#find /usr/local/transitclock/config/test/ -type f | sort -n | xargs -I {} java -Xmx2048m -Xss12m -Duser.timezone=EST -Dtransitclock.configFiles={} -Dtransitclock.core.agencyId=$AGENCYID -Dtransitclock.logging.dir=/usr/local/transitclock/logs/ -jar $TRANSITCLOCK_CORE/transitclock/target/Core.jar -configRev 0 \;
java -Xmx2048m -Xss12m -Duser.timezone=EST -Dtransitclock.configFiles=/usr/local/transitclock/config/test/transitclockConfig1.xml -Dtransitclock.core.agencyId=$AGENCYID -Dtransitclock.logging.dir=/logs/ -jar /usr/local/transitclock/Core.jar -configRev 0
java -Xmx2048m -Xss12m -Dnet.sf.ehcache.disabled=false -Duser.timezone=EST -Dtransitclock.configFiles=/usr/local/transitclock/config/test/transitclockConfig1.xml -Dtransitclock.core.agencyId=$AGENCYID -Dtransitclock.logging.dir=/usr/local/transitclock/logs/ -cp usr/local/transitclock/Core.jar org.transitclock.applications.UpdateTravelTimes 07-10-2017 07-10-2017

java -Xmx2048m -Xss12m -Duser.timezone=EST -Dtransitclock.configFiles=/usr/local/transitclock/config/test/transitclockConfig2.xml -Dtransitclock.core.agencyId=$AGENCYID -Dtransitclock.logging.dir=/usr/local/transitclock/logs/ -jar /usr/local/transitclock/Core.jar -configRev 0
java -Xmx2048m -Xss12m -Dnet.sf.ehcache.disabled=false -Duser.timezone=EST -Dtransitclock.configFiles=/usr/local/transitclock/config/test/transitclockConfig2.xml -Dtransitclock.core.agencyId=$AGENCYID -Dtransitclock.logging.dir=/usr/local/transitclock/logs/ -cp usr/local/transitclock/Core.jar org.transitclock.applications.UpdateTravelTimes 07-10-2017 07-11-2017

java -Xmx2048m -Xss12m -Duser.timezone=EST -Dtransitclock.configFiles=/usr/local/transitclock/config/test/transitclockConfig3.xml -Dtransitclock.core.agencyId=$AGENCYID -Dtransitclock.logging.dir=/usr/local/transitclock/logs/ -jar /usr/local/transitclock/Core.jar -configRev 0
java -Xmx2048m -Xss12m -Dnet.sf.ehcache.disabled=false -Duser.timezone=EST -Dtransitclock.configFiles=/usr/local/transitclock/config/test/transitclockConfig3.xml -Dtransitclock.core.agencyId=$AGENCYID -Dtransitclock.logging.dir=/usr/local/transitclock/logs/ -cp usr/local/transitclock/Core.jar org.transitclock.applications.UpdateTravelTimes 07-10-2017 07-12-2017

java -Xmx2048m -Xss12m -Duser.timezone=EST -Dtransitclock.configFiles=/usr/local/transitclock/config/test/transitclockConfig4.xml -Dtransitclock.core.agencyId=$AGENCYID -Dtransitclock.logging.dir=/usr/local/transitclock/logs/ -jar /usr/local/transitclock/Core.jar -configRev 0
java -Xmx2048m -Xss12m -Dnet.sf.ehcache.disabled=false -Duser.timezone=EST -Dtransitclock.configFiles=/usr/local/transitclock/config/test/transitclockConfig4.xml -Dtransitclock.core.agencyId=$AGENCYID -Dtransitclock.logging.dir=/usr/local/transitclock/logs/ -cp usr/local/transitclock/Core.jar org.transitclock.applications.UpdateTravelTimes 07-10-2017 07-13-2017
