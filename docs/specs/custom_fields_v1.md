# Spec - Custom Fields v1

Version: 1.0.0
Objet: definir un mecanisme generique de champs personnalises rattaches a l'entite Employe.

## Portee v1
- Portee (scope): `employee` uniquement (v2: autres entites).
- Types autorises: `string`, `int`, `date`, `enum`.

## Modele de definition (conceptuel)
- name: string (snake_case recommande), requis, unique par scope, pattern ^[a-z][a-z0-9_]{1,30}$
- label:
  - fr: string [1..80], requis
  - en: string [1..80], requis
- type: enum {string,int,date,enum}, requis
- required: bool (defaut: false)
- default: valeur optionnelle (doit respecter le type)
- validations (selon type):
  - string: min_length? (>=0), max_length? (>=min), regex? (string)
  - int: min?, max? (min <= max si definis)
  - date: min_date?, max_date? (ISO yyyy-MM-dd; min <= max si definis)
  - enum: enum_values: [string >=1], required si type=enum
- visibility: enum {public, private} (defaut: public)
- editable: bool (defaut: true)
- help_text:
  - fr?: string [0..200]
  - en?: string [0..200]

## Contraintes
- Unicite du `name` par scope (employee).
- Pour type=enum: `enum_values` doit contenir >= 1 valeur unique (case-sensitive autorisee).
- Valeur par defaut, si fournie, doit satisfaire les validations.
- Longueurs et bornes coherentes (min <= max).

## Exemples d'usage (FR)
- `badge_interne` (string, regex ^[A-Z0-9-]{4,12}$)
- `habilitation_caces` (enum: ["R389_1","R389_3","R489_A","R489_B"])
- `date_medicale` (date, min_date=2020-01-01)
- `coef_conventionnel` (int, min=100, max=999)

## Acceptation
- 1 OK: creation d'un champ `string` valide.
- 1 KO: definition `enum` sans valeurs -> rejet avec message clair.

