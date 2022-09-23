#!/bin/sh
# Checks status of all services, etc.

LOGFILE=/paper-db/logs/init.log

# Setup postgresql database
if ! command -v psql > /dev/null; then
    echo "Command: psql not installed"
    exit 1
fi
psql -h postgres_container -p 5432 -U postgres -f /paper-db/schema/init.sql
pg_status=$(($?))
if [ $pg_status -eq 0 ]; then
    echo "Database created"
else
    echo "Database creation failed..."
    exit $pg_status
fi

# PostGreSQL
pg_isready -h postgres_container -p 5432 -U postgres -d paperdb
pg_status=$(($?))
if [ $pg_status -eq 0 ]; then
    echo "PostGreSQL: Able to connect"
else
    echo "PostGreSQL: Unable to connect"
    exit $pg_status
fi

# Keep running if tasks done...
sleep infinity