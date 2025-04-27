# **Script de [génération de la base de données](./scripts/script.sql) pour la Plateforme NetStream**
## ## Préparation de l'environnement de base de données
```sql 
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TYPE role_type_enum AS ENUM ('Lead', 'Supporting', 'Cameo');

DROP TABLE IF EXISTS 
  Archive,
  FAVORITE_MOVIE,
  FAVORITE_ROLE,
  PLAY_AS,
  PLAY_IN,
  Movie,
  Actor,
  Director,
  Actor_Role,
  Member_;
  ```

## Création des Tables 
### Table Membre 
```sql 
CREATE TABLE Member_(
   member_id UUID DEFAULT gen_random_uuid(),
   member_email VARCHAR(254) NOT NULL,
   member_password VARCHAR(72) NOT NULL,
   member_firstname VARCHAR(100) NOT NULL,
   member_lastname VARCHAR(100) NOT NULL,
   member_gender VARCHAR(5) NOT NULL,
   member_birthdate DATE NOT NULL,
   member_creation_date DATE NOT NULL,
   PRIMARY KEY(member_id),
   UNIQUE(member_email)
);
```

### Table Réalisateur
```sql
CREATE TABLE Director(
   director_id UUID DEFAULT gen_random_uuid(),
   director_firstname VARCHAR(50) NOT NULL,
   director_lastname VARCHAR(50) NOT NULL,
   director_birthdate DATE NOT NULL,
   director_nationality VARCHAR(64) NOT NULL,
   director_gender VARCHAR(5) NOT NULL,
   PRIMARY KEY(director_id)
);
```

### Table Acteur
```sql
CREATE TABLE Actor(
   actor_id UUID DEFAULT gen_random_uuid(),
   actor_firstname VARCHAR(50) NOT NULL,
   actor_lastname VARCHAR(50) NOT NULL,
   actor_gender VARCHAR(5) NOT NULL,
   actor_nationality VARCHAR(64) NOT NULL,
   actor_birthdate DATE NOT NULL,
   actor_created_at DATE NOT NULL,
   PRIMARY KEY(actor_id)
);
```
### Table Role
```sql
CREATE TABLE Actor_Role(
   role_id UUID DEFAULT gen_random_uuid(),
   role_name VARCHAR(255) NOT NULL,
   role_type VARCHAR(50) NOT NULL,
   PRIMARY KEY(role_id)
);
```

### Table Archive 
```sql
CREATE TABLE Archive(
   archive_id UUID DEFAULT gen_random_uuid(),
   archive_modification_date DATE NOT NULL,
   archive_new_value VARCHAR(254) NOT NULL,
   archive_old_value VARCHAR(254) NOT NULL,
   archive_field_name VARCHAR(30) NOT NULL,
   member_id UUID NOT NULL,
   PRIMARY KEY(archive_id),
   FOREIGN KEY(member_id) REFERENCES Member_(member_id)
);
```

### Table Film
```sql
CREATE TABLE Movie(
   movie_id UUID DEFAULT gen_random_uuid(),
   movie_title VARCHAR(138) NOT NULL,
   movie_duration INTERVAL NOT NULL,
   movie_default_language VARCHAR(58),
   movie_release_date DATE NOT NULL,
   director_id UUID NOT NULL,
   PRIMARY KEY(movie_id),
   FOREIGN KEY(director_id) REFERENCES Director(director_id)
);
```

### Table des films ajoutés en favoris par un utilisateur
```sql
CREATE TABLE FAVORITE_MOVIE(
   member_id UUID,
   movie_id UUID,
   PRIMARY KEY(member_id, movie_id),
   FOREIGN KEY(member_id) REFERENCES Member_(member_id),
   FOREIGN KEY(movie_id) REFERENCES Movie(movie_id)
);
```

 ### Table qui associe un acteur à un rôle qu’il joue
 ```sql
CREATE TABLE PLAY_AS(
   actor_id UUID,
   role_id UUID,
   PRIMARY KEY(actor_id, role_id),
   FOREIGN KEY(actor_id) REFERENCES Actor(actor_id),
   FOREIGN KEY(role_id) REFERENCES Actor_Role(role_id)
);
```

### Table des roles ajoutés en favoris par un utilisateur
```sql
CREATE TABLE FAVORITE_ROLE(
   member_id UUID,
   role_id UUID,
   PRIMARY KEY(member_id, role_id),
   FOREIGN KEY(member_id) REFERENCES Member_(member_id),
   FOREIGN KEY(role_id) REFERENCES Actor_Role(role_id)
);
```
### Table d'association entre un film et les rôles qui y apparaissent
```sql
CREATE TABLE PLAY_IN(
   movie_id UUID,
   role_id UUID,
   PRIMARY KEY(movie_id, role_id),
   FOREIGN KEY(movie_id) REFERENCES Movie(movie_id),
   FOREIGN KEY(role_id) REFERENCES Actor_Role(role_id)
);
```