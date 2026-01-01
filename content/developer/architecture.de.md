---
title: "Architektur"
weight: 10
---

Diese Seite bietet eine Übersicht über die technische Architektur des Engelsystems für Entwickler*innen.

## Tech Stack

### Backend

| Komponente | Technologie | Version |
|------------|-------------|---------|
| Sprache | PHP | >= 8.2 |
| Container | Custom DI Container | - |
| ORM | Eloquent (illuminate/database) | ^12.x |
| Routing | FastRoute (nikic/fast-route) | ^1.3 |
| Templating | Twig | ^3.x |
| HTTP | PSR-7 (nyholm/psr7) | ^1.8 |
| Validierung | respect/validation | ^2.3 |
| Markdown | erusev/parsedown | ^1.7 |
| Kalender | eluceo/ical | ^2.x |

### Frontend

| Komponente | Technologie | Version |
|------------|-------------|---------|
| CSS Framework | Bootstrap | ^5.3 |
| Build Tool | Webpack | ^5.x |
| JS/TS | TypeScript | ^5.x |
| Icons | Bootstrap Icons | ^1.11 |
| Charts | Chart.js | ^4.x |

### Infrastruktur

| Komponente | Technologie |
|------------|-------------|
| Datenbank | MySQL/MariaDB |
| Paketmanager | Composer (PHP), Yarn (JS) |
| Build System | Nix Flake |
| CI/CD | GitLab CI |
| Containerisierung | Docker/Kubernetes |

## Verzeichnisstruktur

```
engelsystem/
├── bin/                    # CLI-Skripte
│   └── migrate             # Datenbank-Migrations-Runner
├── config/                 # Konfigurationsdateien
│   ├── app.php            # Service Provider, Middleware, Routen
│   ├── config.default.php # Standard-Konfigurationswerte
│   └── routes.php         # Routen-Definitionen
├── db/                     # Datenbankbezogen
│   ├── factories/         # Eloquent Model Factories
│   └── migrations/        # Datenbank-Migrationen
├── docker/                 # Docker-Konfiguration
├── includes/               # Legacy-Include-Dateien
│   ├── controller/        # Legacy-Controller
│   ├── helper/            # Hilfsfunktionen
│   ├── model/             # Legacy-Model-Funktionen
│   └── pages/             # Seiten-Rendering-Funktionen
├── nix/                    # Nix-Build-Konfiguration
├── public/                 # Web-Root
│   ├── assets/            # Statische Assets
│   └── index.php          # Anwendungs-Einstiegspunkt
├── resources/              # Ressourcen
│   ├── api/               # OpenAPI-Spezifikation
│   ├── assets/            # Quell-Assets (JS/SCSS)
│   ├── lang/              # Übersetzungen (gettext)
│   └── views/             # Twig-Templates
├── src/                    # PHP-Quellcode
│   ├── Config/            # Konfigurationshandling
│   ├── Controllers/       # HTTP-Controller
│   ├── Events/            # Event-Klassen
│   ├── Exceptions/        # Benutzerdefinierte Exceptions
│   ├── Factories/         # Factory-Klassen
│   ├── Helpers/           # Hilfsklassen
│   ├── Http/              # HTTP-Handling
│   ├── Mail/              # E-Mail-Handling
│   ├── Middleware/        # PSR-15-Middleware
│   ├── Models/            # Eloquent-Models
│   ├── Renderer/          # Template-Rendering
│   └── Services/          # Service-Klassen
├── storage/               # Laufzeit-Speicher
│   └── logs/              # Anwendungs-Logs
└── tests/                 # Test-Suites
    ├── Feature/           # Integrationstests
    └── Unit/              # Unit-Tests
```

## Service Provider-Architektur

Die Anwendung verwendet ein Service Provider-Pattern für Dependency Injection. Provider werden in `config/app.php` konfiguriert:

```php
'providers' => [
    LoggerServiceProvider::class,
    ExceptionServiceProvider::class,
    ConfigServiceProvider::class,
    DatabaseServiceProvider::class,
    SessionServiceProvider::class,
    AuthServiceProvider::class,
    TranslationServiceProvider::class,
    RendererServiceProvider::class,
    RouterServiceProvider::class,
    MailerServiceProvider::class,
    EventsServiceProvider::class,
    // ... und mehr
],
```

Jeder Provider:

1. Registriert Services im DI-Container
2. Bootet optional nachdem alle Provider registriert sind
3. Kann von anderen Providern abhängen

## Middleware-Stack

Die Anfrageverarbeitung durchläuft PSR-15-Middleware in dieser Reihenfolge:

| Reihenfolge | Middleware | Zweck |
|-------------|------------|-------|
| 1 | SendResponseHandler | Sendet finale Response an Client |
| 2 | ExceptionHandler | Fängt und behandelt Exceptions |
| 3 | SetLocale | Setzt bevorzugte Sprache des Benutzers |
| 4 | AddHeaders | Fügt Security-Header hinzu |
| 5 | SessionHandler | Verwaltet Session |
| 6 | Authenticator | Authentifiziert Benutzer |
| 7 | VerifyCsrfToken | CSRF-Schutz |
| 8 | RouteDispatcher | Leitet zu Controller |

## Event-System

Das Engelsystem verwendet eine event-gesteuerte Architektur für bestimmte Operationen:

```php
'event-handlers' => [
    'message.created' => [...],
    'news.created' => [...],
    'oauth2.login' => [...],
    'shift.entry.deleting' => [...],
],
```

Events werden über das Event-System dispatched und von registrierten Listenern behandelt.

## Models

Alle Models erweitern `BaseModel`, das Eloquents `Model` erweitert:

```php
namespace Engelsystem\Models;

abstract class BaseModel extends Model
{
    protected $connection = 'default';
    public $timestamps = false;
}
```

Wichtige Models umfassen:

- `User` - Benutzerkonten und Profile
- `Shift` - Geplante Arbeitsschichten
- `AngelType` - Kategorien von Freiwilligenarbeit
- `Location` - Physische Orte
- `ShiftEntry` - Benutzeranmeldungen für Schichten

Für Datenbank-Schema-Details siehe [Datenbank](database/).

## Legacy-Code

Das `includes/`-Verzeichnis enthält Legacy-Code von vor dem Refactoring. Neue Entwicklung sollte die moderne Architektur in `src/` verwenden. Die `LegacyMiddleware` behandelt das Routing zu alten Seiten, die noch nicht migriert wurden.

