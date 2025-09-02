# Spec - Import/Export v1

Version: 1.0.0
Objet: definir le format CSV/Excel d'echange des employes et les regles de mapping/validation.

## Format CSV (UTF-8, ; separateur)
Colonnes et types:
- id (UUID, optionnel a l'import; genere si vide)
- nom (string 2..100, requis)
- prenom (string 1..100, requis)
- email (string, requis, unique, format email v1)
- telephone (string, optionnel)
- role_metier (string, optionnel)
- service (string, optionnel)
- site (string, optionnel)
- statut (string enum: actif|inactif|archive; defaut actif)
- date_entree (date ISO yyyy-MM-dd, optionnel)
- date_sortie (date ISO yyyy-MM-dd, optionnel)
- contrat_type (enum: CDI|CDD|Intermittent|Freelance|Stage|Autre, optionnel)
- temps_travail (number 0..100, optionnel)
- manager_email (string, optionnel; mapping vers manager_id)

## Regles de validation
- email: format conforme a employee_v1 + unicite dans le fichier ET en base (intra-fichier v1).
- date_sortie >= date_entree si presentes.
- statut conforme a l'enum.
- Si manager_email renseigne, il doit exister (ou etre resolu dans un second passage v2).

## Mapping (v1)
- manager_email -> manager_id (resolution exterieure au scope de ce lot).
- colonnes non reconnues -> ignorees (warning).

## Erreurs
- Rapport CSV/texte listant: ligne, colonne, erreur (FR), code (ex: EMAIL_DUPLICATE).

## Exemples (voir /docs/samples)
- employees_sample_ok.csv : 1 ligne valide.
- employees_sample_dup.csv : 2 lignes dont doublon email -> KO.

## Acceptation
- 1 OK: import d'une ligne valide.
- 1 KO: doublon email -> echec avec message.

---
