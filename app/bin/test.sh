#!/bin/sh
set -e

# Wait for services to be started
dockerize -wait http://hub:4444 \
          -timeout 10s

exec "$@"

#          -wait http://chrome-debug:5555 \