---
title: "Development"
date: 2024-04-08T22:10:00+02:00
weight: 60
---

This section provides technical documentation for developers who want to understand, extend, or contribute to Engelsystem. Whether you're fixing a bug, adding a feature, or integrating with external systems, you'll find the architectural context and patterns you need here.

## Quick Start for Contributors

Before diving into the codebase:

1. Read the [DEVELOPMENT.md](https://github.com/engelsystem/engelsystem/blob/main/DEVELOPMENT.md) file in the repository for environment setup
2. Review [CONTRIBUTING.md](https://github.com/engelsystem/engelsystem/blob/main/CONTRIBUTING.md) for code style and submission guidelines
3. Set up a local development environment with Docker or traditional PHP
4. Run the test suite to verify your setup works

### Development Environment

The recommended setup uses Docker:

```bash
git clone https://github.com/engelsystem/engelsystem.git
cd engelsystem
docker-compose -f docker/docker-compose.yml up -d
```

Or for traditional development:

```bash
composer install
yarn install
cp config/config.default.php config/config.php
# Configure database in config.php
./bin/migrate
yarn build
php -S localhost:5080 -t public/
```

### Running Tests

```bash
# PHP tests
vendor/bin/phpunit

# Code style check
vendor/bin/phpcs

# Static analysis
vendor/bin/phpstan analyze
```

## Documentation in This Section

This section covers the internal workings of Engelsystem:

**[Architecture](architecture/)** explains the application structure, including the container system, service providers, and how components are wired together. Start here if you're new to the codebase.

**[Request Lifecycle](request-lifecycle/)** walks through how HTTP requests are processed, from initial routing through middleware to controller response. Essential reading for adding new endpoints.

**[Database](database/)** documents the schema, Eloquent models, and migration system. Covers relationships between entities and query patterns.

**[CI/CD Pipeline](ci-cd/)** describes the GitLab CI configuration, including testing stages, Docker image building, and deployment automation.

## Design Philosophy

Engelsystem's architecture is inspired by Laravel and uses several Laravel components (Illuminate packages) while remaining a standalone application. Key principles:

**Convention over configuration** - Standard patterns for controllers, models, and services reduce boilerplate and make the codebase predictable.

**Dependency injection** - The container manages object creation and dependencies, making code testable and loosely coupled.

**Database abstraction** - Eloquent ORM provides a clean API for database operations while allowing raw queries when needed.

**Minimal external dependencies** - Dependencies are chosen carefully and must be actively maintained. We avoid large frameworks in favor of focused libraries.

## Tech Stack

| Component | Technology |
|-----------|------------|
| Language | PHP 8.2+ |
| Framework | Custom (Laravel-inspired) |
| ORM | Eloquent (illuminate/database) |
| Templating | Twig |
| Database | MySQL 5.7+ / MariaDB 10.2+ |
| Frontend | Bootstrap 5, Vanilla JS |
| Build | Webpack, Yarn |
| Testing | PHPUnit |
| CI/CD | GitLab CI |

## Code Organization

The codebase follows a standard MVC-ish structure:

```
engelsystem/
├── config/              # Configuration files
├── db/
│   ├── factories/       # Model factories for testing
│   └── migrations/      # Database migrations
├── public/              # Web root (index.php, assets)
├── resources/
│   ├── assets/          # Source CSS/JS
│   ├── lang/            # Translations (PO files)
│   └── views/           # Twig templates
├── src/
│   ├── Controllers/     # HTTP controllers
│   ├── Helpers/         # Utility classes
│   ├── Http/            # Request/Response classes
│   ├── Middleware/      # Request middleware
│   ├── Models/          # Eloquent models
│   └── Renderer/        # View rendering
├── storage/             # Logs, cache (writable)
└── tests/               # PHPUnit tests
```

## Key Concepts

### Service Container

Engelsystem uses a dependency injection container (similar to Laravel's). Services are registered in providers and resolved automatically:

```php
// Registering a service
$app->instance(MyService::class, new MyService($dependency));

// Resolving (automatic in constructors)
public function __construct(MyService $service) { }
```

### Middleware

HTTP requests pass through middleware before reaching controllers. Common middleware handles authentication, CSRF protection, and session management.

### Models

Eloquent models represent database tables. They define relationships, scopes, and business logic:

```php
class Shift extends BaseModel
{
    public function shiftEntries(): HasMany
    {
        return $this->hasMany(ShiftEntry::class);
    }
}
```

### Controllers

Controllers handle HTTP requests and return responses:

```php
class ShiftController extends BaseController
{
    public function index(): Response
    {
        $shifts = Shift::query()->upcoming()->get();
        return $this->response->withView('shifts/index', ['shifts' => $shifts]);
    }
}
```

## Release Cycle

Engelsystem follows an event-driven release schedule:

- **Main branch** - Always deployable, contains latest features
- **Tagged releases** - Created after major CCC events (at least annually)
- **Hotfixes** - Critical security or bug fixes as needed

The release timing aligns with large volunteer events like the Chaos Communication Congress, ensuring the software is battle-tested at scale before each release.

## Getting Help

- **GitHub Issues** - Bug reports and feature requests: [engelsystem/engelsystem/issues](https://github.com/engelsystem/engelsystem/issues)
- **Source Code** - Browse the implementation: [github.com/engelsystem/engelsystem](https://github.com/engelsystem/engelsystem)
- **Community** - Join the CCC volunteer community discussions

## Contributing

Contributions are welcome! The general process:

1. **Fork** the repository
2. **Create a branch** for your feature or fix
3. **Write tests** for new functionality
4. **Follow code style** - run `phpcs` and `phpstan`
5. **Submit a pull request** with a clear description

For larger changes, open an issue first to discuss the approach. This helps avoid duplicate work and ensures your contribution aligns with project direction.
