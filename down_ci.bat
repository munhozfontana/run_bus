@ECHO OFF
ECHO INIT docker-compose
docker-compose down --rmi local --v --remove-orphans -t 0
ECHO FINISH docker-compose
