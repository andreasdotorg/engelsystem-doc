---
title: "Konfiguration"
date: 2019-02-13T19:39:21+01:00
weight: 20
---

Die Engelsystem-Konfiguration befindet sich in PHP-Dateien im `config/`-Verzeichnis. Die Hauptkonfigurationsdatei ist `config/config.php`, die die Standardwerte in `config/config.default.php` überschreibt. Viele Einstellungen können auch über Umgebungsvariablen gesteuert werden, was die Konfiguration von Deployments via Docker oder Kubernetes erleichtert.

## Wie die Konfiguration funktioniert

Engelsystem lädt die Konfiguration in dieser Reihenfolge:

1. **`config/config.default.php`** - Wird mit sinnvollen Standardwerten ausgeliefert. Bearbeite diese Datei nie direkt, da Updates deine Änderungen überschreiben.
2. **`config/config.php`** - Deine lokalen Überschreibungen. Kopiere Einstellungen aus der Standarddatei und ändere sie hier.
3. **Umgebungsvariablen** - Viele Einstellungen prüfen zuerst Umgebungsvariablen, was containerbasierte Konfiguration ermöglicht.

Die `env()`-Hilfsfunktion prüft Umgebungsvariablen mit einem Fallback-Wert:

```php
// Verwendet TIMEZONE-Umgebungsvariable falls gesetzt, sonst 'Europe/Berlin'
'timezone' => env('TIMEZONE', 'Europe/Berlin'),
```

Für eine vollständige Liste aller Optionen siehe die Kommentare in `config/config.default.php`.

## Wesentliche Einstellungen

Diese Einstellungen müssen für jedes Deployment konfiguriert werden.

### Datenbankverbindung

Engelsystem erfordert MySQL 5.7+ oder MariaDB 10.2+. Konfiguriere deine Datenbank-Zugangsdaten:

```php
'database' => [
    'host'     => env('MYSQL_HOST', 'localhost'),
    'database' => env('MYSQL_DATABASE', 'engelsystem'),
    'username' => env('MYSQL_USER', 'engelsystem'),
    'password' => env('MYSQL_PASSWORD', ''),
],
```

Der Datenbankbenutzer benötigt SELECT-, INSERT-, UPDATE- und DELETE-Berechtigungen. Für Migrationen bei Updates benötigt er außerdem CREATE-, ALTER-, DROP- und INDEX-Berechtigungen.

{{% notice warning %}}
Committe nie Datenbankpasswörter in die Versionskontrolle. Verwende Umgebungsvariablen oder eine `.env`-Datei, die von Git ausgeschlossen ist.
{{% /notice %}}

### Anwendungsname

Passe den Anwendungsnamen an, der in der Oberfläche und E-Mails angezeigt wird:

```php
'app_name' => env('APP_NAME', 'Engelsystem'),
```

Die meisten Events benennen dies in etwas Bedeutsames wie "Heaven" oder "[Eventname] Angel System" um.

### Zeitzone

Setze die Zeitzone deines Events. Alle Schichtzeiten werden in dieser Zeitzone angezeigt:

```php
'timezone' => env('TIMEZONE', 'Europe/Berlin'),
```

Verwende PHP-Zeitzonenbezeichner wie `America/New_York`, `Asia/Tokyo` oder `UTC`. Siehe die [PHP-Zeitzonenliste](https://www.php.net/manual/de/timezones.php) für alle Optionen.

### Umgebungsmodus

Steuert Fehleranzeige und Debugging:

```php
'environment' => env('ENVIRONMENT', 'production'),
```

| Wert | Verhalten |
|------|-----------|
| `production` | Versteckt detaillierte Fehler, optimiert für Performance |
| `development` | Zeigt detaillierte Fehlermeldungen und Stack-Traces |

{{% notice warning %}}
Verwende nie den `development`-Modus in Produktion. Detaillierte Fehler können sensible Informationen preisgeben.
{{% /notice %}}

## Benutzerregistrierungs-Einstellungen

Steuere, wie sich Freiwillige registrieren können und welche Informationen sie angeben.

### Registrierung aktivieren

Schalte um, ob sich neue Benutzer registrieren können:

```php
'registration_enabled' => (bool)env('REGISTRATION_ENABLED', true),
```

Deaktiviere dies nach deiner Freiwilligen-Anmeldefrist oder wenn du Konten manuell verwaltest.

### Ankunftserfordernis

Erfordere, dass Freiwillige als "angekommen" markiert sind, bevor sie sich für Schichten anmelden:

```php
'signup_requires_arrival' => false,
```

Aktiviere dies, um zu verhindern, dass Leute Schichten übernehmen, bevor sie physisch beim Event angekommen sind. Mitarbeiter an deinem Info-Desk markieren Benutzer als angekommen, wenn sie einchecken.

### Passwortanforderungen

Konfiguriere die Passwortsicherheit:

```php
// Minimale Passwortlänge
'min_password_length' => 8,

// Hash-Algorithmus (verwende PASSWORD_DEFAULT für beste Sicherheit)
'password_algorithm' => PASSWORD_DEFAULT,
```

Die `PASSWORD_DEFAULT`-Konstante verwendet automatisch PHPs empfohlenen Algorithmus (derzeit bcrypt, kann sich in zukünftigen PHP-Versionen ändern). Bestehende Passwörter werden automatisch neu gehasht, wenn sich Benutzer anmelden.

## Schicht- und Planungseinstellungen

Diese Einstellungen steuern, wie Schichten funktionieren und wie Freiwillige mit ihnen interagieren.

### Schicht-Abmeldefenster

Wie viele Stunden vor Schichtbeginn können Freiwillige noch absagen:

```php
'last_unsubscribe' => 3,
```

Setze dies hoch genug, dass Koordinatoren Zeit haben, Ersatz zu finden, aber niedrig genug, dass Freiwillige flexibel bleiben. Übliche Werte sind 2-6 Stunden.

### Freeloading-Schutz

Verhindere, dass Freiwillige sich wiederholt für Schichten anmelden und nicht erscheinen:

```php
'max_freeloadable_shifts' => 2,
```

Nach dieser Anzahl von Freeload-Schichten wird der Benutzer daran gehindert, sich für weitere Schichten anzumelden. Supporter oder Bürokraten können die Freeload-Markierungen löschen, um sie zu entsperren.

### Nachtschicht-Bonus

Gib Extra-Credit für Schichten zu ungünstigen Zeiten:

```php
'night_shifts' => [
    'enabled'    => true,
    'start'      => 2,    // Nachtperiode beginnt um 2:00
    'end'        => 8,    // Nachtperiode endet um 8:00
    'multiplier' => 2,    // Stunden zählen doppelt
],
```

Eine 3-Stunden-Schicht von 3:00-6:00 würde als 6 Stunden für Belohnungen zählen, wenn aktiviert. Deaktiviere, wenn alle Schichten unabhängig von der Zeit gleich zählen sollen.

### Gutschein-Berechnung

Konfiguriere, wie Freiwillige Gutscheine verdienen (Essensmarken, Getränke-Tokens usw.):

```php
'voucher_settings' => [
    'initial_vouchers'   => 0,    // Gutscheine bei Registrierung
    'shifts_per_voucher' => 1,    // Gutscheine pro Schicht
    'hours_per_voucher'  => 2,    // ODER benötigte Stunden pro Gutschein
    'voucher_start'      => null, // Startdatum (Y-m-d Format)
],
```

**Beispielszenarien:**

- **Ein Gutschein pro Schicht**: Setze `shifts_per_voucher` auf 1
- **Gutschein alle 4 Arbeitsstunden**: Setze `hours_per_voucher` auf 4
- **Zwei Startgutscheine**: Setze `initial_vouchers` auf 2
- **Gutscheine nur während des Events**: Setze `voucher_start` auf das Startdatum deines Events

## Belohnungen und Goodies

Konfiguriere, wie Freiwillige Belohnungen verdienen und erhalten.

### Goodie-Typ

Welche Art von Belohnungen bietet dein Event?

```php
'goodie_type' => 'tshirt',
```

| Wert | Verhalten |
|------|-----------|
| `none` | Keine Goodies, Belohnungs-Tracking deaktiviert |
| `goodie` | Generische Belohnung ohne Größenoptionen |
| `tshirt` | T-Shirt-Belohnungen mit Größenauswahl |

### T-Shirt-Größen

Bei Verwendung des `tshirt`-Goodie-Typs definiere verfügbare Größen:

```php
'tshirt_sizes' => [
    'S'    => 'Small Straight-Cut',
    'S-G'  => 'Small Fitted-Cut',
    'M'    => 'Medium Straight-Cut',
    'M-G'  => 'Medium Fitted-Cut',
    'L'    => 'Large Straight-Cut',
    'L-G'  => 'Large Fitted-Cut',
    'XL'   => 'XLarge Straight-Cut',
    'XL-G' => 'XLarge Fitted-Cut',
    '2XL'  => '2XLarge Straight-Cut',
    '3XL'  => '3XLarge Straight-Cut',
    '4XL'  => '4XLarge Straight-Cut',
],
```

Passe diese Liste an das an, was dein Event tatsächlich vorrätig hat. Entferne Größen, die du nicht anbietest.

## Kommunikationseinstellungen

Konfiguriere, wie Engelsystem E-Mails versendet.

### E-Mail-Konfiguration

```php
'email' => [
    'driver' => env('MAIL_DRIVER', 'mail'),
    'from'   => [
        'address' => env('MAIL_FROM_ADDRESS', 'noreply@engelsystem.de'),
        'name'    => env('MAIL_FROM_NAME', env('APP_NAME', 'Engelsystem')),
    ],
    // SMTP-Einstellungen (wenn Driver 'smtp' ist)
    'host'       => env('MAIL_HOST', 'localhost'),
    'port'       => env('MAIL_PORT', 587),
    'encryption' => env('MAIL_ENCRYPTION', null),  // 'tls' oder 'ssl'
    'username'   => env('MAIL_USERNAME'),
    'password'   => env('MAIL_PASSWORD'),
    // Sendmail-Pfad (wenn Driver 'sendmail' ist)
    'sendmail'   => env('MAIL_SENDMAIL', '/usr/sbin/sendmail -bs'),
],
```

**Verfügbare Treiber:**

| Treiber | Anwendungsfall |
|---------|----------------|
| `mail` | PHPs eingebaute Mail-Funktion (erfordert lokalen Mail-Server) |
| `smtp` | Externer SMTP-Server (empfohlen für Produktion) |
| `sendmail` | Lokale Sendmail-Binary |
| `log` | Schreibt E-Mails ins Log statt sie zu senden (zum Testen) |

**SMTP-Beispiel für gängige Anbieter:**

```php
// Gmail (erfordert App-Passwort)
'email' => [
    'driver'     => 'smtp',
    'host'       => 'smtp.gmail.com',
    'port'       => 587,
    'encryption' => 'tls',
    'username'   => 'deine-email@gmail.com',
    'password'   => 'dein-app-passwort',
],

// Mailgun
'email' => [
    'driver'     => 'smtp',
    'host'       => 'smtp.mailgun.org',
    'port'       => 587,
    'encryption' => 'tls',
    'username'   => 'postmaster@deine-domain.mailgun.org',
    'password'   => 'dein-mailgun-passwort',
],
```

### Footer-Links

Füge benutzerdefinierte Links zum Seiten-Footer hinzu:

```php
'footer_items' => [
    'FAQ'     => 'https://dein-event.org/freiwillige/faq',
    'Kontakt' => 'mailto:freiwillige@dein-event.org',
],
```

Verwende dies für Links zu deiner Event-Freiwilligen-FAQ, Kontaktinfo oder Verhaltenskodex.

## Lokalisierungseinstellungen

Konfiguriere die Sprachunterstützung.

### Verfügbare Sprachen

```php
'locales' => [
    'de_DE.UTF-8' => 'Deutsch',
    'en_US.UTF-8' => 'English',
],
```

Benutzer können in ihren Einstellungen zwischen diesen Sprachen wechseln. Entferne Sprachen, die du nicht anbieten möchtest.

### Standardsprache

```php
'default_locale' => env('DEFAULT_LOCALE', 'en_US.UTF-8'),
```

Neue Benutzer und abgemeldete Besucher sehen diese Sprache.

## Erscheinungsbild-Einstellungen

Passe das visuelle Erscheinungsbild an.

### Theme

```php
'theme' => env('THEME', 1),
```

Setze das Standard-Theme per Nummer. Verfügbare Themes werden in der `themes`-Einstellung definiert. Benutzer können dies in ihren persönlichen Einstellungen überschreiben.

### Verfügbare Themes

```php
'themes' => [
    '0' => 'Engelsystem light',
    '1' => 'Engelsystem dark',
    // Historische Congress-Themes
    '7' => 'Engelsystem 35c3 dark (2018)',
    '6' => 'Engelsystem 34c3 dark (2017)',
    // ... weitere Themes
],
```

## Sicherheitseinstellungen

Diese Einstellungen beeinflussen die Anwendungssicherheit.

### API-Schlüssel

Schützt API-Endpunkte vor unbefugtem Zugriff:

```php
'api_key' => '<dein-zufälliger-api-schlüssel>',
```

Generiere einen zufälligen String (32+ Zeichen empfohlen). API-Anfragen müssen diesen als `api_key`-Parameter enthalten.

{{% notice warning %}}
Verwende einen starken, zufälligen API-Schlüssel. Verwende nie einfache Strings wie "secret" oder "api-key".
{{% /notice %}}

### Session-Konfiguration

```php
'session' => [
    'driver'   => env('SESSION_DRIVER', 'pdo'),
    'name'     => 'session',
    'lifetime' => env('SESSION_LIFETIME', 30),  // Tage
],
```

| Treiber | Speicher |
|---------|----------|
| `pdo` | Datenbank (empfohlen, funktioniert mit Load Balancing) |
| `native` | PHP-Session-Dateien |

### Vertrauenswürdige Proxies

Wenn Engelsystem hinter einem Reverse-Proxy oder Load-Balancer läuft, konfiguriere vertrauenswürdige Proxy-IPs:

```php
'trusted_proxies' => env('TRUSTED_PROXIES', ['127.0.0.0/8', '::1/128']),
```

Dies stellt sicher, dass weitergeleitete Header (wie `X-Forwarded-For`) nur von bekannten Proxies vertraut werden. Für Kubernetes musst du möglicherweise den Pod-Netzwerkbereich deines Clusters vertrauen.

### Security-Header

Engelsystem fügt standardmäßig Security-Header hinzu:

```php
'add_headers' => (bool)env('ADD_HEADERS', true),
'headers'     => [
    'X-Content-Type-Options'  => 'nosniff',
    'X-Frame-Options'         => 'sameorigin',
    'Referrer-Policy'         => 'strict-origin-when-cross-origin',
    'Content-Security-Policy' => 'default-src \'self\'; style-src \'self\' \'unsafe-inline\'; img-src \'self\' data:;',
    'X-XSS-Protection'        => '1; mode=block',
    // Für HTTPS-only-Sites auskommentieren:
    // 'Strict-Transport-Security' => 'max-age=7776000',
],
```

Setze jeden Header auf `null`, um ihn zu deaktivieren. Aktiviere `Strict-Transport-Security` nur, wenn deine Seite ausschließlich HTTPS verwendet.

## Wartungsmodus

Nimm das System für Wartung offline:

```php
'maintenance' => env('MAINTENANCE', false),
```

Wenn aktiviert, sehen Benutzer den Inhalt aus `resources/views/layouts/maintenance.html` und können keine Funktionen nutzen. Nützlich während Datenbank-Migrationen oder größeren Updates.

## Oberflächen-Einstellungen

### News-Paginierung

Wie viele News-Einträge pro Seite erscheinen:

```php
'display_news' => 10,
```

### Credits-Seite

Passe die Credits/Über-Seite an:

```php
'credits' => [
    'Contribution' => 'Bitte besuche [engelsystem/engelsystem](https://github.com/engelsystem/engelsystem) für Beiträge und Fehlerberichte.'
],
```

## Umgebungsvariablen-Referenz

Für Container-Deployments werden diese Umgebungsvariablen häufig verwendet:

| Variable | Zweck | Standard |
|----------|-------|----------|
| `MYSQL_HOST` | Datenbank-Hostname | `localhost` |
| `MYSQL_DATABASE` | Datenbankname | `engelsystem` |
| `MYSQL_USER` | Datenbank-Benutzername | `engelsystem` |
| `MYSQL_PASSWORD` | Datenbank-Passwort | (leer) |
| `APP_NAME` | Anwendungsname | `Engelsystem` |
| `ENVIRONMENT` | `production` oder `development` | `production` |
| `TIMEZONE` | PHP-Zeitzonenbezeichner | `Europe/Berlin` |
| `THEME` | Standard-Theme-Nummer | `1` |
| `REGISTRATION_ENABLED` | Neue Registrierungen erlauben | `true` |
| `MAIL_DRIVER` | E-Mail-Treiber | `mail` |
| `MAIL_HOST` | SMTP-Hostname | `localhost` |
| `MAIL_PORT` | SMTP-Port | `587` |
| `MAIL_ENCRYPTION` | `tls`, `ssl` oder leer | (keine) |
| `MAIL_USERNAME` | SMTP-Benutzername | (keine) |
| `MAIL_PASSWORD` | SMTP-Passwort | (keine) |
| `MAIL_FROM_ADDRESS` | Absender-E-Mail-Adresse | `noreply@engelsystem.de` |
| `MAIL_FROM_NAME` | Absendername | (verwendet APP_NAME) |
| `SESSION_DRIVER` | `pdo` oder `native` | `pdo` |
| `SESSION_LIFETIME` | Session-Lebenszeit in Tagen | `30` |
| `TRUSTED_PROXIES` | Vertrauenswürdige Proxy-IPs | `127.0.0.0/8` |
| `MAINTENANCE` | Wartungsmodus aktivieren | `false` |
| `DEFAULT_LOCALE` | Standardsprache | `en_US.UTF-8` |

## Häufige Konfigurationsszenarien

### Kleiner Hackathon (50-100 Freiwillige)

```php
return [
    'app_name'                => 'HackHelper',
    'registration_enabled'    => true,
    'signup_requires_arrival' => false,
    'goodie_type'             => 'none',
    'last_unsubscribe'        => 1,
    'night_shifts'            => ['enabled' => false],
];
```

### Große Konferenz (500+ Freiwillige)

```php
return [
    'app_name'                => 'Conference Angels',
    'signup_requires_arrival' => true,
    'goodie_type'             => 'tshirt',
    'last_unsubscribe'        => 4,
    'max_freeloadable_shifts' => 2,
    'night_shifts'            => [
        'enabled'    => true,
        'start'      => 2,
        'end'        => 8,
        'multiplier' => 2,
    ],
    'voucher_settings'        => [
        'initial_vouchers'   => 1,
        'hours_per_voucher'  => 6,
    ],
];
```

