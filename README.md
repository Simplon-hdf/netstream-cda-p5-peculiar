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
WHERE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM actor_birthdate)  > 30
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

WHERE actor_type = 'principal_role';
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
INSERT INTO Movie(movie_title, movie_duration, movie_default_language, movie_release_date, director_id)
VALUES ('Mowgli: Legend of the Jungle', '1h 44m', 'English', '2018-12-07', 'cc6438e4-e083-4f80-b5a9-48044c2defbc');
```

## Ajouter un acteur/actrice
```sql
INSERT INTO Director(director_firstname, director_lastname, director_birthdate, director_nationality, director_gender)
VALUES ('Hassan', 'Benjelloun', '1957-12-10', 'Moroccan', 'Male');

```

## Modifier un film
```sql
UPDATE Movie
SET movie_default_language = 'English'
WHERE movie_title = 'Titanic';
```

## Supprimer un acteur/actrice
```sql
DELETE FROM Actor
WHERE actor_firstname = 'Hassan' AND actor_lastname = 'Benjelloun';
```

## Afficher les 3 derniers acteurs/actrices ajouté(e)s
```sql
SELECT actor_firstname, actor_lastname, actor_created_at
FROM Actor
ORDER BY actor_created_at DESC
LIMIT 3;

```