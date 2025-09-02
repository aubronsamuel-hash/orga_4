# Feuille de route (200 etapes)

Cette feuille de route couvre le perimetre complet d'une application RH integree avec module Evenementiel interne.
Source initiale: "Feuille de route integree RH & Evenements internes" (document transmis par l'utilisateur).
Les rubriques ont ete reorganisees en 20 fichiers de 10 etapes chacun, pour un total de 200 etapes.
Chaque etape contient: Titre, Objectif, Livrables, Scripts, Tests, CI Gates, Acceptation, Notes.

## Table des fichiers (10 etapes par fichier)
- **roadmap_01-10.md (Actif)** : RH de base & planification (1-10) — Etapes detaillees (specs, tests, criteres).
  - Etape 1 - Gestion des employes: spec Employe v1 -> docs/specs/employee_v1.md (v1.0.0).
  - Etape 2 - Organigramme v1: voir docs/specs/orgchart_v1.md (v1.0.0). Contraintes: pas d'auto-reference, pas de cycles, N subordonnes autorises.
  - Etape 3 - Roles et permissions (RBAC v1): voir docs/specs/rbac_v1.md (v1.0.0). Matrice CSV docs/specs/rbac_v1.csv.
  - Etape 4 - Authentification: voir `docs/specs/auth_v1.md` (v1.0.0). Politique MDP 12+, verrous 5/15 min, messages FR.
- roadmap_11-20.md : RH de base & planification (11-20)
- roadmap_21-30.md : Conges, absences, temps (21-30)
- roadmap_31-40.md : Conges, absences, temps (31-40)
- roadmap_41-50.md : Paie & documents RH (41-50)
- roadmap_51-60.md : Paie & documents RH (51-60)
- roadmap_61-70.md : Application mobile & integrations (61-70)
- roadmap_71-80.md : Application mobile & integrations (71-80)
- roadmap_81-90.md : Communication & collaboration interne (81-90)
- roadmap_91-100.md : Communication & collaboration interne (91-100)
- roadmap_101-110.md : Evenements internes (101-110)
- roadmap_111-120.md : Evenements internes (111-120)
- roadmap_121-130.md : Reporting, analyses, observabilite (121-130)
- roadmap_131-140.md : Reporting, analyses, observabilite (131-140)
- roadmap_141-150.md : Securite & infrastructure (141-150)
- roadmap_151-160.md : Securite & infrastructure (151-160)
- roadmap_161-170.md : Internationalisation & conformite (161-170)
- roadmap_171-180.md : Internationalisation & conformite (171-180)
- roadmap_181-190.md : Onboarding, talents & performance (181-190)
- roadmap_191-200.md : Onboarding, talents & performance (191-200)

## Rattachements aux themes de la source fournie
- RH de base & planification: employes, organigramme, roles, auth, parametres, notifications, multilingue, champs personnalises, import/export, journalisation, plannings, disponibilites, conflits, auto-planification, sync calendrier, historique, multi-sites, creneaux speciaux, notifications planning, rapports planning.
- Conges/absences/temps: demandes/validation conges, soldes, absences, regles, integration au planning, notifications, report/expiration, conges speciaux, statistiques, export, pointage, validation heures, heures supp, RTT/repos, temps reel, absence non justifiee, correlation planning/pointage, export vers paie, pointage mobile, rapports de temps.
- Paie/documents RH: variables paie, calcul, bulletins, parametrage, declarations sociales, integration paie, historique, notes de frais, acomptes, rapports masse salariale, contrats, documents legaux, alertes echeances, espace personnel, archivage securise, permissions documents, modeles, signature electronique, conservation legale, GED.
- Application mobile & integrations: apps salarie/manager, push, pointage mobile, consultation, offline, UX mobile, auth mobile, MAJ app, multiplateforme, API/Swagger, securite API, webhooks, connecteurs, SSO, sync calendriers, marketplace, quotas, versioning.
- Communication interne: messagerie, annonces, email/SMS, bulletin, sondages, Slack/Teams, chatbot, groupes, reseau social, reconnaissance, base de connaissances, recherche, espace collaboratif, centre de notifications, rapports, boite a idees, suivi de projet, templates, feedback continu, stats engagement.
- Evenements internes: creation, multi-sites, planification, roles/affectations, logistique, validation, inscriptions, pointage, feedback, reporting, budget, gestion inscriptions, logistique detaillee, securite, hybrides, prestataires, plan detaille, suivi taches, documents, ROI.
- Reporting & observabilite: dashboards RH/KPI planning/KPI evenements, rapports auto, analyse predictive, connecteurs BI, logs d'audit, surveillance systeme, alertes, observabilite applicative, climat social, dashboards personnalises, surveillance continue, tests de charge, journal systeme, reporting multi-sites, integrite donnees, alerting KPI, visualisation avancee, indicateurs securite.
- Securite & infra: 2FA, RBAC, chiffrement, RGPD, tests secu, audit conformite, politique MDP, logs connexion, sauvegardes, sessions, infra cloud, CI/CD, containerisation, supervision, environnements, centralisation logs, tests charge infra, PRA, docs infra, dependances.
- Internationalisation & conformite: support multi-langues, formats localises, reglementations locales, fuseaux horaires, multi-entites, cotisations, jours feries, docs localisees, multi-devise, veille legislative/juridique, RGPD avance, archivage legal, risques RH, normes/certifs, relations sociales, licences IT, formations obligatoires, politiques internes, evaluation fournisseurs.
- Onboarding/talents/performance: onboarding, livret accueil, equipements, formation interne, rappels, competences, mentorat, carriere, eval formation, rapports formation, objectifs, entretiens annuels, feedback continu, cartographie competences, plan de carriere, 360, gamification, rapports performance, alertes objectifs, suivi talents.

## Regles d'edition
- Toute modification d'une etape doit mettre a jour son fichier ET ce index.md (coherence imposee par roadmap_guard).
- Sections obligatoires par etape: Titre, Objectif, Livrables, Scripts, Tests, CI Gates, Acceptation, Notes.
- Langue: Francais pour la documentation et la roadmap.

## Scripts utiles (PowerShell)
- pwsh -NoLogo -NoProfile -File PS1\dev_up.ps1
- pwsh -NoLogo -NoProfile -File PS1\test_all.ps1
- pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
