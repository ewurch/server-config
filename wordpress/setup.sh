#!/bin/bash

# Find the MySQL container dynamically
MYSQL_CONTAINER=$(docker container ls | grep database_mysql | awk '{print $1}')

if [ -z "$MYSQL_CONTAINER" ]
then
    echo "MySQL container not found!"
    exit 1
fi

# Execute MySQL command in the found container
docker exec $MYSQL_CONTAINER mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "
CREATE DATABASE IF NOT EXISTS $WP_DB;
CREATE USER '$WP_USER'@'%' IDENTIFIED BY '$WP_PASS';
GRANT ALL PRIVILEGES ON $WP_DB.* TO '$WP_USER'@'%';
FLUSH PRIVILEGES;
"

# Check if MySQL commands were successful
if [ $? -eq 0 ]; then
    echo "MySQL user and database created successfully."
else
    echo "Failed to create MySQL user and database."
fi