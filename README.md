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
WHERE actor_age > 30
ORDER BY actor_firstname ;
```

## La liste des acteurs/actrices principaux pour un film donné
```sql
SELECT actor_firstname, actor_lastname, movie_title
FROM Actor
JOIN Movie ON 
JOIN PLAY_IN ON 
JOIN Actor_role ON 
JOIN PLAY_AS ON 
JOIN Actor ON 
WHERE actor_type = 'principal_role';
```

## La liste des films pour un acteur/actrice donné
```sql
SELECT movie_title
FROM Movie
JOIN 'faire le meme parcours jusqu à acteur ?'

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
```