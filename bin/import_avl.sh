#!/usr/bin/env bash
echo 'THETRANSITCLOCK DOCKER: Import test AVL.'

psql \
	-h "$DB_HOST" \
	-p "$DB_PORT" \
	-U postgres \
	-d $AGENCYNAME \
	-c "\COPY avlreports FROM '/usr/local/transitclock/data/avl.csv';"
