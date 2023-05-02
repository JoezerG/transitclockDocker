docker-compose run --rm $1 check_db_up.sh
docker-compose run --rm $1 create_tables.sh
docker-compose run --rm $1 import_gtfs.sh
docker-compose run --rm $1 create_api_key.sh
docker-compose run --rm $1 create_webagency.sh
docker-compose up -d $1 
