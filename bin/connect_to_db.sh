#!/usr/bin/env bash
echo 'THETRANSITCLOCK DOCKER: Connecting to database.'
psql -h "$DB_HOST" -p "$POSTGRES_POST_5432_TCP_PORT" -U postgres -d $AGENCYNAME
