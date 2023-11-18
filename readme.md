# Инструкции

### Создать БД kc

```sql
docker-compose exec -t postgres_keycloak pg_dumpall -c -U keycloak > keycloak/dump_keycloak.sql
```

### Восстановить БД из kc
```sql

```
# Установка

1. Поднять контейнеры: ```bash docker-compose up -d```
2. Загрузить БД постгрес кейклока: ```docker-compose exec -T postgres_keycloak psql -U keycloak < keycloak/dump_keycloak.sql```
3. Закатить фикстуры в demo-service: ``` docker-compose exec -it dms1 /cli run_fixtures```

# Без докера
1. Поднять контейнеры: ```bash docker-compose up -d   postgres_keycloak   keycloak   minio   postgres_dms1```

https://youtu.be/RgZyX-e6W9E?si=_yjaIVVnI-aRRCl9