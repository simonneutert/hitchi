#!/bin/bash

bundle check || bundle install

bundle exec passenger start -p 3333 --max-pool-size=8 --min-instances=4
