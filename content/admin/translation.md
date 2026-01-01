---
title: "Translation"
date: 2023-03-05T13:37:00+01:00
weight: 80
---

Engelsystem supports multiple languages through the gettext translation system. Out of the box, it includes German (`de_DE`) and English (`en_US`). You can customize existing translations, add event-specific terminology, or contribute entirely new languages.

## How Translations Work

Engelsystem uses the standard gettext system with PO (Portable Object) files. The workflow is:

1. Source code contains English strings wrapped in translation functions like `__('Welcome')`
2. These strings are extracted to a POT (template) file
3. Translators create PO files for each language with translations
4. PO files are compiled to binary MO files for runtime use

Translation files live in `resources/lang/`:

```
resources/lang/
├── de_DE/
│   ├── default.po      # German translations
│   └── default.mo      # Compiled German translations
├── en_US/
│   ├── default.po      # English (source)
│   └── default.mo      # Compiled English
└── default.pot         # Template with all translatable strings
```

## Overriding Translations

The most common customization is overriding specific strings to match your event's terminology. For example, replacing "Angel" with "Volunteer" or "Helper".

### Creating a Custom Override File

Create a `custom.po` file in your configuration directory:

```bash
mkdir -p config/lang/en_US
touch config/lang/en_US/custom.po
```

Add your overrides to this file:

```po
# config/lang/en_US/custom.po
msgid ""
msgstr ""
"Content-Type: text/plain; charset=UTF-8\n"

# Override "Angel" with "Helper"
msgid "Angel"
msgstr "Helper"

msgid "Angels"
msgstr "Helpers"

# Override "Engelsystem" branding
msgid "Engelsystem"
msgstr "VolunteerHub"
```

The `msgid` is the original English string, and `msgstr` is your replacement.

### Common Overrides

Here are frequently customized strings:

| Original | Common Alternatives |
|----------|---------------------|
| Angel | Helper, Volunteer, Crew |
| Engelsystem | [Event]System, VolunteerHub |
| T-Shirt | Merch, Goodie, Swag |
| Shift | Session, Slot, Assignment |
| Heaven | HQ, Volunteer Office |

### Override File Locations

Custom translations are loaded from `config/lang/{locale}/custom.po`:

```
config/lang/
├── de_DE/
│   └── custom.po    # German overrides
├── en_US/
│   └── custom.po    # English overrides
└── fr_FR/
    └── custom.po    # French overrides (if you add French support)
```

Engelsystem merges these with the default translations, so you only need to include strings you want to change.

## Using the Translation Mapper

For more complex transformations or runtime string replacement, you can implement a custom Translation Mapper. This approach is useful when:

- You need dynamic replacements based on context
- You want to apply transformations programmatically
- Simple PO overrides aren't flexible enough

See the [Translation Mapper implementation](https://github.com/MyIgel/engelsystem/commit/0a5c629deaacbb10d11673918c3579a8c867a695) for a reference implementation.

## Adding a New Language

To add support for a completely new language:

### 1. Create Language Directory

```bash
mkdir -p resources/lang/fr_FR
```

### 2. Copy the Template

```bash
cp resources/lang/default.pot resources/lang/fr_FR/default.po
```

### 3. Translate Strings

Edit `default.po` and translate each string. The file structure is:

```po
# Comment about context
#: src/Controllers/HomeController.php:42
msgid "Welcome to %s"
msgstr "Bienvenue sur %s"

#: src/Controllers/ShiftController.php:15
msgid "Available Shifts"
msgstr "Quarts disponibles"
```

Tips for translating:
- Keep placeholders like `%s` and `%d` in the same positions
- Maintain HTML formatting if present
- Preserve line breaks in multi-line strings

### 4. Compile the PO File

Convert to binary MO format:

```bash
msgfmt resources/lang/fr_FR/default.po -o resources/lang/fr_FR/default.mo
```

### 5. Register the Language

Add your language to `config/config.php`:

```php
'locales' => [
    'de_DE.UTF-8' => 'Deutsch',
    'en_US.UTF-8' => 'English',
    'fr_FR.UTF-8' => 'Français',
],
```

### 6. Verify System Locale

The server must have the locale installed:

```bash
# Check available locales
locale -a | grep fr_FR

# Install if missing (Debian/Ubuntu)
sudo apt-get install language-pack-fr
sudo locale-gen fr_FR.UTF-8
```

## Working with PO Files

### Tools

Several tools make PO file editing easier:

| Tool | Description |
|------|-------------|
| [Poedit](https://poedit.net/) | Cross-platform GUI editor (recommended) |
| [Lokalize](https://kde.org/applications/office/lokalize) | KDE translation tool |
| [gtranslator](https://wiki.gnome.org/Apps/Gtranslator) | GNOME translation editor |
| Any text editor | PO files are plain text |

### PO File Format

A PO file consists of entries with this structure:

```po
# Translator comment
#. Extracted comment from source
#: file.php:line
#, flags (e.g., fuzzy, php-format)
msgctxt "context"
msgid "Original string"
msgstr "Translated string"
```

**Important fields:**
- `msgid` - The original (usually English) string
- `msgstr` - Your translation
- `#:` - Reference to where the string appears in source code
- `#, fuzzy` - Marks uncertain translations needing review

### Plural Forms

Some strings have plural variants:

```po
msgid "You have %d shift"
msgid_plural "You have %d shifts"
msgstr[0] "Du hast %d Schicht"
msgstr[1] "Du hast %d Schichten"
```

Different languages have different plural rules. The header specifies the formula:

```po
"Plural-Forms: nplurals=2; plural=(n != 1);\n"
```

## Testing Translations

### Local Testing

1. Make your changes to PO files
2. Compile to MO: `msgfmt input.po -o output.mo`
3. Clear any cache: `rm -rf storage/cache/*`
4. Refresh the application

### Verify Coverage

Check for untranslated strings:

```bash
# Find empty translations
grep -A1 'msgid "' resources/lang/de_DE/default.po | grep 'msgstr ""$'
```

### Check for Errors

Validate PO file syntax:

```bash
msgfmt --check resources/lang/de_DE/default.po
```

## Contributing Translations

To contribute translations back to the project:

1. Fork the [Engelsystem repository](https://github.com/engelsystem/engelsystem)
2. Update or add translation files in `resources/lang/`
3. Run `msgfmt --check` to validate
4. Submit a pull request

Translation contributions help make Engelsystem accessible to more communities worldwide.

## Troubleshooting

### Translations not appearing

- Verify the MO file exists and is up to date
- Clear application cache
- Check locale is properly configured in `config.php`
- Verify server has the locale installed

### Character encoding issues

Ensure your PO file header includes:

```po
"Content-Type: text/plain; charset=UTF-8\n"
```

Save files with UTF-8 encoding without BOM.

### Missing locale on server

```bash
# List available locales
locale -a

# Generate missing locale
sudo locale-gen de_DE.UTF-8
sudo dpkg-reconfigure locales
```
