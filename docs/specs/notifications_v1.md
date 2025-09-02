# Spec - Notifications v1

Version: 1.0.0
Objet: definir les canaux, le catalogue de notifications et le format de template (placeholders) pour l'application.

## Canaux (v1)
- email (texte/HTML minimal plus tard)
- in-app (centre de notifications)

## Placeholders (format)
- Syntaxe: `{{nom_placeholder}}` (ASCII). Sensible a la casse.
- Regle: tout placeholder present dans le template DOIT etre fourni par le contexte de rendu, sinon erreur.

## Catalogue de triggers (v1)
- `employee.created` : lorsqu'un nouvel employe est cree.
  - placeholders: `employee_name`, `employee_email`, `created_at`
  - canal par defaut: email (manager + RH), in-app (RH)
- `schedule.updated` : modification d'un planning.
  - placeholders: `employee_name`, `schedule_period`, `updated_by`
  - canal par defaut: in-app (employe + manager)
- `auth.reset_requested` : demande de reinitialisation de mot de passe.
  - placeholders: `reset_link`, `support_email`, `requested_at`
  - canal par defaut: email (utilisateur cible)

## Templates de reference (FR)
- employee.created (email/texte):
```

Bonjour {{employee_name}},
Votre compte a ete cree avec l'adresse {{employee_email}} le {{created_at}}.

```
- schedule.updated (in-app):
```

Planning mis a jour pour {{employee_name}} sur la periode {{schedule_period}} (par {{updated_by}}).

```
- auth.reset_requested (email/texte):
```

Vous avez demande la reinitialisation de votre mot de passe le {{requested_at}}.
Lien: {{reset_link}} - Support: {{support_email}}

```

## Regles d'envoi (v1)
- Pas de retry/SMTP dans ce lot.
- Rendu du template: si un placeholder requis manque -> erreur explicite.
- Journalisation: type trigger, destinataires, resultat (ok/erreur).

## Acceptation
- 1 OK: rendu reussi quand tous les placeholders sont fournis.
- 1 KO: erreur claire si un placeholder manque.

---
