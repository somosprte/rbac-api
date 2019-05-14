FROM ruby:2.6.3
LABEL Flávio Junior and Pedro Renan
RUN apt-get update -qq && apt-get install -y  \
    build-essential libpq-dev \
    imagemagick gcc \
    nodejs
RUN mkdir /rbac-api
WORKDIR /rbac-api
COPY . .
RUN bundle install --jobs 20 --retry 5