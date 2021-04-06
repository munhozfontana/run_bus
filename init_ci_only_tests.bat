@ECHO OFF
ECHO INIT docker-compose
docker image prune -f
docker-compose up --build -d test
docker-compose down --rmi local --v --remove-orphans -t 0
ECHO FINISH docker-compose