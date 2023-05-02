# TransitTime Docker

## Requirements

- Docker
- GTFS-RT buffer endpoint
- GTFS static file per agency on a URL
- Postgres (9.6) database instance running

## Configuring

### 1. Set enviroments values

Set the enviroments values on .env file

```
PGPASSWORD=muufTransit.
GTFSRTVEHICLEPOSITIONS=http://10.10.80.53:3001/gtfsrealtime
GTFSSTATICFILE=http://10.10.80.53:8000
```

### 2. Build server instance image

```bash
$ docker build build --no-cache -t transitclock-muuf:{agencyName}-{dateGeneration} \
--build-arg TRANSITCLOCK_PROPERTIES="config/transitclock.properties" \
--build-arg AGENCYID="93" \
--build-arg AGENCYNAME="TIOENVIGADO" \
--build-arg GTFS_URL="$GTFSSTATICFILE/gtfs_tio_envigado.zip" \
--build-arg GTFSRTVEHICLEPOSITIONS="$GTFSRTVEHICLEPOSITIONS/93" .
```

### 3. Add the image server to docker-compose

Add the service with the server image to do docker-compose.yaml

```yaml

```
