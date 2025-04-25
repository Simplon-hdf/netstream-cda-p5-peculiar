## Procédure stockée pour lister les films d’un réalisateur donné en paramètre
```sql
CREATE OR REPLACE FUNCTION get_movies_by_director(p_lastname TEXT)
RETURNS TABLE (
    movie_title VARCHAR(138),
    movie_release_date DATE
)
AS $$
BEGIN 
    RETURN QUERY
    SELECT m.movie_title, m.movie_release_date
    FROM Movie m 
    JOIN Director d ON m.director_id = d.director_id
    WHERE d.director_lastname ILIKE p_lastname;
END;
$$ LANGUAGE plpgsql;
```
## Procédures stockées pour gérer les opérations CRUD d’un acteur associé à un film
- Procédure pour lister les films d’un acteur donné
```sql
CREATE OR REPLACE FUNCTION get_actor_by_movie(p_lastname TEXT)
RETURNS TABLE (
    actor_firstname VARCHAR(50),
    actor_lastname VARCHAR(50),
    actor_gender VARCHAR(5),
    role_name VARCHAR(255),
    movie_title VARCHAR(138)
)
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    a.actor_firstname,
    a.actor_lastname,
    a.actor_gender,
    ar.role_name,
    m.movie_title
  FROM Actor a
  JOIN PLAY_AS pa ON pa.actor_id = a.actor_id
  JOIN Actor_Role ar ON ar.role_id = pa.role_id
  JOIN PLAY_IN pi ON pi.role_id = ar.role_id
  JOIN Movie m ON m.movie_id = pi.movie_id
  WHERE UPPER(a.actor_lastname) = UPPER(p_lastname);
END;
$$ LANGUAGE plpgsql;
```

- Procédure pour ajouter un acteur à un film
```sql
CREATE OR REPLACE PROCEDURE add_actor_to_movie(
  p_actor_id UUID,
  p_role_id UUID,
  p_movie_id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
  -- Lier acteur au role
  INSERT INTO PLAY_AS (actor_id, role_id)
  VALUES (p_actor_id, p_role_id);

  -- Lier role au film
  INSERT INTO PLAY_IN (movie_id, role_id)
  VALUES (p_movie_id, p_role_id);
END;
$$;
```

- Procédure pour modifier le rôle d’un acteur dans un film
```sql
CREATE OR REPLACE PROCEDURE update_actor_to_movie(
  p_actor UUID,
  p_movie UUID,
  p_new_role UUID
)
LANGUAGE plpgsql
AS $$
DECLARE
  old_role UUID;
BEGIN
  -- Récupérer l'ancien role de l’acteur dans ce film
  SELECT pi.role_id INTO old_role
  FROM PLAY_IN pi
  JOIN PLAY_AS pa ON pa.role_id = pi.role_id
  WHERE pa.actor_id = p_actor AND pi.movie_id = p_movie
  LIMIT 1;

    IF old_role IS NOT NULL THEN
    DELETE FROM PLAY_AS WHERE actor_id = p_actor AND role_id = old_role;
    DELETE FROM PLAY_IN WHERE movie_id = p_movie AND role_id = old_role;
  END IF;

  -- Ajouter la nouvelle relation
  INSERT INTO PLAY_AS (actor_id, role_id) VALUES (p_actor, p_new_role);
  INSERT INTO PLAY_IN (movie_id, role_id) VALUES (p_movie, p_new_role);
END;
$$;
```

- Procédure pour supprimer un acteur d’un film
```sql
    CREATE OR REPLACE PROCEDURE delete_actor_from_movie(
    p_actor_id UUID,
    p_movie_id UUID
    )
    LANGUAGE plpgsql
    AS $$
    DECLARE
    role_id UUID;
    BEGIN
    -- Trouver le role dans 
    SELECT pi.role_id INTO role_id
    FROM PLAY_AS pa
    JOIN PLAY_IN pi ON pa.role_id = pi.role_id
    WHERE pa.actor_id = p_actor_id AND pi.movie_id = p_movie_id
    LIMIT 1;

    -- Supprimer les liens entre les tables
    DELETE FROM PLAY_AS WHERE actor_id = p_actor_id AND role_id = role_id;
    DELETE FROM PLAY_IN WHERE movie_id = p_movie_id AND role_id = role_id;

    -- Supression du role s'il n'y a plus d'acteur & film lié a celui ci
    DELETE FROM Actor_Role
    WHERE role_id = role_id
        AND role_id NOT IN (SELECT role_id FROM PLAY_AS)
        AND role_id NOT IN (SELECT role_id FROM PLAY_IN);
    END;
$$;
```