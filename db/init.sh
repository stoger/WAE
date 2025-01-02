#!/usr/bin/bash

# Wait for the database to be ready (example for MySQL)
DB_HOST=${DB_HOST:-"mysqldb"}
DB_USER=${DB_USER:-"root"}
DB_PASSWORD=${DB_PASSWORD:-"tuv24"}
DB_NAME=${DB_NAME:-"tuv"}

echo "Waiting for MySQL to be ready..."
until mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -e "select user from mysql.user;" 2>/dev/null; do
    echo "MySQL is unavailable - sleeping"
    sleep 1
done

echo "MySQL is up - executing post-initialization script"
# Run your post-initialization SQL script - default stuff DO NOT EDIT
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" < /tmp/db/init.sql
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < /tmp/db/group99_article.sql

# Run group-specific SQL initialization
cat /tmp/db/custom/* | mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" #< /tmp/db/custom/group.sql

echo "All set up"