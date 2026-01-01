---
title: "Übersetzung"
date: 2023-03-05T13:37:00+01:00
weight: 80
---

Engelsystem unterstützt mehrere Sprachen durch das gettext-Übersetzungssystem. Standardmäßig sind Deutsch (`de_DE`) und Englisch (`en_US`) enthalten. Du kannst bestehende Übersetzungen anpassen, Event-spezifische Terminologie hinzufügen oder komplett neue Sprachen beisteuern.

## Wie Übersetzungen funktionieren

Engelsystem verwendet das Standard-gettext-System mit PO (Portable Object) Dateien. Der Workflow ist:

1. Der Quellcode enthält englische Strings in Übersetzungsfunktionen wie `__('Welcome')`
2. Diese Strings werden in eine POT (Template) Datei extrahiert
3. Übersetzer erstellen PO-Dateien für jede Sprache mit Übersetzungen
4. PO-Dateien werden zu binären MO-Dateien für die Laufzeit kompiliert

Übersetzungsdateien befinden sich in `resources/lang/`:

```
resources/lang/
├── de_DE/
│   ├── default.po      # Deutsche Übersetzungen
│   └── default.mo      # Kompilierte deutsche Übersetzungen
├── en_US/
│   ├── default.po      # Englisch (Quelle)
│   └── default.mo      # Kompiliertes Englisch
└── default.pot         # Template mit allen übersetzbaren Strings
```

## Übersetzungen überschreiben

Die häufigste Anpassung ist das Überschreiben bestimmter Strings, um sie an die Terminologie deines Events anzupassen. Zum Beispiel "Angel" durch "Volunteer" oder "Helper" ersetzen.

### Eigene Override-Datei erstellen

Erstelle eine `custom.po`-Datei in deinem Konfigurationsverzeichnis:

```bash
mkdir -p config/lang/en_US
touch config/lang/en_US/custom.po
```

Füge deine Überschreibungen in diese Datei ein:

```po
# config/lang/en_US/custom.po
msgid ""
msgstr ""
"Content-Type: text/plain; charset=UTF-8\n"

# "Angel" mit "Helper" überschreiben
msgid "Angel"
msgstr "Helper"

msgid "Angels"
msgstr "Helpers"

# "Engelsystem" Branding überschreiben
msgid "Engelsystem"
msgstr "VolunteerHub"
```

Die `msgid` ist der originale englische String, und `msgstr` ist dein Ersatz.

### Häufige Überschreibungen

Hier sind oft angepasste Strings:

| Original | Gängige Alternativen |
|----------|----------------------|
| Angel | Helper, Volunteer, Crew |
| Engelsystem | [Event]System, VolunteerHub |
| T-Shirt | Merch, Goodie, Swag |
| Shift | Session, Slot, Assignment |
| Heaven | HQ, Volunteer Office |

### Speicherorte für Override-Dateien

Eigene Übersetzungen werden aus `config/lang/{locale}/custom.po` geladen:

```
config/lang/
├── de_DE/
│   └── custom.po    # Deutsche Überschreibungen
├── en_US/
│   └── custom.po    # Englische Überschreibungen
└── fr_FR/
    └── custom.po    # Französische Überschreibungen (falls du Französisch hinzufügst)
```

Engelsystem führt diese mit den Standard-Übersetzungen zusammen, du musst also nur Strings einfügen, die du ändern möchtest.

## Den Translation Mapper verwenden

Für komplexere Transformationen oder String-Ersetzung zur Laufzeit kannst du einen eigenen Translation Mapper implementieren. Dieser Ansatz ist nützlich wenn:

- Du dynamische Ersetzungen basierend auf dem Kontext brauchst
- Du Transformationen programmatisch anwenden möchtest
- Einfache PO-Überschreibungen nicht flexibel genug sind

Siehe die [Translation Mapper Implementierung](https://github.com/MyIgel/engelsystem/commit/0a5c629deaacbb10d11673918c3579a8c867a695) für eine Referenzimplementierung.

## Neue Sprache hinzufügen

Um Unterstützung für eine komplett neue Sprache hinzuzufügen:

### 1. Sprachverzeichnis erstellen

```bash
mkdir -p resources/lang/fr_FR
```

### 2. Template kopieren

```bash
cp resources/lang/default.pot resources/lang/fr_FR/default.po
```

### 3. Strings übersetzen

Bearbeite `default.po` und übersetze jeden String. Die Dateistruktur ist:

```po
# Kommentar zum Kontext
#: src/Controllers/HomeController.php:42
msgid "Welcome to %s"
msgstr "Bienvenue sur %s"

#: src/Controllers/ShiftController.php:15
msgid "Available Shifts"
msgstr "Quarts disponibles"
```

Tipps zum Übersetzen:
- Behalte Platzhalter wie `%s` und `%d` an den gleichen Positionen
- Erhalte HTML-Formatierung falls vorhanden
- Bewahre Zeilenumbrüche in mehrzeiligen Strings

### 4. PO-Datei kompilieren

In binäres MO-Format konvertieren:

```bash
msgfmt resources/lang/fr_FR/default.po -o resources/lang/fr_FR/default.mo
```

### 5. Sprache registrieren

Füge deine Sprache zu `config/config.php` hinzu:

```php
'locales' => [
    'de_DE.UTF-8' => 'Deutsch',
    'en_US.UTF-8' => 'English',
    'fr_FR.UTF-8' => 'Français',
],
```

### 6. System-Locale überprüfen

Der Server muss die Locale installiert haben:

```bash
# Verfügbare Locales prüfen
locale -a | grep fr_FR

# Installieren falls fehlend (Debian/Ubuntu)
sudo apt-get install language-pack-fr
sudo locale-gen fr_FR.UTF-8
```

## Mit PO-Dateien arbeiten

### Tools

Mehrere Tools erleichtern die Bearbeitung von PO-Dateien:

| Tool | Beschreibung |
|------|--------------|
| [Poedit](https://poedit.net/) | Plattformübergreifender GUI-Editor (empfohlen) |
| [Lokalize](https://kde.org/applications/office/lokalize) | KDE-Übersetzungstool |
| [gtranslator](https://wiki.gnome.org/Apps/Gtranslator) | GNOME-Übersetzungseditor |
| Beliebiger Texteditor | PO-Dateien sind Klartext |

### PO-Dateiformat

Eine PO-Datei besteht aus Einträgen mit dieser Struktur:

```po
# Übersetzer-Kommentar
#. Extrahierter Kommentar aus dem Quellcode
#: datei.php:zeile
#, flags (z.B. fuzzy, php-format)
msgctxt "kontext"
msgid "Original-String"
msgstr "Übersetzter String"
```

**Wichtige Felder:**
- `msgid` - Der originale (meist englische) String
- `msgstr` - Deine Übersetzung
- `#:` - Referenz wo der String im Quellcode vorkommt
- `#, fuzzy` - Markiert unsichere Übersetzungen, die überprüft werden müssen

### Pluralformen

Einige Strings haben Plural-Varianten:

```po
msgid "You have %d shift"
msgid_plural "You have %d shifts"
msgstr[0] "Du hast %d Schicht"
msgstr[1] "Du hast %d Schichten"
```

Verschiedene Sprachen haben unterschiedliche Pluralregeln. Der Header gibt die Formel an:

```po
"Plural-Forms: nplurals=2; plural=(n != 1);\n"
```

## Übersetzungen testen

### Lokales Testen

1. Nimm deine Änderungen an PO-Dateien vor
2. Kompiliere zu MO: `msgfmt input.po -o output.mo`
3. Lösche den Cache: `rm -rf storage/cache/*`
4. Lade die Anwendung neu

### Abdeckung überprüfen

Nach nicht übersetzten Strings suchen:

```bash
# Leere Übersetzungen finden
grep -A1 'msgid "' resources/lang/de_DE/default.po | grep 'msgstr ""$'
```

### Auf Fehler prüfen

PO-Datei-Syntax validieren:

```bash
msgfmt --check resources/lang/de_DE/default.po
```

## Übersetzungen beisteuern

Um Übersetzungen zum Projekt beizusteuern:

1. Forke das [Engelsystem-Repository](https://github.com/engelsystem/engelsystem)
2. Aktualisiere oder füge Übersetzungsdateien in `resources/lang/` hinzu
3. Führe `msgfmt --check` zur Validierung aus
4. Erstelle einen Pull Request

Übersetzungsbeiträge helfen dabei, Engelsystem für mehr Communities weltweit zugänglich zu machen.

## Fehlerbehebung

### Übersetzungen erscheinen nicht

- Überprüfe ob die MO-Datei existiert und aktuell ist
- Lösche den Anwendungs-Cache
- Prüfe ob die Locale in `config.php` richtig konfiguriert ist
- Verifiziere dass der Server die Locale installiert hat

### Zeichenkodierungsprobleme

Stelle sicher, dass der Header deiner PO-Datei enthält:

```po
"Content-Type: text/plain; charset=UTF-8\n"
```

Speichere Dateien mit UTF-8-Kodierung ohne BOM.

### Fehlende Locale auf dem Server

```bash
# Verfügbare Locales auflisten
locale -a

# Fehlende Locale generieren
sudo locale-gen de_DE.UTF-8
sudo dpkg-reconfigure locales
```
