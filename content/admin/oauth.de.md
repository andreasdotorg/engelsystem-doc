---
title: "OAuth-Konfiguration"
weight: 25
---

# OAuth-Konfiguration

Das Engelsystem unterstützt OAuth 2.0 für externe Authentifizierungsanbieter. Damit können sich Benutzer mit Konten von Identity-Providern wie Keycloak, GitHub oder anderen OAuth-kompatiblen Diensten anmelden.

## Wie OAuth funktioniert

Wenn OAuth konfiguriert ist, sehen Benutzer zusätzliche Login-Buttons auf der Anmeldeseite. Ein Klick leitet sie zum externen Anbieter weiter, wo sie sich authentifizieren. Nach erfolgreicher Authentifizierung werden sie mit ihren Profilinformationen zurück zum Engelsystem geleitet.

Für neue Benutzer wird automatisch ein Konto erstellt. Für bestehende Benutzer, die ihr OAuth-Konto verbinden, werden die Systeme verknüpft.

## Konfiguration

OAuth-Anbieter werden in `config/config.php` konfiguriert:

```php
'oauth' => [
    'keycloak' => [
        'client_id'     => 'engelsystem',
        'client_secret' => 'dein-client-secret',
        'url_auth'      => 'https://keycloak.example.com/realms/myrealm/protocol/openid-connect/auth',
        'url_token'     => 'https://keycloak.example.com/realms/myrealm/protocol/openid-connect/token',
        'url_info'      => 'https://keycloak.example.com/realms/myrealm/protocol/openid-connect/userinfo',
        'id'            => 'sub',
        'username'      => 'preferred_username',
        'email'         => 'email',
        'first_name'    => 'given_name',
        'last_name'     => 'family_name',
        'groups'        => [1],
        'mark_arrived'  => false,
    ],
],
```

### Konfigurationsoptionen

| Option | Beschreibung |
|--------|--------------|
| `client_id` | OAuth Client-ID von deinem Anbieter |
| `client_secret` | OAuth Client-Secret |
| `url_auth` | Autorisierungs-Endpunkt-URL |
| `url_token` | Token-Austausch-Endpunkt-URL |
| `url_info` | Benutzerinfo-Endpunkt-URL |
| `id` | Feld in den Benutzerinfos mit eindeutiger Benutzer-ID |
| `username` | Feld mit Benutzername |
| `email` | Feld mit E-Mail-Adresse |
| `first_name` | Feld mit Vorname |
| `last_name` | Feld mit Nachname |
| `url` | Benutzerdefinierte Button-URL (optional) |
| `nested_info` | Auf true setzen wenn Benutzerinfos verschachtelt sind |
| `hidden` | Von Login-Seite verstecken (nur für API-Nutzung) |
| `mark_arrived` | OAuth-Benutzer automatisch als angekommen markieren |
| `groups` | Standard-Gruppen-IDs für neue Benutzer |

## Anbieter einrichten

### Keycloak

1. Erstelle einen neuen Client in deinem Keycloak-Realm
2. Setze das Client-Protokoll auf `openid-connect`
3. Konfiguriere die Redirect-URI: `https://dein-engelsystem.example.com/oauth/keycloak`
4. Kopiere Client-ID und -Secret in deine Konfiguration

### Generisches OAuth 2.0

Für andere Anbieter:

1. Registriere das Engelsystem als OAuth-Anwendung
2. Setze die Callback-URL auf `https://deine-domain.com/oauth/{provider_name}`
3. Notiere Client-ID und -Secret
4. Finde die Autorisierungs-, Token- und Userinfo-Endpunkte des Anbieters
5. Identifiziere welche Felder die Benutzerinformationen enthalten

## Mehrere Anbieter

Du kannst mehrere OAuth-Anbieter konfigurieren. Jeder erscheint als separater Login-Button:

```php
'oauth' => [
    'keycloak' => [
        // Keycloak-Konfiguration
    ],
    'github' => [
        // GitHub-Konfiguration
    ],
],
```

## Benutzerverwaltung

### Neue Benutzer

Wenn ein Benutzer sich zum ersten Mal via OAuth authentifiziert:

1. Ein neues Konto wird automatisch erstellt
2. Profilfelder werden aus OAuth-Daten befüllt
3. Der Benutzer wird zu den in `groups` angegebenen Gruppen hinzugefügt
4. Wenn `mark_arrived` true ist, wird er als angekommen markiert

### Bestehende Benutzer

Benutzer mit bestehenden Konten können OAuth in ihren Profileinstellungen verbinden. Nach dem Verbinden können sie entweder lokales Passwort oder OAuth zum Anmelden verwenden.

### Kontoverknüpfung

OAuth-Konten werden durch die eindeutige ID des Anbieters verknüpft. Wenn sich die OAuth-ID eines Benutzers ändert (selten), erscheint er als neuer Benutzer.

## Sicherheitsüberlegungen

- Speichere `client_secret` sicher, nicht in der Versionskontrolle
- Verwende Umgebungsvariablen für Secrets in Produktion
- Stelle sicher dass OAuth-Anbieter HTTPS verwenden
- Rotiere Client-Secrets regelmäßig

{{% notice tip %}}
Teste die OAuth-Konfiguration mit einer Staging-Umgebung bevor du sie in Produktion aktivierst. Fehlkonfiguration kann Benutzer aussperren oder doppelte Konten erstellen.
{{% /notice %}}

