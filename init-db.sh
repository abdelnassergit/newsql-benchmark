#!/bin/bash
#chmod +x init-db.sh a faire si ca ne marche pas (le ./init-db.sh)

# Charger les variables d'environnement
source .env

# Initialiser MySQL
docker exec -it mysql mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
"

# Initialiser TiDB depuis le conteneur MySQL
docker exec -it mysql mysql -h tidb -P 4000 -u root -e "
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON sbtest.* TO 'sbtest'@'%';
FLUSH PRIVILEGES;"