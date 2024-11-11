#!/bin/bash
# Wait for TiDB to be ready
sleep 10

# Execute MySQL commands using the MySQL container to connect to TiDB
docker exec -i mysql mysql -h tidb -P 4000 -u root --ssl-mode=DISABLED -e "
CREATE DATABASE IF NOT EXISTS sbtest;
CREATE USER IF NOT EXISTS 'sbtest'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON sbtest.* TO 'sbtest'@'%';
ALTER USER 'sbtest'@'%' REQUIRE NONE;
FLUSH PRIVILEGES;"

# Verify the connection
echo "Verifying TiDB connection..."
docker exec -i mysql mysql -h tidb -P 4000 -u sbtest -ppassword --ssl-mode=DISABLED -e "SELECT 'Connection successful!' as Status;"

# Try to create a test table to verify permissions
echo "Testing database permissions..."
docker exec -i mysql mysql -h tidb -P 4000 -u sbtest -ppassword --ssl-mode=DISABLED sbtest -e "
CREATE TABLE IF NOT EXISTS test (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);"