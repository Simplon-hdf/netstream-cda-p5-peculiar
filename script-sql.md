# Création des tables 
## Table  Membre
```sql 
CREATE TABLE Member(
    member_id UUID PRIMARY KEY,
    member_password VARCHAR(72) NOT NULL, 
    member_firstname VARCHAR(100) NOT NULL
    member_lastname VARCHAR(100) NOT NULL,
    member_gender VARCHAR(5) NOT NULL,
    member_birthdate DATE NOT NULL,
    member_creation_date DATE NOT NULL,
)
```

## Table Film 
```sql
```

## Table Réalisateur
```sql
```

## Table Acteur 
```sql
```

## Table Role
```sql
```

## Table Archive
```sql
```

## Table d'association entre un film et son ou ses réalisateurs
```sql
```

## Table des films ajoutés en favoris par un utilisateur
```sql
```

## Table des qui associe un acteur à un rôle qu’il joue
```sql
```

## Table d'association entre un film et les rôles qui y apparaissent
```sql
```
