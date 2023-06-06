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
MYSQL_PWD=muufTransit.
GTFSRTVEHICLEPOSITIONS=http://10.10.80.53:3001/gtfsrealtime
GTFSSTATICFILE=http://10.10.80.53:8000
```

### 2. Build server instance image

Build trasitclock image

```bash
docker build --no-cache -t transitclock-muuf:{creationDate} .
```

### 3. Add the image server to docker-compose

Add the service with the server image to do docker-compose.yaml

```yaml
tt-companyName:
  image: transitclock-muuf:{creationDate}
  container_name: tt-companyName
  restart: unless-stopped
  ports:
    - 8081:8080
  volumes:
    - ./logs/tt-companyName:/usr/local/transitclock/logs/
    - ./ehcache/tt-companyName:/usr/local/transitclock/cache/
  environment:
    - DB_USER=${DB_USER}
    - MYSQL_PWD=${DB_PASS}
    - DB_HOST=${DB_HOST}
    - DB_PORT=${DB_PORT}
    - AGENCYNAME=agencyname
    - AGENCYID=93 #ID of the agency on the static GTFS
    - GTFS_URL=${GTFSSTATICFILE}/gtfs_tio_envigado.zip # static gtfs url
    - GTFSRTVEHICLEPOSITIONS=${GTFSRTVEHICLEPOSITIONS}/93 # GTFSRT protbuf url
```

### 4. Run init script

Run de ./go.sh file with the name of the service declared before

```bash
./go.sh tt-companyName
```

### 5. Check running services

```bash
docker-compose ps
```

Output:

```bash
     Name                    Command               State                    Ports
---------------------------------------------------------------------------------------------------
transticlock-db   docker-entrypoint.sh postgres    Up      0.0.0.0:5432->5432/tcp,:::5432->5432/tcp
tt-combuses       /usr/local/bin/mvn-entrypo ...   Up      0.0.0.0:8082->8080/tcp,:::8082->8080/tcp
tt-tioenvigado    /usr/local/bin/mvn-entrypo ...   Up      0.0.0.0:8081->8080/tcp,:::8081->8080/tcp
```
