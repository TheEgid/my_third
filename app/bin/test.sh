#!/bin/sh
set -e

# Wait for services to be started
dockerize -wait http://hub:4444 \
          -timeout 20s

exec "$@"

#          -wait http://chrome-debug:5555 \