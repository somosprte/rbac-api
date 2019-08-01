# Development environment

## For first start

In terminal run:

```(script)
sh ./start.sh
```

---

## Basic comands

---

copy migrations from engine

```(script)
docker-compose run web rails engine:install:migrations

docker-compose -f rds.yml run web rails engine:install:migrations

```

---

create migrate

```(script)
docker-compose run web rails db:migrate

docker-compose -f rds.yml run web rails db:migrate
```

---
update documentation

```(script)
docker-compose run web rake rswag:specs:swaggerize

docker-compose -f rds.yml run web rake rswag:specs:swaggerize
```

---
