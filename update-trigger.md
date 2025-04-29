# Trigger Modification BDD


## Fonction qui met a jour updated_at : 
```sql
CREATE OR REPLACE FUNCTION trigger_set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = now();
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```


## Création Trigger pour toute les tables : 
```sql
-- === TABLE: Member_ ===
CREATE TRIGGER trg_member_updated
BEFORE UPDATE ON Member_
FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- === TABLE: Director ===
CREATE TRIGGER trg_director_updated
BEFORE UPDATE ON Director
FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- === TABLE: Actor ===
CREATE TRIGGER trg_actor_updated
BEFORE UPDATE ON Actor
FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- === TABLE: Actor_Role ===
CREATE TRIGGER trg_actor_role_updated
BEFORE UPDATE ON Actor_Role
FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- === TABLE: Archive ===
CREATE TRIGGER trg_archive_updated
BEFORE UPDATE ON Archive
FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- === TABLE: Movie ===
CREATE TRIGGER trg_movie_updated
BEFORE UPDATE ON Movie
FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- === TABLE: FAVORITE_MOVIE ===
CREATE TRIGGER trg_favorite_movie_updated
BEFORE UPDATE ON FAVORITE_MOVIE
FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- === TABLE: FAVORITE_ROLE ===
CREATE TRIGGER trg_favorite_role_updated
BEFORE UPDATE ON FAVORITE_ROLE
FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- === TABLE: PLAY_AS ===
CREATE TRIGGER trg_play_as_updated
BEFORE UPDATE ON PLAY_AS
FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- === TABLE: PLAY_IN ===
CREATE TRIGGER trg_play_in_updated
BEFORE UPDATE ON PLAY_IN
FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();
```