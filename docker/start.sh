#!/bin/sh

nginx

java -jar /app/api/app.jar --spring.profiles.active=prod --spring.datasource.url="jdbc:mysql://${DB_HOST}:${DB_PORT:-3306}/${DB_NAME}?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true" --spring.datasource.username=${DB_USER} --spring.datasource.password=${DB_PASS} --spring.data.redis.host=${REDIS_HOST} --spring.data.redis.port=${REDIS_PORT} --spring.data.redis.password=${REDIS_PASS} --spring.data.redis.database=${REDIS_DB:-0} --sa-token.is-concurrent=${SA_TOKEN_IS_CONCURRENT:-false} --sa-token.jwt-secret-key=${SA_TOKEN_JWT_SECRET_KEY:-playeduxyz}