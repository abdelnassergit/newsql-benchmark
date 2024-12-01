# Fix pour go-tpc TPCH MySQL Compatibility

## Problème Initial

La fonctionnalité go-tpc a été conçu principalement pour TiDB (une base de données compatible MySQL avec des fonctionnalités supplémentaires), ce qui causait plusieurs problèmes :

* Tentative d'utilisation de variables système spécifiques à TiDB (tidb_*) sur une installation MySQL standard
* Ces variables n'existent pas dans MySQL standard
* Le processus de création de base de données et la configuration étaient spécifiques à TiDB

## Modifications Apportées

Les modifications ont été effectuées dans trois fichiers principaux :

1. `main.go`:
   * Modification de la logique de connexion pour détecter si on est sur TiDB ou MySQL standard
   * Ajout d'un processus simplifié de création de base de données pour MySQL

2. `tpch.go`:
   * Ajout de la détection du type de base de données
   * Désactivation des fonctionnalités TiDB si nécessaire
   * Implémentation des paramètres MySQL standards

3. `workload.go`:
   * Ajout de vérifications de compatibilité MySQL
   * Modification de la logique d'exécution des requêtes pour MySQL standard

## Installation

### Prérequis
* Go programming language
* Make

### Étapes d'Installation

1. Cloner le repository :
```bash
git clone https://github.com/pingcap/go-tpc.git
```
2. Dans le dossier go-tpc, remplacer le contenu des fichiers suivants avec les versions corrigées :
    - - `cmd/go-tpc/tpch.go`
    - - `cmd/go-tpc/main.go`
    - - `tpch/workload.go`
3. Compiler le projet :
```bash
make build
```

## Utilisation
Une fois compilé, vous pouvez exécuter le benchmark TPCH sur MySQL avec :
```bash
./bin/go-tpc tpch --sf=1 run -D test -P 3306 -U root -p rootpassword
```

## Modifications Clés
- Détection automatique du type de base de données (TiDB vs MySQL)
- Utilisation de paramètres MySQL standards quand nécessaire
- Processus de création de base de données simplifié pour MySQL
- Suppression des fonctionnalités TiDB lors de l'exécution sur MySQL standard
- Ajout du mode `sql_mode='STRICT_TRANS_TABLES'` pour la compatibilité MySQL