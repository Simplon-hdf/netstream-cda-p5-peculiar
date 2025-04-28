# Gestion des modifications des membres avec un trigger

Ce document décrit la création d'une fonction et d'un trigger en PostgreSQL pour archiver les modifications apportées aux informations des membres dans une table `Member_`. Chaque modification détectée est enregistrée dans une table `Archive` pour conserver un historique des changements.

## Création de la fonction

La fonction `archive_member_changes` est une fonction PL/pgSQL qui est déclenchée après une mise à jour sur la table `Member_`. Elle compare les anciennes valeurs (`OLD`) et les nouvelles valeurs (`NEW`) des colonnes de la table pour détecter les changements. Si une différence est trouvée, une entrée est ajoutée dans la table `Archive` avec les informations suivantes :

- **Date de modification** (`archive_modification_date`) : La date et l'heure de la modification.
- **Ancienne valeur** (`archive_old_value`) : La valeur avant la modification.
- **Nouvelle valeur** (`archive_new_value`) : La valeur après la modification.
- **Nom du champ modifié** (`archive_field_name`) : Le nom de la colonne modifiée.
- **Identifiant du membre** (`member_id`) : L'identifiant unique du membre concerné.

### Code de la fonction

```sql
CREATE OR REPLACE FUNCTION archive_member_changes()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN 
    -- Changement d'email
    IF (OLD.member_email IS DISTINCT FROM NEW.member_email) THEN
        INSERT INTO Archive (
            archive_modification_date,
            archive_old_value,
            archive_new_value,
            archive_field_name,
            member_id
        ) VALUES (
            now(),
            OLD.member_email,
            NEW.member_email,
            'member_email',
            NEW.member_id
        );
    END IF;

    -- Changement de password
    IF (OLD.member_password IS DISTINCT FROM NEW.member_password) THEN
        INSERT INTO Archive (
            archive_modification_date,
            archive_old_value,
            archive_new_value,
            archive_field_name,
            member_id
        ) VALUES (
            now(),
            OLD.member_password,
            NEW.member_password,
            'member_password',
            NEW.member_id
        );
    END IF;

    -- Changement de prénom
    IF (OLD.member_firstname IS DISTINCT FROM NEW.member_firstname) THEN
        INSERT INTO Archive (
            archive_modification_date,
            archive_old_value,
            archive_new_value,
            archive_field_name,
            member_id
        ) VALUES (
            now(),
            OLD.member_firstname,
            NEW.member_firstname,
            'member_firstname',
            NEW.member_id
        );
    END IF;

    -- Changement de nom de famille
    IF (OLD.member_lastname IS DISTINCT FROM NEW.member_lastname) THEN
        INSERT INTO Archive (
            archive_modification_date,
            archive_old_value,
            archive_new_value,
            archive_field_name,
            member_id
        ) VALUES (
            now(),
            OLD.member_lastname,
            NEW.member_lastname,
            'member_lastname',
            NEW.member_id
        );
    END IF;

    -- Changement de genre
    IF (OLD.member_gender IS DISTINCT FROM NEW.member_gender) THEN
        INSERT INTO Archive (
            archive_modification_date,
            archive_old_value,
            archive_new_value,
            archive_field_name,
            member_id
        ) VALUES (
            now(),
            OLD.member_gender,
            NEW.member_gender,
            'member_gender',
            NEW.member_id
        );
    END IF;

    -- Changement de date de naissance
    IF (OLD.member_birthdate IS DISTINCT FROM NEW.member_birthdate) THEN
        INSERT INTO Archive (
            archive_modification_date,
            archive_old_value,
            archive_new_value,
            archive_field_name,
            member_id
        ) VALUES (
            now(),
            OLD.member_birthdate::text,
            NEW.member_birthdate::text,
            'member_birthdate',
            NEW.member_id
        );
    END IF;

    RETURN NEW;
END;
$$;
```

## Définition de la fonction en tant que Trigger

```sql
CREATE TRIGGER trigger_archive_member_changes
AFTER UPDATE ON Member_
FOR EACH ROW
EXECUTE FUNCTION archive_member_changes();
```