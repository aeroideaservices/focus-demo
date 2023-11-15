# Инструкции

1. Создать БД kc

```sql
docker-compose exec -t postgres_keycloak pg_dumpall -c -U keycloak > keycloak/dump_keycloak.sql
```
см: https://stackoverflow.com/questions/24718706/backup-restore-a-dockerized-postgresql-database