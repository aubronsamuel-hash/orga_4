# Spec - Auth v1

Version: 1.0.0
Objet: definir la strategie d’authentification (MDP, hashing), la politique MDP, le verrouillage, les erreurs FR et les ouvertures SSO/OIDC futures.

## Portee v1
- Auth locale par mot de passe (username/email + password).
- Hashing recommande: Argon2id (prioritaire) ou Bcrypt comme fallback (details d’impl. a l’etape backend).
- Sessions/JWT seront definis dans un lot ulterieur.

## Politique de mot de passe (v1)
- Longueur minimale: 12 caracteres.
- Doit contenir AU MOINS: 1 majuscule [A-Z], 1 minuscule [a-z], 1 chiffre [0-9], 1 special parmi !@#$%^&*()_+-=[]{};:'",.<>/?`~\
- Interdits: espaces en debut/fin; mot de passe present dans la liste noire (ex: "password", "123456", "qwerty", "azerty").
- Exemple OK: `Securite2025!Alpha`
- Exemple KO: `short1!` (trop court)

## Hashing (orientations)
- Argon2id (recommande): params initiaux cibles
  - memory_cost ~ 64-128 MB
  - time_cost ~ 2-3
  - parallelism ~ 2
- Bcrypt (fallback): cost (work factor) 12-14
- Stocker egalement: algorithme, params, sel, hash, date de rotation. Rotation envisagee par politique.

## Verrouillage / Throttling
- 5 tentatives KO sur 15 minutes -> verrouillage 15 minutes (HTTP 423 Locked).
- Compteur de tentatives remis a zero apres succes ou apres delai.
- Backoff progressif en option pour brute-force distribue.

## Messages d’erreur (FR)
- 400 Bad Request: "Requete invalide."
- 401 Unauthorized: "Identifiants invalides."
- 403 Forbidden: "Acces refuse."
- 409 Conflict: "Conflit sur la ressource."
- 422 Unprocessable Entity: "Donnees non valides."
- 423 Locked: "Compte verrouille temporairement suite a plusieurs tentatives infructueuses."
- 429 Too Many Requests: "Trop de tentatives. Veuillez reessayer plus tard."
- 500 Internal Server Error: "Erreur interne."

## Flux
- POST /auth/login: credentials -> tokens/sessions (a definir), verifie compteur, renvoie 401 ou 423 selon etat.
- POST /auth/logout: invalide la session/token (a definir).
- POST /auth/reset-request: demande reset (email).
- POST /auth/reset-confirm: applique nouveau MDP (valide politique).

## SSO/OIDC (v2+)
- Support futur OIDC (Azure AD, Google Workspace, etc.), mapping roles/RBAC.

## Journalisation minimale
- Log securise: request_id, user_id (si connu), evenement (login_ok, login_ko, locked), horodatage UTC, ip_tronquee.

## Acceptation
- Politique MDP testable (OK/KO).
- Erreurs FR listees et codes HTTP associes.
- Verrouillage precise (seuil et delai) documente.

