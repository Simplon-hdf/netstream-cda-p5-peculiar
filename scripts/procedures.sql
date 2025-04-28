-- Liste des films par directeur (en paramétres)
DROP FUNCTION IF EXISTS get_movies_by_director(TEXT);
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

-- CRUD Acteurs 
CREATE OR REPLACE PROCEDURE add_actor_with_role_to_film(
  p_firstname VARCHAR,
  p_lastname VARCHAR,
  p_gender VARCHAR,
  p_nationality VARCHAR,
  p_birthdate DATE,
  p_created_at DATE,
  p_role_name VARCHAR,
  p_role_type role_type_enum,
  p_movie_title VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
  actor_id UUID;
  role_id UUID;
  movie_id UUID;
BEGIN
  -- Ajout de l'acteur 
  INSERT INTO Actor (
    actor_firstname, actor_lastname, actor_gender,
    actor_nationality, actor_birthdate, actor_created_at
  ) VALUES (
    p_firstname, p_lastname, p_gender,
    p_nationality, p_birthdate, p_created_at
  ) RETURNING actor_id INTO actor_id;

  -- Ajout du role de l'acteur 
  INSERT INTO Actor_Role (role_name, role_type)
  VALUES (p_role_name, p_role_type)
  RETURNING role_id INTO role_id;

  -- Lier acteur & role 
  INSERT INTO PLAY_AS (actor_id, role_id) VALUES (actor_id, role_id);

  -- SELECT du film
  SELECT movie_id INTO movie_id FROM Movie WHERE movie_title = p_movie_title;

  -- Lier un role a un film
  INSERT INTO PLAY_IN (movie_id, role_id) VALUES (movie_id, role_id);
END;
$$;


