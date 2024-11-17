# newsql-benchmark

Ce projet a pour objectif de comparer les performances entre TiDB et MySQL en utilisant des benchmarks.

## Prérequis

- Docker et Docker Compose installés
- Go-TPC installé (https://github.com/pingcap/go-tpc)

## Installation

1. Clonez le dépôt :
```
git clone https://github.com/abdelnassergit/newsql-benchmark.git
```

2. Accédez au répertoire du projet :
```
cd newsql-benchmark
```

## Lancer le projet

Pour démarrer les conteneurs Docker, exécutez la commande suivante :
```bash
docker compose up -d
```

## Préparation des bases de données
### TIDB prepare
```bash
go-tpc tpcc --warehouses 1 prepare -T 1 -D test -H 127.0.0.1 -P 4000
```
### MYSQL prepare
```bash
go-tpc tpcc --warehouses 1 prepare -T 1 -D test -H 127.0.0.1 -P 3306 -U user -p password
```
## Exécution des benchmarks
### Run benchmark TIDB
```bash
go-tpc tpcc --warehouses 1 run -T 1 -D test -H 127.0.0.1 -P 4000
```
### Run benchmark MYSQL
```bash
go-tpc tpcc --warehouses 1 run -T 1 -D test -H 127.0.0.1 -P 3306 -U user -p password
```
## Explication des paramètres

- `--warehouses`: Ce paramètre spécifie le nombre d'entrepôts à utiliser pour le benchmark. Un entrepôt représente une unité de charge de travail.
- `-T`: Ce paramètre spécifie le nombre de threads à utiliser pour le benchmark. Plus de threads peuvent augmenter la charge sur la base de données.

## Résultats
Après avoir exécuté les benchmarks, vous pouvez analyser les résultats pour comparer les performances entre TiDB et MySQL.

## Nettoyage
Pour arrêter et supprimer les conteneurs Docker, exécutez la commande suivante :
```bash
docker compose down -v
```
