# netstream-cda-p5-peculiar

Bienvenue sur le dépôt du projet de base de données pour une plateforme de streaming. Ce projet a pour objectif de modéliser, concevoir et interroger une base de données relationnelle complète.

---

##  Sommaire

- [Règles de gestion](./regle-gestion.md)
- [Dictionnaire de données](./dictionnary.md)
- [MCD (Modèle Conceptuel de Données)](./mcd.md)
- [MLD (Modèle Logique de Données)](./mld.md)
- [MPD (Modèle Physique de Données)](./mpd.md)
- [Script SQL](./script_creation_bdd.sql)
- [Les requêtes SQL ](#-les-requêtes-sql)
- [Documentation d’installation et de configuration](./installation-configuration-bdd.md)
- [Choix du SGBDR](#-choix-du-sgbdr)

---


# Les requêtes SQL 

## Les titres et dates de sortie des films du plus récent au plus ancien
```sql
SELECT movie_title, movie_release_date 
FROM Movie 
ORDER BY DATE DESC;
```

## Les noms, prénoms et âges des acteurs/actrices de plus de 30 ans dans l'ordre alphabétique
```sql
SELECT actor_firstname, actor_lastname, EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM actor_birthdate) 
as  actor_age
FROM Actor
WHERE (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM actor_birthdate))  > 30
ORDER BY actor_firstname ;
```

## La liste des acteurs/actrices principaux pour un film donné
```sql
SELECT actor_firstname, actor_lastname, movie_title
FROM Actor

JOIN PLAY_AS ON Actor.actor_id = PLAY_AS.actor_id
JOIN Actor_role ON PLAY_AS.role_id = Actor_role.role_id
JOIN PLAY_IN ON Actor_role.role_id = PLAY_AS.role_id
JOIN Movie ON PLAY_IN.movie_id = Movie.movie_id

WHERE Actor_role.actor_type = 'principal_role';
WHERE Movie.movie_title ='Titanic';
```

## La liste des films pour un acteur/actrice donné
```sql
SELECT movie_title
FROM Movie

JOIN PLAY_IN ON Movie.movie_id = PLAY_IN.movie_id
JOIN Actor_role ON PLAY_IN.role_id = Actor_role.role_id
JOIN PLAY_AS ON Actor_role.role_id = PLAY_AS.role_id
JOIN Actor ON PLAY_AS.actor_id = Actor.actor_id

WHERE actor_firstname = 'Leonardo' and actor_lastname='DiCaprio';

```

## Ajouter un film
```sql
INSERT INTO Movie(movie_title, movie_duration, movie_default_langage, movie_release_date)
VALUES('Titanic', '3h 14m', 'English', '1997-12-19')
```

## Ajouter un acteur/actrice
```sql
INSERT INTO Actor(actor_firstname, actor_lastname, actor_gender, actor_nationality, actor_birthdate)
VALUES('Leonardo', 'DiCaprio', 'Male', 'American', '1974-11-11')
```

## Modifier un film
```sql
UPDATE
```

## Supprimer un acteur/actrice
```sql
```

## Afficher les 3 derniers acteurs/actrices ajouté(e)s
```sql
DELETE FROM Actor
WHERE actor_firstname = 'Leonardo' AND actor_lastname = 'DiCaprio';
```
