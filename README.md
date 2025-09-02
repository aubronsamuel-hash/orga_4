# Orga - Monorepo

## Quickstart Windows
```
pwsh -NoLogo -NoProfile -File PS1\dev_up.ps1
pwsh -NoLogo -NoProfile -File PS1\test_all.ps1
pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
```

## Environnements
- Copier `.env.example` vers `.env` et ajuster si besoin (aucun secret).

## Roadmap
La roadmap est scindee en 20 fichiers de 10 etapes chacun sous `docs/roadmap`. 
Consulter `docs/roadmap/index.md` pour l'index, les themes, et les regles d'edition.
Le job CI `roadmap-guard` valide la coherence (fichiers, etapes, sections).

## Specs RH (Etape 1)
- Spec: `docs/specs/employee_v1.md` (version 1.0.0) et JSON `docs/specs/employee_v1.json`.
- Export (regenerer):  
```

pwsh -NoLogo -NoProfile -File PS1\specs\export_employe.ps1

```
- Tests (regex email, 1 OK + 1 KO):  
```

pwsh -NoLogo -NoProfile -File PS1\tests\spec_employee_email_regex.ps1

```
- Packs rapides:
```

pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
pwsh -NoLogo -NoProfile -File PS1\test_all.ps1

```

## Scripts
- `PS1\dev_up.ps1` : mise en route locale (etape 0: no-op).
- `PS1\test_all.ps1` : lance le garde-fou de la roadmap.
- `PS1\smoke.ps1` : verifications rapides.

## CI
- Workflow `roadmap-guard` sur Windows. Echec si la roadmap est incoherente.
