---
title: "Architecture"
weight: 10
---

# Architecture

This page provides an overview of Engelsystem's technical architecture for developers.

## Tech Stack

### Backend

| Component | Technology | Version |
|-----------|------------|---------|
| Language | PHP | >= 8.2 |
| Container | Custom DI Container | - |
| ORM | Eloquent (illuminate/database) | ^12.x |
| Routing | FastRoute (nikic/fast-route) | ^1.3 |
| Templating | Twig | ^3.x |
| HTTP | PSR-7 (nyholm/psr7) | ^1.8 |
| Validation | respect/validation | ^2.3 |
| Markdown | erusev/parsedown | ^1.7 |
| Calendar | eluceo/ical | ^2.x |

### Frontend

| Component | Technology | Version |
|-----------|------------|---------|
| CSS Framework | Bootstrap | ^5.3 |
| Build Tool | Webpack | ^5.x |
| JS/TS | TypeScript | ^5.x |
| Icons | Bootstrap Icons | ^1.11 |
| Charts | Chart.js | ^4.x |

### Infrastructure

| Component | Technology |
|-----------|------------|
| Database | MySQL/MariaDB |
| Package Manager | Composer (PHP), Yarn (JS) |
| Build System | Nix Flake |
| CI/CD | GitLab CI |
| Containerization | Docker/Kubernetes |

## Directory Structure

```
engelsystem/
├── bin/                    # CLI scripts
│   └── migrate             # Database migration runner
├── config/                 # Configuration files
│   ├── app.php            # Service providers, middleware, routes
│   ├── config.default.php # Default configuration values
│   └── routes.php         # Route definitions
├── db/                     # Database related
│   ├── factories/         # Eloquent model factories
│   └── migrations/        # Database migrations
├── docker/                 # Docker configuration
├── includes/               # Legacy include files
│   ├── controller/        # Legacy controllers
│   ├── helper/            # Helper functions
│   ├── model/             # Legacy model functions
│   └── pages/             # Page rendering functions
├── nix/                    # Nix build configuration
├── public/                 # Web root
│   ├── assets/            # Static assets
│   └── index.php          # Application entry point
├── resources/              # Resources
│   ├── api/               # OpenAPI specification
│   ├── assets/            # Source assets (JS/SCSS)
│   ├── lang/              # Translations (gettext)
│   └── views/             # Twig templates
├── src/                    # PHP source code
│   ├── Config/            # Configuration handling
│   ├── Controllers/       # HTTP controllers
│   ├── Events/            # Event classes
│   ├── Exceptions/        # Custom exceptions
│   ├── Factories/         # Factory classes
│   ├── Helpers/           # Helper classes
│   ├── Http/              # HTTP handling
│   ├── Mail/              # Email handling
│   ├── Middleware/        # PSR-15 middleware
│   ├── Models/            # Eloquent models
│   ├── Renderer/          # Template rendering
│   └── Services/          # Service classes
├── storage/               # Runtime storage
│   └── logs/              # Application logs
└── tests/                 # Test suites
    ├── Feature/           # Integration tests
    └── Unit/              # Unit tests
```

## Service Provider Architecture

The application uses a service provider pattern for dependency injection. Providers are configured in `config/app.php`:

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
    // ... and more
],
```

Each provider:

1. Registers services in the DI container
2. Optionally boots after all providers are registered
3. Can depend on other providers

## Middleware Stack

Request processing flows through PSR-15 middleware in order:

| Order | Middleware | Purpose |
|-------|-----------|---------|
| 1 | SendResponseHandler | Sends final response to client |
| 2 | ExceptionHandler | Catches and handles exceptions |
| 3 | SetLocale | Sets user's preferred language |
| 4 | AddHeaders | Adds security headers |
| 5 | SessionHandler | Manages session |
| 6 | Authenticator | Authenticates user |
| 7 | VerifyCsrfToken | CSRF protection |
| 8 | RouteDispatcher | Routes to controller |

## Event System

Engelsystem uses an event-driven architecture for certain operations:

```php
'event-handlers' => [
    'message.created' => [...],
    'news.created' => [...],
    'oauth2.login' => [...],
    'shift.entry.deleting' => [...],
],
```

Events are dispatched through the event system and handled by registered listeners.

## Models

All models extend `BaseModel` which extends Eloquent's `Model`:

```php
namespace Engelsystem\Models;

abstract class BaseModel extends Model
{
    protected $connection = 'default';
    public $timestamps = false;
}
```

Key models include:

- `User` - User accounts and profiles
- `Shift` - Scheduled work shifts
- `AngelType` - Categories of volunteer work
- `Location` - Physical locations
- `ShiftEntry` - User signups for shifts

For database schema details, see [Database](database/).

## Legacy Code

The `includes/` directory contains legacy code from before the refactoring. New development should use the modern architecture in `src/`. The `LegacyMiddleware` handles routing to old pages that haven't been migrated yet.
