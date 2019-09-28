#!/bin/bash

bundle check || bundle install

bundle exec rake assets:precompile

bundle exec rails s -b 0.0.0.0 -p 3000
