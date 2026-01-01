---
title: "Entwicklung"
date: 2024-04-08T22:10:00+02:00
weight: 60
---

Dieser Abschnitt bietet technische Dokumentation für Entwickler*innen, die Engelsystem verstehen, erweitern oder dazu beitragen möchten. Egal ob du einen Bug behebst, ein Feature hinzufügst oder mit externen Systemen integrierst - du findest hier den architektonischen Kontext und die Patterns, die du brauchst.

## Schnellstart für Beitragende

Bevor du in die Codebasis eintauchst:

1. Lies die [DEVELOPMENT.md](https://github.com/engelsystem/engelsystem/blob/main/DEVELOPMENT.md)-Datei im Repository für das Einrichten der Umgebung
2. Sieh dir [CONTRIBUTING.md](https://github.com/engelsystem/engelsystem/blob/main/CONTRIBUTING.md) für Code-Style und Einreichungsrichtlinien an
3. Richte eine lokale Entwicklungsumgebung mit Docker oder traditionellem PHP ein
4. Führe die Test-Suite aus, um zu verifizieren, dass dein Setup funktioniert

### Entwicklungsumgebung

Das empfohlene Setup verwendet Docker:

```bash
git clone https://github.com/engelsystem/engelsystem.git
cd engelsystem
docker-compose -f docker/docker-compose.yml up -d
```

Oder für traditionelle Entwicklung:

```bash
composer install
yarn install
cp config/config.default.php config/config.php
# Datenbank in config.php konfigurieren
./bin/migrate
yarn build
php -S localhost:5080 -t public/
```

### Tests ausführen

```bash
# PHP-Tests
vendor/bin/phpunit

# Code-Style-Prüfung
vendor/bin/phpcs

# Statische Analyse
vendor/bin/phpstan analyze
```

## Dokumentation in diesem Abschnitt

Dieser Abschnitt behandelt die internen Abläufe von Engelsystem:

**[Architektur](architecture/)** erklärt die Anwendungsstruktur, einschließlich des Container-Systems, der Service-Provider und wie Komponenten miteinander verbunden sind. Beginne hier, wenn du neu in der Codebasis bist.

**[Request-Lebenszyklus](request-lifecycle/)** führt durch, wie HTTP-Anfragen verarbeitet werden, vom initialen Routing über Middleware bis zur Controller-Antwort. Essenzielle Lektüre für das Hinzufügen neuer Endpunkte.

**[Datenbank](database/)** dokumentiert das Schema, Eloquent-Models und das Migrationssystem. Behandelt Beziehungen zwischen Entitäten und Query-Patterns.

**[CI/CD-Pipeline](ci-cd/)** beschreibt die GitLab-CI-Konfiguration, einschließlich Testing-Stufen, Docker-Image-Erstellung und Deployment-Automatisierung.

## Design-Philosophie

Engelsystems Architektur ist von Laravel inspiriert und verwendet mehrere Laravel-Komponenten (Illuminate-Pakete), bleibt dabei aber eine eigenständige Anwendung. Schlüsselprinzipien:

**Convention over Configuration** - Standardpatterns für Controller, Models und Services reduzieren Boilerplate und machen die Codebasis vorhersehbar.

**Dependency Injection** - Der Container verwaltet Objekterstellung und Abhängigkeiten, was Code testbar und lose gekoppelt macht.

**Datenbankabstraktion** - Eloquent ORM bietet eine saubere API für Datenbankoperationen und erlaubt bei Bedarf rohe Queries.

**Minimale externe Abhängigkeiten** - Abhängigkeiten werden sorgfältig gewählt und müssen aktiv gewartet werden. Wir vermeiden große Frameworks zugunsten fokussierter Bibliotheken.

## Tech-Stack

| Komponente | Technologie |
|------------|-------------|
| Sprache | PHP 8.2+ |
| Framework | Custom (Laravel-inspiriert) |
| ORM | Eloquent (illuminate/database) |
| Templating | Twig |
| Datenbank | MySQL 5.7+ / MariaDB 10.2+ |
| Frontend | Bootstrap 5, Vanilla JS |
| Build | Webpack, Yarn |
| Testing | PHPUnit |
| CI/CD | GitLab CI |

## Code-Organisation

Die Codebasis folgt einer Standard-MVC-ähnlichen Struktur:

```
engelsystem/
├── config/              # Konfigurationsdateien
├── db/
│   ├── factories/       # Model-Factories für Tests
│   └── migrations/      # Datenbank-Migrationen
├── public/              # Web-Root (index.php, Assets)
├── resources/
│   ├── assets/          # Quell-CSS/JS
│   ├── lang/            # Übersetzungen (PO-Dateien)
│   └── views/           # Twig-Templates
├── src/
│   ├── Controllers/     # HTTP-Controller
│   ├── Helpers/         # Utility-Klassen
│   ├── Http/            # Request/Response-Klassen
│   ├── Middleware/      # Request-Middleware
│   ├── Models/          # Eloquent-Models
│   └── Renderer/        # View-Rendering
├── storage/             # Logs, Cache (beschreibbar)
└── tests/               # PHPUnit-Tests
```

## Schlüsselkonzepte

### Service-Container

Engelsystem verwendet einen Dependency-Injection-Container (ähnlich dem von Laravel). Services werden in Providern registriert und automatisch aufgelöst:

```php
// Service registrieren
$app->instance(MyService::class, new MyService($dependency));

// Auflösen (automatisch in Konstruktoren)
public function __construct(MyService $service) { }
```

### Middleware

HTTP-Anfragen durchlaufen Middleware bevor sie Controller erreichen. Gängige Middleware handhabt Authentifizierung, CSRF-Schutz und Session-Management.

### Models

Eloquent-Models repräsentieren Datenbanktabellen. Sie definieren Beziehungen, Scopes und Geschäftslogik:

```php
class Shift extends BaseModel
{
    public function shiftEntries(): HasMany
    {
        return $this->hasMany(ShiftEntry::class);
    }
}
```

### Controller

Controller handhaben HTTP-Anfragen und geben Responses zurück:

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

## Release-Zyklus

Engelsystem folgt einem Event-gesteuerten Release-Zeitplan:

- **Main-Branch** - Immer deploybar, enthält neueste Features
- **Getaggte Releases** - Werden nach großen CCC-Events erstellt (mindestens jährlich)
- **Hotfixes** - Kritische Sicherheits- oder Bug-Fixes nach Bedarf

Das Release-Timing richtet sich nach großen Freiwilligen-Events wie dem Chaos Communication Congress, um sicherzustellen, dass die Software vor jedem Release im großen Maßstab getestet wurde.

## Hilfe bekommen

- **GitHub Issues** - Bug-Reports und Feature-Requests: [engelsystem/engelsystem/issues](https://github.com/engelsystem/engelsystem/issues)
- **Quellcode** - Implementierung durchsuchen: [github.com/engelsystem/engelsystem](https://github.com/engelsystem/engelsystem)
- **Community** - An CCC-Freiwilligen-Community-Diskussionen teilnehmen

## Beitragen

Beiträge sind willkommen! Der allgemeine Prozess:

1. **Forke** das Repository
2. **Erstelle einen Branch** für dein Feature oder Fix
3. **Schreibe Tests** für neue Funktionalität
4. **Folge dem Code-Style** - führe `phpcs` und `phpstan` aus
5. **Erstelle einen Pull Request** mit einer klaren Beschreibung

Für größere Änderungen eröffne zuerst ein Issue, um den Ansatz zu diskutieren. Das hilft doppelte Arbeit zu vermeiden und stellt sicher, dass dein Beitrag zur Projektrichtung passt.
