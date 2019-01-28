#!/bin/bash

services_number=$(docker-compose config --services | wc -l | tr -d '[:space:]')
services_up_number=$(docker-compose ps | grep Up | wc -l | tr -d '[:space:]')

# start services if not already up
if [[ $services_up_number < $services_number ]]; then
  docker-compose up -d

  if [[ $? > 0 ]]; then
    docker-compose down
    exit 1
  fi
fi

# test if ruby is installed
which ruby 2>&1 > /dev/null
if [[ $? > 0 ]]; then
  echo "ruby is missing..."
  exit 1
fi

# install bundler unless available
which bundle 2>&1 > /dev/null
if [[ $? > 0 ]]; then
  gem install bundler

  if [[ $? > 0 ]]; then
    exit 1
  fi
fi

# install dependencies if not satisfied
bundle check 2>&1 > /dev/null
if [[ $? > 0 ]]; then
  bundle install

  if [[ $? > 0 ]]; then
    exit 1
  fi
fi

# create database if not exist
bundle exec rails db:check 2> /dev/null
if [[ $? > 0 ]]; then
  bundle exec rails db:create
fi
