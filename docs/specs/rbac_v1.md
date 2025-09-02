# Matrice RBAC v1

Version: 1.0.0
Objet: definir les droits initiaux par role (admin, manager, employe) sur les ressources critiques court terme.

## Ressources cibles (v1)
- employees
- org_units (services/equipes)
- schedules

## Actions standard
- read:list, read:detail, create, update, delete

## Regles v1
- admin: tous les droits sur toutes les ressources.
- manager: lecture sur tout, creation/update limitees au perimetre d'equipe (politique precisee plus tard), pas de delete sur org_units; delete employees restreint (v2).
- employe: lecture de base (self + donnees publiques), pas de create/update/delete sauf operations personnelles futures (v2).

Voir tableau CSV/Markdown pour la matrice de verite.

### Tableau (extrait aligne au CSV)
resource | action      | admin | manager | employe
employees| read:list   | allow | allow   | allow  
employees| read:detail | allow | allow   | allow  
employees| create      | allow | allow   | deny   
employees| update      | allow | allow   | deny   
employees| delete      | allow | deny    | deny   
org_units| read:list   | allow | allow   | allow  
org_units| read:detail | allow | allow   | allow  
org_units| create      | allow | deny    | deny   
org_units| update      | allow | deny    | deny   
org_units| delete      | allow | deny    | deny   
schedules| read:list   | allow | allow   | allow  
schedules| read:detail | allow | allow   | allow  
schedules| create      | allow | allow   | deny   
schedules| update      | allow | allow   | deny   
schedules| delete      | allow | deny    | deny   

Notes:
- Les contraintes "perimetre d'equipe" seront definies applicativement a l'etape backend correspondante.
- Une granularite par champ (field-level) sera traitee en extension (v2).
