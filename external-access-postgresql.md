# Se connecter à une base de données PostgreSQL (macOS)

## ✅ 1. Modifier le fichier `postgresql.conf`

Sous macOS (installation via Homebrew par exemple), le fichier est généralement ici :

```zsh
nano /opt/homebrew/var/postgresql@<version>/postgresql.conf
```

Si vous ne connaissez pas l'emplacement :

```zsh
brew info postgresql@<version>
```

Dans ce fichier, cherchez la ligne suivante :

```zsh
#listen_addresses = 'localhost'
```

**Decommentez** et remplacez `'localhost'` par :

- `"*"` pour autoriser toutes les IP
- ou une IP spécifique, comme `192.168.1.50`

## ✅ 2. Modifier le fichier `pg_hba.conf`

Toujours dans le même dossier :

```zsh
nano /opt/homebrew/var/postgresql@<version>/pg_hba.conf
```

Ajoute une ligne à la fin pour autoriser les connexions d’une IP (exemple ici avec un réseau local) :

```zsh
host    all             all             192.168.1.0/24          md5
```

## ✅ 3. Redémarrer PostgreSQL

Sur macOS, via Homebrew :

```zsh
brew services restart postgresql@<version>
```

## ✅ 4. Vérifiez votre IP locale

```zsh
ifconfig | grep inet
```

## ✅ 5. Ouvrir le port (si vous avez un pare-feu)

Par défaut, macOS n’ouvre pas de port via **ufw** comme sur Linux, mais si tu as un pare-feu ou Little Snitch, autorise manuellement le port :

```zsh
Port 5432 (TCP) entrant
```

## ✅ 7. Créer un utilisateur PostgreSQL et lui accorder des privilèges

➕ Créer un utilisateur PostgreSQL

Lance le client PostgreSQL en tant que superutilisateur (par exemple postgres) :

```zsh
psql postgres
```

Puis dans le prompt psql :

```SQL
CREATE USER nom_utilisateur WITH PASSWORD 'motdepasse';
```

### 🔐 Accorder des privilèges sur une base

Exemple de privilèges à accorder en gardant le rôle d'administrateur :

```SQL
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user1 , user2;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO user1, user2;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO user1, user2;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO user1, user2;
-- ou en plus rapide--
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES TO user1, user2;
```

## ✅ 6. Tester la connexion distante

Depuis une autre machine :

```zsh
psql -h <ip_du_mac> -U <utilisateur> -d <nom_bdd>
```
