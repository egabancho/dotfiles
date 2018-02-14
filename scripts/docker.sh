#!/usr/bin/env bash

# Install Docker for Mac
brew cask install docker
brew cask install kitematic
brew install docker-compose-completion
brew install docker-completion

# Build my custom services
docker build -t elasticsearch-egabancho ./docker/es/

# Developer services
docker pull postgres
docker pull rabbitmq
docker pull redis
docker pull elastichq/elasticsearch-hq
docker swarm init
docker service create --name redis --publish 6379:6379 redis
docker service create --name postgres --publish 5432:5432 -e POSTGRES_USER=$USER postgres
docker service create --name elasticsearch --publish 9200:9200 --publish 9300:9300 elasticsearch-egabancho
docker service create --name mysql --publish 3306 --env MYSQL_ALLOW_EMPTY_PASSWORD=True mysql
