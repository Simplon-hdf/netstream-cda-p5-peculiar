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

## ✅ 2. Vérifiez votre IP locale

```zsh
ifconfig | grep inet
```

## ✅ 3. Modifier le fichier `pg_hba.conf`

Toujours dans le même dossier :

```zsh
nano /opt/homebrew/var/postgresql@<version>/pg_hba.conf
```

Ajoute une ligne à la fin pour autoriser les connexions d’une IP (exemple ici avec un réseau local) :

```zsh
host    all             all             192.168.1.0/24          md5
```

## ✅ 4. Redémarrer PostgreSQL

Sur macOS, via Homebrew :

```zsh
brew services restart postgresql@<version>
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
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO user1, user2;
```

## ✅ 6. Tester la connexion distante

Depuis une autre machine :

```zsh
psql -h <ip_du_mac> -U <utilisateur> -d <nom_bdd>
```

# Se connecter à une base de données PostgreSQL (Linux)

## ✅ 1. Modifier le fichier `postgresql.conf`

Sous Linux, le fichier est souvent ici :

```zsh
sudo nano /etc/postgresql/<version>/main/postgresql.conf
```

Sinon, pour le trouver :

```zsh
sudo find / -name postgresql.conf
```

Dans ce fichier, repérez :

```zsh
#listen_addresses = 'localhost'
```

Décommentez et remplacez 'localhost' par :

- "\*" pour accepter toutes les IP,
- ou une IP spécifique, ex : 192.168.1.50.

## ✅ 2. Vérifiez votre IP locale

```zsh
ip a | grep inet
```

## ✅ 3. Modifier le fichier pg_hba.conf

```zsh
sudo nano /etc/postgresql/<version>/main/pg_hba.conf
```

Ajoutez en bas du fichier :

```zsh
host    all             all             192.168.1.0/24          md5
```

## ✅ 4. Redémarrer PostgreSQL

```zsh
sudo systemctl restart postgresql
```

## ✅ 5. Ouvrir le port 5432 via UFW

```zsh
sudo ufw allow 5432
```

## ✅ 6. Créer un utilisateur PostgreSQL et lui accorder des privilèges

➕ Lancer psql en tant que superutilisateur :

```zsh
sudo -u postgres psql
```

Dans le prompt :

```zsh
CREATE USER nom_utilisateur WITH PASSWORD 'motdepasse';
```

### 🔐 Accorder des privilèges sur une base

Exemple :

```zsh
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO user1, user2;
```

## ✅ 7. Tester la connexion distante

Depuis une autre machine :

```zsh
psql -h <ip_du_serveur> -U <utilisateur> -d <nom_bdd>
```
