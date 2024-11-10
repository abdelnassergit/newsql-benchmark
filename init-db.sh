#!/bin/bash

# Initialiser MySQL
docker exec -it mysql mysql -uroot -proot -e "
CREATE DATABASE IF NOT EXISTS sbtest;
CREATE USER IF NOT EXISTS 'sbtest'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON sbtest.* TO 'sbtest'@'%';
FLUSH PRIVILEGES;
"

# Initialiser TiDB
docker exec -it tidb mysql -uroot -proot -e "
CREATE DATABASE IF NOT EXISTS sbtest;
CREATE USER IF NOT EXISTS 'sbtest'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON sbtest.* TO 'sbtest'@'%';
FLUSH PRIVILEGES;
"