# Инструкции

1. Создать БД kc

```sql
docker-compose exec -t postgres_keycloak pg_dumpall -c -U keycloak > keycloak/dump_keycloak.sql
```
см: https://stackoverflow.com/questions/24718706/backup-restore-a-dockerized-postgresql-database

# Установка

1. ```bash docker-compose up -d```
2. Загрузить БД постгрес кейклока (вписать)
3. Закатить фикстуры в demo-service (вписать)


```sql
docker-compose exec -T postgres_keycloak psql -U keycloak < keycloak/dump_keycloak.sql
```