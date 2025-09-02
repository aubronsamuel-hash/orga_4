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

## Scripts
- `PS1\dev_up.ps1` : mise en route locale (etape 0: no-op).
- `PS1\test_all.ps1` : lance le garde-fou de la roadmap.
- `PS1\smoke.ps1` : verifications rapides.

## CI
- Workflow `roadmap-guard` sur Windows. Echec si la roadmap est incoherente.
