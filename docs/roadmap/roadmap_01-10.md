# Roadmap 01-10 - RH de base & planification (Actif)

> Rappel: chaque etape doit rester courte, testable, et livrer des artefacts verificables (docs, scripts, endpoints planifies, schemas preliminaires, criteres d’acceptation).

## Etape 1 - Gestion des employes
Objectif:
  Mettre en place le socle conceptuel pour la gestion des salaries (modele de donnees cible, champs requis, contraintes). Preparer le plan d’API CRUD et les regles de validation.
Livrables:
  - Spec fonctionnelle "Employe v1" (champs: id, nom, prenom, email, telephone, role_metier, service, site, statut, date_entree, date_sortie, contrat_type, temps_travail, manager_id).
  - Spec API preliminaire (CRUD /api/v1/employees : GET list/detail, POST, PATCH, DELETE; pagination par defaut).
  - Diagramme de donnees (simple): Employe (1) -> (0..1) Manager (self-reference).
Scripts:
  - PS1\specs\export_employe.ps1 (exporte la spec en JSON/Markdown).
Tests:
  - 1 OK: validation email conforme (regex) documentee.
  - 1 KO: email invalide refuse (cas d’erreur de validation).
CI Gates:
  - docs_guard: la spec employee_v1 est referencee dans README et index roadmap.
  - roadmap_guard: sections completes et liens index OK.
Acceptation:
  - La spec employee_v1 est claire, versionnee, et referencee depuis l’index.
  - Scenarios de validation email definis (OK/KO).
Notes:
  - Pas de code backend ici; uniquement les definitions et validations.

## Etape 2 - Organigramme
Objectif:
  Definir la structure hierarchique (services, equipes, manager -> subordonne) et les vues attendues.
Livrables:
  - Spec "Organigramme v1": champs service (code, libelle), equipe (code, libelle, service_code), liens manager->subordonne.
  - Wireframe FR: vue organigramme (liste + graphe simplifie).
Scripts:
  - PS1\specs\export_org.ps1 (concat spec organigramme v1).
Tests:
  - 1 OK: un manager peut avoir N subordonnes.
  - 1 KO: une boucle managernelle (A->B->A) est interdite (regle formelle).
CI Gates:
  - docs_guard + roadmap_guard: references organigramme v1 presentes.
Acceptation:
  - Relations hierarchiques definies et non cycliques.
Notes:
  - La detection de cycles sera implementee plus tard (service backend).

## Etape 3 - Roles et permissions
Objectif:
  Lister les roles produits initiaux (admin, manager, employe) et le perimetre de leurs droits.
Livrables:
  - Matrice RBAC v1 (ressource x action x role).
  - Liste des ressources cibles a court terme: employees, org_units, schedules (lecture/ecriture/suppression).
Scripts:
  - PS1\specs\export_rbac.ps1 (table RBAC en CSV + Markdown).
Tests:
  - 1 OK: un admin a tous les droits designes.
  - 1 KO: un employe ne peut pas supprimer un autre employe.
CI Gates:
  - docs_guard: matrice RBAC referencee.
Acceptation:
  - Matrice RBAC v1 valider par la roadmap (comprehensible, exploitable).
Notes:
  - Extension RBAC (granularite par champ) prevue plus tard.

## Etape 4 - Authentification
Objectif:
  Decrire la strategie d’auth (password, hashing, futures options SSO/OIDC), exigences de securite, messages d’erreur FR.
Livrables:
  - Spec "Auth v1": flux login/logout, politique MDP, retours d’erreur (codes HTTP + messages FR).
  - Politique de verrouillage (ex: 5 tentatives KO -> delai).
Scripts:
  - PS1\specs\export_auth.ps1 (creer auth_v1.md).
Tests:
  - 1 OK: mot de passe conforme politique accepte (documente).
  - 1 KO: mot de passe trop court refuse (message precise).
CI Gates:
  - docs_guard: auth_v1 referencee.
Acceptation:
  - Politique MDP et messages FR clairement definis (sans secret).
Notes:
  - L’implementation technique (FastAPI) viendra a l’etape dev correspondante.

## Etape 5 - Parametres entreprise
Objectif:
  Formaliser les parametres d’organisation (nom, SIRET, fuseau horaire, adresse, politiques RH).
Livrables:
  - Spec "Org Settings v1": structure de configuration multi-sites.
  - Liste des parametres critiques au lancement (TZ par defaut, monnaies, formats).
Scripts:
  - PS1\specs\export_settings.ps1 (org_settings_v1.md).
Tests:
  - 1 OK: TZ valide reconnu.
  - 1 KO: TZ inconnu -> erreur de validation documentee.
CI Gates:
  - docs_guard + roadmap_guard.
Acceptation:
  - Parametres minimaux identifies et documentes.
Notes:
  - Stockage en DB + page UI dediee planifies plus tard.

## Etape 6 - Notifications systeme
Objectif:
  Decrire les canaux (email, in-app), templates FR, et regles d’envoi basiques.
Livrables:
  - Catalogue de notifications v1 (triggers: creation employe, modif planning, reset MDP).
  - Spec de template (placeholders standards).
Scripts:
  - PS1\specs\export_notifications.ps1 (notifications_v1.md).
Tests:
  - 1 OK: rendu d’un template avec placeholders remplis.
  - 1 KO: placeholder manquant -> rendu refuse (erreur claire).
CI Gates:
  - docs_guard.
Acceptation:
  - Templates et triggers identifies, prets a etre relies a l’app.
Notes:
  - L’envoi reeel (SMTP/API) viendra plus tard.

## Etape 7 - Support multilingue (UI)
Objectif:
  Definir les langues cible (FR/EN), structure i18n (cles), politique de fallback.
Livrables:
  - Spec i18n v1: format des fichiers, nomenclature des cles, guidelines de traduction.
  - Liste initiale de cles (auth, menu, employees).
Scripts:
  - PS1\specs\export_i18n.ps1 (i18n_v1.md).
Tests:
  - 1 OK: fallback vers FR si cle manquante en EN.
  - 1 KO: cle dupliquee signalee dans le build docs.
CI Gates:
  - docs_guard.
Acceptation:
  - Structure i18n claire et reproductible.
Notes:
  - Integration FE/BE dans etapes ulterieures.

## Etape 8 - Champs personnalises
Objectif:
  Decrire un mecanisme generique de champs custom (sur Employe) avec types (string, int, date, enum).
Livrables:
  - Spec "Custom Fields v1": schema, contraintes (nom unique par scope), validations.
  - Exemples FR d’usage (badge_interne, habilitations).
Scripts:
  - PS1\specs\export_custom_fields.ps1 (custom_fields_v1.md).
Tests:
  - 1 OK: creation d’un champ string valide.
  - 1 KO: enum sans valeurs -> rejet.
CI Gates:
  - docs_guard + roadmap_guard (sections completes).
Acceptation:
  - Modele de champs custom pret a etre implemente.
Notes:
  - Migrations et UI a venir dans les steps dev.

## Etape 9 - Import/Export de donnees
Objectif:
  Designer les formats CSV/Excel initiaux (Employes) et les regles de mapping/validation.
Livrables:
  - Spec "Import/Export v1": colonnes, types, contraintes (email unique), mapping.
  - Exemples de fichiers (samples anonymises).
Scripts:
  - PS1\specs\export_import.ps1 (import_export_v1.md).
Tests:
  - 1 OK: import d’une ligne valide.
  - 1 KO: doublon email -> echec avec rapport d’erreurs.
CI Gates:
  - docs_guard.
Acceptation:
  - Formats eprouves par exemples conformes.
Notes:
  - Le moteur d’import sera code plus tard (FastAPI task).

## Etape 10 - Journalisation
Objectif:
  Decrire les evenements a journaliser (CRUD Employe, Auth, Imports) et le format JSON.
Livrables:
  - Spec "Audit Log v1": champs: request_id, actor_id, ressource, action, timestamp UTC, details.
  - Niveaux et retention (minima).
Scripts:
  - PS1\specs\export_audit.ps1 (audit_log_v1.md).
Tests:
  - 1 OK: evenement CRUD theorique conforme au schema.
  - 1 KO: timestamp non UTC -> non conforme.
CI Gates:
  - docs_guard + roadmap_guard.
Acceptation:
  - Schema d’audit clair, pret a instrumenter.
Notes:
  - OpenTelemetry en option plus tard.

