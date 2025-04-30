# 📦 Politique de Rétention des Sauvegardes PostgreSQL

- [1. 📅 Fréquence des Sauvegardes](#1-📅-fréquence-des-sauvegardes)
- [2. 📁 Durée de Conservation](#2-📁-durée-de-conservation)
    - [Stratégie de conservation](#stratégie-de-conservation)
    - [Politique de sauvegarde 3-2-1](#politique-de-sauvegarde-3-2-1)
    - [Suppression automatique des sauvegardes](#suppression-automatique-des-sauvegardes-quotidiennes-au-delà-de-7-jours)
- [3. ♻️ Procédure de Restauration](#3-♻️-procédure-de-restauration)
- [4. 🔐 Menaces Ciblées par cette Politique](#4-🔐-menaces-ciblées-par-cette-politique)
- [5. ✅ Résumé](#5-✅-résumé)


## 1. 📅 Fréquence des Sauvegardes

**Les sauvegardes de la base de données sont effectuées à une fréquence quotidienne.**
Elles sont planifiées chaque jour à 02h00 du matin.

- **Fréquence** : Quotidienne
- **Heure** : 02h00
- **Type** : Sauvegarde complète
- **Outil** : `pg_dump`
- **Format** : Format personnalisé (`-F c`) pour permettre une restauration flexible, ce format réduit la taille.

### Exemple de tâche cron

```zsh
crontab -e
```

puis

```bash
0 2 * * * /bin/bash -c '/usr/bin/pg_dump -U <user> -d <base_de_données> -F c -f /home/<user>/Desktop/<base_de_données>_$(date +\%F).backup'
```

## 2. 📁 Durée de Conservation

Les sauvegardes sont conservées selon une politique de rétention multi-niveaux, inspirée des recommandations de **l’ANSSI**.

### Stratégie de conservation :

- 📅 **Sauvegarde quotidienne** : conservée pendant **7 jours**
- 🗂️ **Sauvegarde hebdomadaire** : **1 sauvegarde par semaine est archivée** avant la purge des sauvegardes journalières
- 📦 **Sauvegarde mensuelle** : **1 sauvegarde parmi les hebdomadaires est conservée chaque mois**

> 🎯 **Objectifs :**
>
> - Ne jamais se retrouver sans sauvegarde si les fichiers quotidiens sont supprimés
> - Disposer d’un **historique d’un mois minimum** avec une granularité **hebdomadaire**

### Politique de sauvegarde 3-2-1

Il est **conseillé** de mettre en place la stratégie de sauvegarde **3-2-1**, recommandée par l’ANSSI :

| **Principe**              | **Description**                                                                                                            |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **3 copies**              | Conserver **au moins trois copies** différentes des données (1 originale + 2 sauvegardes)                                  |
| **2 supports différents** | Stocker les sauvegardes sur **au moins deux types de supports** (ex : disque local + cloud, ou NAS + clé USB)              |
| **1 copie hors site**     | Stocker **une copie hors site** (cloud, externalisation, autre bâtiment) pour éviter les pertes totales en cas de sinistre |

### Suppression automatique des sauvegardes quotidiennes (au-delà de 7 jours)

- **Durée de rétention** : 7 jours
- **Suppression automatique** : via un script `cron`
- **Répertoire de sauvegarde** : `/home/<user>/Desktop/`

```bash
0 3 * * * find /home/<user>/Desktop/ -name "*.backup" -type f -mtime +7 -delete
```

**Cela signifie que la commande sera exécutée tous les jours à 3h00 du matin.**

1. `find /home/<user>/Desktop/` → Parcourir ce dossier (et ses sous-dossiers, par défaut)

2. `-name "*.backup"` → Trouver les fichiers dont le nom se termine par .backup

3. `-type f` → S'assurer qu’il s’agit bien de fichiers (et non de dossiers, liens, etc.)

4. `-mtime +7` → Ne garder que ceux modifiés il y a plus de 7 jours

5. `-delete` → Et les supprimer

## 3. ♻️ Procédure de Restauration

En cas d'incident, voici comment restaurer une base depuis une sauvegarde.

**Étapes :**

**1. Identifier la sauvegarde à utiliser (ex: movie_test_2025-04-25.backup)**

**2. Créer une base de données cible :**

```bash
createdb -U <user> <nom_de_la_nouvelle_base>
```

**3. Restaurer la base :**

```bash
pg_restore -U <user> -d <nom_de_la_nouvelle_base> /home/<user>/Desktop/<nom_du_fichier_backup>.backup
```

## 4. 🔐 Menaces Ciblées par cette Politique

Cette politique protège contre plusieurs menaces potentielles :

| Menace                           | Solution Apportée                                                |
| -------------------------------- | ---------------------------------------------------------------- |
| **Panne du système / crash**     | Restauration rapide avec la sauvegarde quotidienne               |
| **Erreur humaine (suppression)** | Récupération des données supprimées                              |
| **Corruption de la base**        | Restauration d'une version propre et antérieure                  |
| **Défaillance matérielle**       | Fichier de sauvegarde stocké séparément de la base en production |

## 5. ✅ Résumé

- ⏰ Sauvegarde quotidienne à 02h00
- ♻️ Conservation pendant 7 jours
- 🧩 Procédure de restauration documentée
- 🔐 Protection contre pannes, erreurs et attaques

Cette politique est essentielle pour garantir la continuité de service et la sécurité des données. Elle peut évoluer selon les besoins métiers et réglementaires.
