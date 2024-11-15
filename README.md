# newsql-benchmark

## Lancer le projet

Pour démarrer les conteneurs Docker, exécutez la commande suivante :
```bash
docker-compose up -d
```

## Initialisation des bases de données

Pour initialiser les bases de données MySQL et TiDB, exécutez le script `init-db.sh` :
```bash
./init-db.sh
```

## Préparation des bases de données

Avant d'exécuter le benchmark, préparez les bases de données avec la commande suivante :
```bash
sysbench --config-file=config.cfg oltp_read_write prepare
```



## MYSQL prepare sysbench
```bash
docker exec -it sysbench sysbench --db-driver=mysql --mysql-host=mysql --mysql-user=sbtest --mysql-password=password --mysql-db=sbtest --tables=10 --table-size=1000000 oltp_read_write prepare
```

## TIDB prepare sysbench
```bash
docker exec -it sysbench sysbench --db-driver=mysql --mysql-host=tidb --mysql-user=sbtest --mysql-password=password --mysql-db=sbtest --tables=10 --table-size=1000000 oltp_read_write prepare prepare
```

## Run benchmark MYSQL
```bash
docker exec -it sysbench sysbench --db-driver=mysql --mysql-host=mysql --mysql-user=sbtest --mysql-password=password --mysql-db=sbtest --threads=4 --time=60 --report-interval=10 oltp_read_write run
```

## Run benchmark TIDB
```bash
docker exec -it sysbench sysbench --db-driver=mysql --mysql-host=tidb --mysql-user=sbtest --mysql-password=password --mysql-db=sbtest --threads=4 --time=60 --report-interval=10 oltp_read_write run
```




### here

sysbench ./sbscripts/oltp_read_write.lua \
  --mysql-host=172.19.0.4 \
  --mysql-port=3306 \
  --mysql-user=sbtest \
  --mysql-password=password \
  --mysql-db=sbtest \
  --tables=10 \
  --table-size=1000000 \
  --threads=10 \
  --time=60 \
  run


the right :

# CODE
sysbench \
  --mysql-host=127.0.0.1 \
  --mysql-port=3306 \
  --mysql-user=sbtest \
  --mysql-password=password \
  --mysql-db=sbtest \
  --tables=10 \
  --table-size=10000 \
  oltp_common prepare 

# CODE
sysbench \
  --mysql-host=127.0.0.1 \
  --mysql-port=4000 \
  --mysql-user=sbtest \
  --mysql-password=password \
  --mysql-db=sbtest \
  --tables=10 \
  --table-size=10000 \
  oltp_common prepare 