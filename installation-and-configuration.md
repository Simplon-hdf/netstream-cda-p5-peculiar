# Documentation pour installation et configuration de la base de données

Cette documentation couvre l'installation et la configuration **de la base de données PostgreSQL**, ainsi que l'importation de la base de données à partir d'une sauvegarde ou d'un fichier spécifique.

---

## 🔧 Étape 1 : Création de la Base de Données

1. Se connecter à PostgreSQL : Connectez-vous à PostgreSQL avec l'utilisateur ayant les privilèges nécessaires :

```zsh
psql -U postgres
```

2. **Créer une nouvelle base de données** : Exécutez la commande suivante pour créer une nouvelle base de données. Remplacez nom_de_votre_base par le nom que vous souhaitez donner à la base de données :

```SQL
CREATE DATABASE nom_de_votre_base;
```

## 🔧 Étape 2 : Création d'un Utilisateur pour la Base de Données

1. **Créer un utilisateur PostgreSQL** : Créez un utilisateur avec un mot de passe sécurisé. Remplacez `votre_utilisateur` et `votre_mot_de_passe` par le nom d'utilisateur et le mot de passe que vous souhaitez définir :

```SQL
CREATE USER votre_utilisateur WITH PASSWORD 'votre_mot_de_passe';
```

2. **Accorder des privilèges à l'utilisateur** : Donnez à l'utilisateur créé tous les privilèges nécessaires sur la base de données que vous venez de créer. Remplacez `votre_utilisateur` et `nom_de_votre_base` par les valeurs appropriées :

```SQL
GRANT ALL PRIVILEGES ON DATABASE nom_de_votre_base TO votre_utilisateur;
```

## 🔧 Étape 3 : Connexion à la Base de Données avec l'Utilisateur Créé

Pour vous connecter à la base de données avec l'utilisateur que vous venez de créer, utilisez la commande suivante. Remplacez `votre_utilisateur` et `nom_de_votre_base` par les valeurs appropriées :

```zsh
psql -U votre_utilisateur -d nom_de_votre_base
```

## 🔧 Étape 4 : Importer les Données

> Importer un fichier `.sql`

Si vous disposez d'un fichier SQL contenant la structure et les données de la base de données, vous pouvez l'importer avec cette commande :

```zsh
psql -U votre_utilisateur -d nom_de_votre_base -f chemin/vers/votre_fichier.sql
```

> Importer un fichier `.dump`

Si vous avez une sauvegarde au format `.dump` réalisée avec la commande `pg_dump`, vous pouvez l'importer comme suit :

```zsh
pg_restore -U votre_utilisateur -d nom_de_votre_base chemin/vers/votre_fichier.dump
```

## 🔧 Étape 5 : Vérification de la Configuration

Une fois la base de données et l'utilisateur configurés, vous pouvez effectuer quelques vérifications :

1. **Vérifier les tables existantes** : Pour vous assurer que la base de données est correctement configurée et contient les bonnes tables, connectez-vous à la base de données et exécutez la commande suivante pour lister les tables :

```SQL
\dt
```

2. **Vérifier les permissions** : Pour vérifier que l'utilisateur a bien les privilèges nécessaires, vous pouvez exécuter la commande suivante dans PostgreSQL :

```SQL
\du
```

## 🚀 Étape 6 : Lancer PostgreSQL

Si vous devez démarrer PostgreSQL manuellement, utilisez la commande appropriée pour votre système

**Linux** :

```zsh
sudo service postgresql start
```

**macOS**

```zsh
brew services start postgresql
```
