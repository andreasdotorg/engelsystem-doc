---
title: "Engeltypen"
weight: 20
---

Engeltypen definieren die Kategorien von Freiwilligenarbeit bei deinem Event. Bürokraten können Engeltypen erstellen, bearbeiten und konfigurieren, um sie an die Bedürfnisse deines Events anzupassen.

## Was Engeltypen repräsentieren

Jeder Engeltyp ist eine Kategorie von Arbeit, für die sich Freiwillige anmelden können:

- **Bar** - Getränke ausschenken
- **Security** - Zugangskontrolle
- **Info Desk** - Fragen beantworten
- **Tech Support** - Technische Unterstützung
- **Transport** - Equipment bewegen

Dein Event wird seine eigenen Engeltypen haben, basierend auf der anfallenden Arbeit.

## Einen Engeltyp erstellen

Um einen neuen Engeltyp zu erstellen:

1. Navigiere zu **Admin > Engeltypen**
2. Klicke **Erstellen**
3. Konfiguriere die Einstellungen (siehe unten)
4. Speichern

### Grundeinstellungen

- **Name** - Der Anzeigename des Engeltyps
- **Beschreibung** - Was diese Arbeit beinhaltet (sichtbar für Freiwillige)
- **Eingeschränkt** - Ob der Beitritt Genehmigung erfordert

### Mitgliedschaftsoptionen

- **no_self_signup** - Wenn true, können Freiwillige nicht selbst beitreten; sie müssen von Supportern oder Koordinatoren hinzugefügt werden
- **requires_driver_license** - Nur Freiwillige mit Führerschein können beitreten
- **requires_ifsg_certificate** - Nur Freiwillige mit Lebensmittel-Zertifizierung können beitreten

### Anzeigeoptionen

- **show_on_dashboard** - Ob auf dem Haupt-Dashboard angezeigt werden soll
- **hide_register** - Bei der Registrierung aus der Engeltyp-Auswahl ausblenden

## Engeltypen bearbeiten

Um einen bestehenden Engeltyp zu ändern:

1. Navigiere zu **Admin > Engeltypen**
2. Finde den Engeltyp
3. Klicke auf Bearbeiten
4. Nimm Änderungen vor
5. Speichern

{{% notice warning %}}
Das Ändern von Einschränkungen bei einem bestehenden Engeltyp entfernt keine vorhandenen Mitglieder, die die neuen Kriterien nicht erfüllen. Überprüfe die Mitgliedschaft nach dem Ändern von Anforderungen.
{{% /notice %}}

## Eingeschränkte vs Offene Engeltypen

### Offene Engeltypen
- Jeder kann sofort beitreten
- Gut für Arbeit, die keine speziellen Fähigkeiten erfordert
- Beispiele: Aufbau, Abbau, Allgemeine Hilfe

### Eingeschränkte Engeltypen
- Beitritt erfordert Genehmigung von einem Supporter
- Gut für spezialisierte oder sensible Arbeit
- Beispiele: Security, Kassenhandling, Medizin

## Supporter für Engeltypen

Jeder Engeltyp kann Supporter haben - Teamleiter, die:
- Mitgliedschaftsanfragen genehmigen/ablehnen
- Mitglieder hinzufügen oder entfernen
- Teammitglieder für Schichten anmelden

Um Supporter zu verwalten:
1. Sieh den Engeltyp an
2. Finde ein Mitglied zum Befördern
3. Markiere sie als Supporter

Siehe das [Supporter-Handbuch]({{% relref "/supporter" %}}) für das, was Supporter tun können.

## Engeltypen löschen

Vor dem Löschen eines Engeltyps:
- Stelle sicher, dass keine zukünftigen Schichten ihn erfordern
- Bedenke, was mit bestehenden Mitgliedern passiert
- Prüfe, ob Freiwillige nur diesen Engeltyp haben

{{% notice warning %}}
Das Löschen eines Engeltyps kann die Schichtabdeckung und Freiwilligen-Berechtigung beeinflussen. Plane sorgfältig.
{{% /notice %}}
