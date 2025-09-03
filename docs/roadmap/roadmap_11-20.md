# Roadmap 11-20 - RH de base & planification

## Etape 11 - Creation de plannings (editeur)
Objectif: Module d'edition de plannings (jour/semaine/mois) avec creneaux, assignation de salaries, statuts (DRAFT/PUBLISHED).
Livrables:
- Spec fonctionnelle v1 (editeur: grille, drag&drop, duplication, verrouillages).
- Backend: schemas Planning, Shift, Assignment (CRUD en /api/v1), validation Pydantic v2, pagination standard.
- Frontend: vues Planning (jour/semaine/mois), creation/edition/suppression de creneaux, publication de planning.
- Logs JSON (request_id), rate limiting, headers securite.
Scripts:
- PS1/dev_up.ps1: demarrage dev (backend:8000, frontend:5173).
- PS1/smoke.ps1: ping /api/v1/health et chargement page /planning.
Tests:
- OK: creation planning + 2 creneaux -> status 201, lecture renvoie 2 elements.
- KO: creneau avec fin < debut -> 422.
CI Gates:
- backend: pytest + coverage >= 80%.
- frontend: lint + typecheck + vitest + e2e smoke (Playwright).
Acceptation:
- CRUD planning opere en local et via CI, publication verrouille l'edition.
Notes:
- Hypothese: pas d'overlapping check a cette etape (gere plus tard).

## Etape 12 - Disponibilites (salaries)
Objectif: Saisie et consultation des disponibilites/indisponibilites par utilisateur.
Livrables:
- Backend: modele Availability (user_id, start, end, type: AVAILABLE/UNAVAILABLE, source: SELF/ADMIN/IMPORT), endpoints CRUD.
- Frontend: ecran "Mes disponibilites", filtres par periode.
- Import CSV simple (colonnes: email,start,end,type).
Scripts:
- PS1/seed.ps1: genere 3 users + jeux de dispos.
Tests:
- OK: import CSV de 5 lignes -> 5 enregistrements.
- KO: type inconnu -> 400 avec message FR.
CI Gates:
- audits: pip-audit, npm audit (warnings autorises, fail sur high/critical).
Acceptation:
- Un user peut gerer ses dispos et les voir integrer au planning (non bloquant).
Notes:
- Stockage UTC, affichage local (FE).

## Etape 13 - Conflits de planning
Objectif: Detection de double reservation (meme user, chevauchement de creneaux publies).
Livrables:
- Backend: service de detection (O(n log n)), endpoint /planning/conflicts?from=&to=.
- Frontend: badge "Conflits" + panneau lateral listant conflits avec liens.
Scripts:
- PS1/test_all.ps1 inclut test conflit OK/KO.
Tests:
- OK: insertion overlap -> /conflicts renvoie 1 conflit.
- KO: faux-positif sur creneaux adjacents (fin == debut) -> 0 conflit.
CI Gates:
- coverage backend >= 85% sur module conflits.
Acceptation:
- Conflits corrects sur jeu de donnees de demo.
Notes:
- Adjacent non considere comme conflit.

## Etape 14 - Planification automatique (heuristiques v1)
Objectif: Generateur d'assignation automatique simple (greedy + contraintes basiques).
Livrables:
- Backend: /planning/auto-assign (constraints: skills minimales, dispo requise, max heures/jour).
- Frontend: bouton "Auto" + recap des decisions (journal).
Scripts:
- PS1/smoke.ps1: appel auto-assign sur un planning de demo.
Tests:
- OK: 10 creneaux, 5 users avec skills -> couverture >= 90%.
- KO: user depasse max heures/jour -> creneau non assigne et justification retournee.
CI Gates:
- mypy strict, ruff sans warnings.
Acceptation:
- Resultats deterministes sur seed connu.
Notes:
- IA avancee (ML) repoussee; ici heuristiques deterministes.

## Etape 15 - Synchronisation calendrier (ICS/Google/Outlook)
Objectif: Export ICS par user et par planning; connecteurs OAuth prepares (stub) sans secrets.
Livrables:
- Backend: /calendar/ics/{user_id}.ics (public token), /calendar/ics/planning/{id}.ics; conformite RFC5545.
- Frontend: bouton "Exporter ICS", copie URL.
- Doc OPS (FR): gestion des tokens ICS (rotation).
Scripts:
- PS1/rotate_ics_tokens.ps1: rotation tokens ICS demo.
Tests:
- OK: ICS telechargeable, contient 5 VEVENT corrects.
- KO: token invalide -> 401.
CI Gates:
- security headers verifiees sur endpoints ICS.
Acceptation:
- ICS importable dans clients majeurs.
Notes:
- Connecteurs Google/Outlook OAuth a venir (placeholder sans secret).

## Etape 16 - Historique des plannings (versions/restore)
Objectif: Versionning des plannings; possibilite de restaurer une version.
Livrables:
- Backend: table PlanningVersion (diff minimal JSON), endpoints /versions, /restore.
- Frontend: timeline versions + bouton Restore.
Scripts:
- PS1/specs/export_planning_specs.ps1: export schema versionning en MD.
Tests:
- OK: 3 editions -> 3 versions; restore revient a l'etat N-2.
- KO: restore d'une version d'un autre planning -> 403.
CI Gates:
- alembic migrations verifiees (autogen off, scripts explicites).
Acceptation:
- Historique visible et fonctionnel.
Notes:
- Stocker diff compact (operations), pas snapshots complets.

## Etape 17 - Planification multi-sites
Objectif: Support multi etablissements (site_id) et filtrage par site.
Livrables:
- Backend: ajout site_id sur Planning/Shift, RBAC basique par site.
- Frontend: switcher de site (header) + filtres.
Scripts:
- PS1/seed.ps1: ajoute 2 sites et affectations.
Tests:
- OK: user limite a site A ne voit pas plannings site B.
- KO: creation planning sans site_id -> 422.
CI Gates:
- e2e site switching.
Acceptation:
- Isolation logique par site fonctionnelle.
Notes:
- Pas de partitionnement physique a cette etape.

## Etape 18 - Creneaux speciaux (nuits/week-ends/feries)
Objectif: Marquage et regles specifiques (surcouts affiche FE, calculs plus tard).
Livrables:
- Backend: flags NIGHT/WEEKEND/HOLIDAY, calendrier feries FR (table seed).
- Frontend: coloration des creneaux speciaux + filtres.
Scripts:
- PS1/seed_holidays.ps1: seed feries FR.
Tests:
- OK: 14 juillet marque HOLIDAY.
- KO: creneau 22:00-06:00 non marque NIGHT -> test echoue (doit etre NIGHT).
CI Gates:
- unit tests regles marquage.
Acceptation:
- Marquages corrects selon regles definies.
Notes:
- Surcouts comptables traites au jalon comptabilite.

## Etape 19 - Notifications planning (publication/modifs)
Objectif: Notifications email (demo) et webhook (stub) a la publication/modification.
Livrables:
- Backend: event bus interne; handlers Email (SMTP fake dev) et Webhook (POST demo).
- Frontend: centre de notifications (UI basique).
Scripts:
- PS1/notify_test.ps1: envoi de notification de test.
Tests:
- OK: publication planning -> 5 emails generees (dev SMTP).
- KO: webhook 500 -> retry backoff puis echec consigne dans audit.
CI Gates:
- logs JSON; traces correlation par request_id.
Acceptation:
- Notifications observees en environnement dev local.
Notes:
- Pas de secrets commits; SMTP dev via .env local uniquement.

## Etape 20 - Rapports planning (occupation/couverture)
Objectif: KPIs de couverture par periode (taux de couverture creneaux, heures par user/site).
Livrables:
- Backend: /reports/planning?from=&to=&site_id= -> JSON agrge (coverage, missing, overtime).
- Frontend: tableau + export CSV.
Scripts:
- PS1/reports_demo.ps1: genere rapport sur seed.
Tests:
- OK: couverture calculee correctement sur dataset connu.
- KO: periode invalide (from>to) -> 400.
CI Gates:
- pytest + snapshot tests sur JSON.
Acceptation:
- Tableau consultable et exportable; valeurs conformes au seed.
Notes:
- Perf cible: 1000 VUs (k6 plus tard).
