#!/bin/bash

echo "version: '2'\n"\
"services:\n"\
"  db:\n"\
"    container_name: postgre_sql\n"\
"    image: postgres\n"\
"    restart: always\n"\
"    volumes:\n"\
"      - ./data/postgres:/var/lib/postgresql/data\n"\
"    ports:\n"\
"      - 6543:5432\n"\
"    env_file:\n"\
"      - '.env'\n"\
"\n"\
"  web:\n"\
"    build: .\n"\
"    command: bash -c \"rm -f tmp/pids/server.pid && bundle exec rails s -p 8080 -b '0.0.0.0'\"\n"\
"    volumes:\n"\
"      - .:/rbac-api\n"\
"    ports:\n"\
"      - \"8080:8080\"\n"\
"    depends_on:\n"\
"      - db\n"\
"    stdin_open: true\n"\
"    tty: true\n"\
"    env_file:\n"\
"      - '.env'\n"\
"networks:\n"\
"    default:\n"\
"        external:\n"\
"            name: rbacapi_default\n" > ./docker-compose.yml
echo '...file docker-compose created'

echo "# POSTGRES\n"\
"POSTGRES_USER=postgres\n"\
"POSTGRES_PASSWORD=password\n"\
"POSTGRES_DATABASE=rbac_api_development\n"\
"POSTGRES_DATABASE_TEST=rbac_api_test\n"\
"DATABASE_URL=postgres://db\n"\
"PG_SERVER=postgres\n"\
"# WEB\n"\
"RAILS_ENV=development\n"\
"#AUTH_JWT\n"\
"RBAC_JWT_SECRET=my_secret\n"\
"S3_AWS_ACCESS_KEY_ID=AKIA2SZCEJJ2HBQDTPQP\n"\
"S3_AWS_SECRET_ACCESS_KEY=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\n"\
"S3_BUCKET_NAME=api-rbac\n" > ./.env
echo '...file .env created'

echo "default: &default\n"\
"  adapter: postgresql\n"\
"  encoding: unicode\n"\
"  pool: <%= ENV.fetch(\"RAILS_MAX_THREADS\") { 5 } %>\n"\
"  port: 5432\n"\
"  username: <%= ENV['POSTGRES_USER'] %>\n"\
"  password: <%= ENV['POSTGRES_PASSWORD'] %>\n"\
"  url: <%= ENV['DATABASE_URL'] %>\n"\
"\n"\
"development:\n"\
"  <<: *default\n"\
"  database: <%= ENV['POSTGRES_DATABASE'] %>\n"\
"\n"\
"test:\n"\
"  <<: *default\n"\
"  database: <%= ENV['POSTGRES_DATABASE_TEST'] %>\n"\
"\n"\
"production:\n"\
"  <<: *default\n"\
"  database: <%= ENV['POSTGRES_DATABASE'] %>\n" > ./config/database.yml
echo '...file config/database.yml created'

docker-compose build
docker-compose run web bundle
docker-compose run web rails db:drop
docker-compose run web rails db:create
docker-compose run web rails db:migrate
docker-compose run web rails db:seed
docker-compose down
code .
firefox localhost:8080/api-docs/index.html
docker-compose up



