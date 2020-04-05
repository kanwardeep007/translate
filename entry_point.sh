#!/bin/sh
set -e

# Uncomment below line to reset the DB

bundle exec rspec

exec "$@"