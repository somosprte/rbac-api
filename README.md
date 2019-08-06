# Development environment

---

## Creating files

In terminal run

```(script)
cp .env.example .env && cp config/default-database.yml config/database.yml
```

---

## Starting for first time

For build container run

```(script)
docker-compose -f dev.yml build
```

Creating development database example and seed run

```(script)
docker-compose -f dev.yml run web db:create db:migrate db:seed
```

---

## Starting and stoping server container

```(script)
docker-compose -f dev.yml down && docker-compose -f dev.yml up
```

open the browser at localhost:8080/api-docs/index.html

---

## Useful commands

copy migrations from engine

```(script)
docker-compose -f dev.yml run web rails engine:install:migrations

```

---

update documentation

```(script)
docker-compose -f dev.yml run web rake rswag:specs:swaggerize
```
