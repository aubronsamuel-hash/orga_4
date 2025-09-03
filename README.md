# Orga - Monorepo

## Quickstart Windows
```
pwsh -NoLogo -NoProfile -File PS1\be_install.ps1
pwsh -NoLogo -NoProfile -File PS1\be_up.ps1
pwsh -NoLogo -NoProfile -File PS1\be_migrate.ps1
pwsh -NoLogo -NoProfile -File PS1\be_seed.ps1
pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
pwsh -NoLogo -NoProfile -File PS1\be_tests.ps1
```

## Environnements
- Copier `.env.example` vers `.env` et ajuster si besoin (aucun secret).

## Roadmap
La roadmap est scindee en 20 fichiers de 10 etapes chacun sous `docs/roadmap`.
Consulter `docs/roadmap/index.md` pour l'index, les themes, et les regles d'edition.
Le job CI `roadmap-guard` valide la coherence (fichiers, etapes, sections).
Validation locale : `pwsh -NoLogo -NoProfile -File PS1\tools\roadmap_validate.ps1`.

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

## Organigramme v1 (Etape 2)
- Specs: `docs/specs/orgchart_v1.md` et JSON `docs/specs/orgchart_v1.json`.
- Export:
```

pwsh -NoLogo -NoProfile -File PS1\specs\export_org.ps1

```
- Tests (hierarchie):
```

pwsh -NoLogo -NoProfile -File PS1\tests\spec_org_hierarchy.ps1

```
- Packs rapides:
```

pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
pwsh -NoLogo -NoProfile -File PS1\test_all.ps1

```

## RBAC v1 (Etape 3)
- Specs: `docs/specs/rbac_v1.md` et CSV `docs/specs/rbac_v1.csv`.
- Export (regenerer):
```

pwsh -NoLogo -NoProfile -File PS1\specs\export_rbac.ps1

```
- Tests:
```

pwsh -NoLogo -NoProfile -File PS1\tests\spec_rbac_permissions.ps1

```
- Packs rapides:
```

pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
pwsh -NoLogo -NoProfile -File PS1\test_all.ps1

```

## Auth v1 (Etape 4)
- Spec: `docs/specs/auth_v1.md` (v1.0.0).
- Export:
```

pwsh -NoLogo -NoProfile -File PS1\specs\export_auth.ps1

```
- Tests (politique MDP):
```

pwsh -NoLogo -NoProfile -File PS1\tests\spec_auth_password_policy.ps1

```
- Packs rapides:
```

pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
pwsh -NoLogo -NoProfile -File PS1\test_all.ps1

```

## Org Settings v1 (Etape 5)
- Spec: `docs/specs/org_settings_v1.md` (v1.0.0).
- Export:
```

pwsh -NoLogo -NoProfile -File PS1\specs\export_settings.ps1

```
- Tests (TZ OK/KO):
```

pwsh -NoLogo -NoProfile -File PS1\tests\spec_org_settings_tz.ps1

```
- Packs rapides:
```

pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
pwsh -NoLogo -NoProfile -File PS1\test_all.ps1

```

## Notifications v1 (Etape 6)
- Spec: `docs/specs/notifications_v1.md` (v1.0.0).
- Export:
```

pwsh -NoLogo -NoProfile -File PS1\specs\export_notifications.ps1

```
- Tests (rendu de template):
```

pwsh -NoLogo -NoProfile -File PS1\tests\spec_notifications_render.ps1

```
- Packs rapides:
```

pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
pwsh -NoLogo -NoProfile -File PS1\test_all.ps1

```

## i18n v1 (Etape 7)
- Spec: `docs/specs/i18n_v1.md` (v1.0.0).
- Export:
```

pwsh -NoLogo -NoProfile -File PS1\specs\export_i18n.ps1

```
- Tests:
```

pwsh -NoLogo -NoProfile -File PS1\tests\spec_i18n_policy.ps1

```
- Packs rapides:
```

pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
pwsh -NoLogo -NoProfile -File PS1\test_all.ps1

```

## Custom Fields v1 (Etape 8)
- Spec: `docs/specs/custom_fields_v1.md` (v1.0.0).
- Export:
```

pwsh -NoLogo -NoProfile -File PS1\specs\export_custom_fields.ps1

```
- Tests:
```

pwsh -NoLogo -NoProfile -File PS1\tests\spec_custom_fields_validate.ps1

```
- Packs rapides:
```

pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
pwsh -NoLogo -NoProfile -File PS1\test_all.ps1

```

## Import/Export v1 (Etape 9)
- Spec: `docs/specs/import_export_v1.md` (v1.0.0).
- Samples: `docs/samples/employees_sample_ok.csv`, `docs/samples/employees_sample_dup.csv`.
- Export:
```

pwsh -NoLogo -NoProfile -File PS1\specs\export_import.ps1

```
- Tests:
```

pwsh -NoLogo -NoProfile -File PS1\tests\spec_import_csv.ps1

```
- Packs rapides:
```

pwsh -NoLogo -NoProfile -File PS1\smoke.ps1
pwsh -NoLogo -NoProfile -File PS1\test_all.ps1

```

## Audit Log v1 (Etape 10)
- Spec: `docs/specs/audit_log_v1.md` (v1.0.0).
- Export:
```

pwsh -NoLogo -NoProfile -File PS1\specs\export_audit.ps1

```
- Tests:
```

pwsh -NoLogo -NoProfile -File PS1\tests\spec_audit_schema.ps1

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
- `PS1\tools\roadmap_validate.ps1` : verifie roadmap et docs en local.

## CI
- Workflow `roadmap-guard` sur Windows. Echec si la roadmap est incoherente.
- Workflow `docs-guard` sur Windows. Exporte toutes les specs puis verifie la presence des references dans `docs/roadmap/index.md`.
