@ECHO OFF
ECHO INIT docker-compose
docker image prune -f
docker-compose up --build -d
ECHO FINISH docker-compose
