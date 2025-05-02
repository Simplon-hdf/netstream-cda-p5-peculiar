#  Dictionnaire de données – Plateforme NetStream

## Utilisateurs (Users)

> Tous les identifiants (IDs) sont des UUID v4 (format AN(36))

| Nom court           | Nom complet                              | Type  | Longueur | Contrainte | Exemple                                     |
|---------------------|-------------------------------------------|-------|----------|------------|----------------------------------------------|
| user_id             | ID de l'utilisateur (UUID)                | AN    | 36       | required   | d1f5e52c-bb4e-4b2c-8c4e-49c50d3e1d8a          |
| user_email          | Email de l'utilisateur                    | TEXT  | 254      | required   | user@example.com                             |
| user_password       | Mot de passe haché (Argon2id)             | TEXT  | 72       | required   | $argon2id$v=19$m=65536,t=3,p=4$abc123...      |
| user_firstname      | Prénom de l'utilisateur                   | A     | 100      | required   | Jean                                         |
| user_lastname       | Nom de famille de l'utilisateur           | A     | 100      | required   | Dupont                                       |
| user_gender         | Genre de l'utilisateur                    | A     | 5        | required   | Homme                                        |
| user_birth_date     | Date de naissance de l'utilisateur        | DATE  | 10       | required   | 1990-05-20                                   |
| user_creation_date  | Date de création du compte utilisateur    | DATE  | 10       | required   | 2025-04-22                                   |

---

## Films

| Nom court               | Nom complet                         | Type  | Longueur | Contrainte | Exemple                                     |
|-------------------------|--------------------------------------|-------|----------|------------|----------------------------------------------|
| movie_id                | ID du film (UUID)                   | AN    | 36       | obligatoire | 398db53f-59cd-4054-bc4f-09b7a81e3e0f         |
| movie_title             | Titre du film                        | TEXT  | 138      | obligatoire | Inception                                   |
| movie_duration          | Durée du film (en minutes)           | N     | 4        | obligatoire | 148                                         |
| movie_default_language  | Langue par défaut du film            | A     | 58       | facultatif  | Anglais                                     |
| movie_release_date      | Date de sortie du film               | DATE  | 10       | obligatoire | 2010-07-16                                  |

---

## Réalisateurs

| Nom court             | Nom complet                         | Type  | Longueur | Contrainte | Exemple                                     |
|-----------------------|--------------------------------------|-------|----------|------------|----------------------------------------------|
| director_id           | ID du réalisateur (UUID)             | AN    | 36       | obligatoire | b2fa713e-6d32-4b4f-9de7-eeb932a90c45         |
| director_firstname    | Prénom du réalisateur                | A     | 50       | obligatoire | Christopher                                 |
| director_lastname     | Nom de famille du réalisateur        | A     | 50       | obligatoire | Nolan                                       |
| director_birth_date   | Date de naissance du réalisateur     | DATE  | 10       | obligatoire | 1970-07-30                                  |
| director_nationality  | Nationalité du réalisateur           | A     | 64       | obligatoire | Britannique                                 |
| director_gender       | Genre du réalisateur                 | A     | 5        | obligatoire | Homme                                       |

---

## 🎭 Acteurs

| Nom court            | Nom complet                           | Type  | Longueur | Contrainte | Exemple                                     |
|----------------------|----------------------------------------|-------|----------|------------|----------------------------------------------|
| actor_id             | ID de l'acteur (UUID)                  | AN    | 36       | obligatoire | 9c8a95a4-d2e6-4c9f-b0c7-56c9a1b25dbe         |
| actor_firstname      | Prénom de l'acteur                     | A     | 50       | obligatoire | Emma                                        |
| actor_lastname       | Nom de famille de l'acteur             | A     | 50       | obligatoire | Watson                                      |
| actor_role           | Rôle de l'acteur dans le film          | TEXT  | 128      | obligatoire | Hermione Granger                            |
| actor_gender         | Genre de l'acteur                      | A     | 5        | obligatoire | Femme                                       |
| actor_nationality    | Nationalité de l'acteur                | A     | 64       | obligatoire | Anglaise                                    |
| actor_birth_date     | Date de naissance de l'acteur          | DATE  | 10       | obligatoire | 1990-04-15                                  |