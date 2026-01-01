---
title: "Benutzer-Zertifikate"
weight: 60
---

Shift Coordinators können Freiwilligen-Zertifizierungen und Qualifikationen anzeigen und verwalten, die die Schichtberechtigung beeinflussen.

## Erforderliche Privilegien

Verschiedene Zertifikate erfordern verschiedene Privilegien:

| Zertifikat | Anzeigen | Bearbeiten |
|------------|----------|------------|
| IFSG (Lebensmittel) | `user.info.view` | `user.ifsg.edit` |
| Führerschein | `user.info.view` | `user.drive.edit` |
| Erste Hilfe | `user.info.view` | `user.fa.edit`* |
| Frei-von/Ernährung | `user.info.view` | `user.ff.edit` |

*Erste-Hilfe-Bearbeitung erfordert Bureaucrat-Privilegien

## IFSG-Zertifikat

Das Infektionsschutzgesetz erfordert eine Zertifizierung für den Umgang mit Lebensmitteln.

### Was es bedeutet
- Freiwillige mit IFSG-Zertifizierung können lebensmittelbezogene Schichten arbeiten
- Das Zertifikat bestätigt, dass sie über Lebensmittelhygiene-Anforderungen belehrt wurden

### IFSG-Status verwalten
1. Navigiere zum Profil des Benutzers
2. Finde den IFSG-Bereich
3. Aktualisiere ihren Zertifizierungsstatus
4. Speichern

## Führerschein

Erfasse, wer für das Event fahren kann.

### Fahrer-Informationen
- Führerschein-Status (hat Führerschein oder nicht)
- Fahrzeugverfügbarkeit
- Fahrzeugtyp (Auto, Van, LKW)

### Warum es wichtig ist
- Manche Schichten erfordern Fahrer
- Nützlich für Logistik und Transportplanung
- Hilft bei Notfall-Koordination

## Erste Hilfe

Erfasse Erste-Hilfe-Zertifizierungen für sicherheitsrelevante Positionen.

{{% notice note %}}
Bearbeitung der Erste-Hilfe-Zertifizierung erfordert Bureaucrat-Privilegien (`user.fa.edit`). Shift Coordinators können anzeigen, aber nicht bearbeiten.
{{% /notice %}}

## Frei-von / Ernährung

Erfasse Ernährungseinschränkungen und Allergien für Mahlzeitenplanung und Essensverteilung.

### Häufige Verwendungen
- Sicherstellen geeigneter Essensoptionen bei Mahlzeiten
- Allergene in Zubereitungsbereichen vermeiden
- Catering-Mengen planen

## Zertifikatsstatus anzeigen

Um die Zertifizierungen eines Freiwilligen zu prüfen:

1. Navigiere zu ihrem Profil
2. Sieh den Zertifizierungsbereich an
3. Prüfe jeden relevanten Zertifizierungsstatus

## Massenaktualisierungen

Für Events mit vielen Freiwilligen, die Zertifizierungsaktualisierungen benötigen:
- Nutze die Benutzerverwaltungs-Oberfläche für Batch-Operationen
- Erwäge dedizierte Belehrungssitzungen, bei denen Zertifizierungen bestätigt werden können

## Verwandte Themen

- [Benutzerhandbuch - Profil]({{% relref "/user/profile" %}}) - Wie Freiwillige ihre eigenen Infos verwalten
- [Rollenverwaltung]({{% relref "/admin/role_management" %}}) - Berechtigungsdetails
