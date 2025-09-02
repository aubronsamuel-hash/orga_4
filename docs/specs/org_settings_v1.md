# Spec - Org Settings v1

Version: 1.0.0
Objet: definir la structure de configuration multi-sites et les parametres critiques de l’organisation.

## Portee v1
- Multi-sites (organisation possede 1..N sites).
- Parametres globaux (org) et specifiques (site).
- Sans secret (identifiants/cles gerees ailleurs).

## Modele (conceptuel)
Organisation (root)
- org_id: uuid
- nom: string [2..120] (requis)
- siret: string [14] FR optionnel (ou numero similaire selon pays)
- timezone_default: string (IANA ou "UTC") (requis) ex: UTC, Europe/Paris, Indian/Reunion
- devise_default: string (ISO 4217) ex: EUR, USD, GBP (requis)
- locale_default: string (BCP 47) ex: fr-FR, en-US (requis)
- formats:
  - date: string (ex: yyyy-MM-dd)
  - time: string (ex: HH:mm)
  - number: string (ex: 1 234,56)
- politiques_rh:
  - semaine_1er_jour: int (1=lundi, 7=dimanche)
  - conges_arrondi_heures: bool
  - jours_feries_strategy: string (ex: FR-national, custom)

Sites (1..N)
- site_id: uuid
- code: string [2..30] (unique org)
- nom: string [2..120]
- adresse:
  - ligne1, ligne2?, code_postal, ville, pays
- timezone: string (IANA/UTC) (optionnel; defaut = timezone_default)
- devise: string (ISO 4217) (optionnel; defaut = devise_default)
- locale: string (BCP 47) (optionnel; defaut = locale_default)

## Parametres critiques au lancement
- timezone_default (obligatoire)
- devise_default (ISO 4217)
- locale_default (BCP 47)
- formats (date/time/number)
- semaine_1er_jour

## Conventions
- Stockage des timestamps en UTC (DB); affichage converti par site/locale.
- Validation TZ: IANA (ex: Europe/Paris, Indian/Reunion) ou "UTC".
- Devise: ISO 4217 (EUR, USD, GBP, ...).
- Locale: BCP 47 (fr-FR, en-US, ...).

## Exemples
Organisation:
- nom: Orga Demo
- siret: 12345678901234
- timezone_default: Europe/Paris
- devise_default: EUR
- locale_default: fr-FR

Site Bobino:
- code: BOBINO
- timezone: Europe/Paris
- devise: EUR
- locale: fr-FR

## Acceptation
- Parametres minimaux identifies, valides et documentes (sans secret).
- Test OK/KO sur fuseaux horaires.
