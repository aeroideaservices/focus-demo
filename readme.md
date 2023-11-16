# Инструкции

### Создать БД kc

```sql
docker-compose exec -t postgres_keycloak pg_dumpall -c -U keycloak > keycloak/dump_keycloak.sql
```

### Восстановить БД из kc
```sql
docker-compose exec -T postgres_keycloak psql -U keycloak < keycloak/dump_keycloak.sql
```

# Установка

1. ```bash docker-compose up -d```
2. Загрузить БД постгрес кейклока (вписать)
3. Закатить фикстуры в demo-service (вписать)


https://youtu.be/RgZyX-e6W9E?si=_yjaIVVnI-aRRCl9