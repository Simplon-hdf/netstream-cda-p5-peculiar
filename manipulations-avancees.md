## Procédure stockée pour lister les films d’un réalisateur donné en paramètre
```sql
```
## Procédures stockées pour gérer les opérations CRUD d’un acteur associé à un film
- Procédure pour lister les films d’un réalisateur donné
```sql

```

- Procédure pour ajouter un acteur à un film
```sql
CREATE PROCEDURE add_actor_to_movie(
    p_actor UUID,
    p_movie UUID,
    p_role UUID
)

BEGIN
    INSERT INTO PLAY_AS (actor_id, movie_id, role_id)
    VALUES (p_actor, p_movie, p_role);
END;
```

- Procédure pour  modifier le rôle d’un acteur dans un film
```sql
```

- Procédure pour supprimer un acteur d’un film
```sql
```