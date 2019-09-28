#!/bin/bash

bundle check || bundle install

bundle exec rake assets:precompile

bundle exec rails s -p 3000
