---
title: "Fahrplan-Import"
weight: 30
---

Das Engelsystem kann Veranstaltungsfahrpläne aus Frab oder Pretalx importieren, um automatisch Schichten basierend auf Vorträgen und Sessions zu erstellen. Dies verknüpft Freiwilligenschichten mit dem Veranstaltungsprogramm, sodass Engel sich für die Unterstützung bei bestimmten Vorträgen anmelden können.

## So funktioniert es

Externe Veranstaltungsmanagementsysteme wie Frab und Pretalx veröffentlichen Fahrpläne als XML-Feeds. Das Engelsystem ruft diese Feeds ab und erstellt Schichten für jedes Event, mit konfigurierbarer Zeit vor und nach dem geplanten Zeitpunkt.

Wenn zum Beispiel ein Vortrag um 14:00 Uhr beginnt und bis 15:00 Uhr läuft, könnte eine Schicht von 13:30 bis 15:15 Uhr erstellt werden, um Auf- und Abbau abzudecken.

## Konfiguration

### Einen Fahrplan hinzufügen

1. Navigiere zu **Admin > Fahrplan-Import**
2. Klicke auf **Fahrplan hinzufügen**
3. Gib die Fahrplan-Details ein

### Fahrplan-Eigenschaften

| Eigenschaft | Beschreibung |
|-------------|--------------|
| Name | Anzeigename für den Fahrplan |
| URL | XML-Feed-URL von Frab/Pretalx |
| Schichttyp | Standard-Schichttyp für importierte Schichten |
| Minuten vorher | Wie lange vor Events Schichten beginnen sollen |
| Minuten nachher | Wie lange nach Events Schichten enden sollen |

### Engeltyp-Anforderungen

Konfiguriere welche Engeltypen für importierte Schichten benötigt werden:

**Vom Schichttyp.** Verwende die Standard-Anforderungen die auf dem Schichttyp definiert sind. Alle importierten Schichten erhalten die gleichen Anforderungen.

**Benutzerdefiniert.** Definiere spezifische Anforderungen für die Schichten dieses Fahrplans.

## Import ausführen

### Manueller Import

1. Navigiere zu **Admin > Fahrplan-Import**
2. Wähle den Fahrplan aus
3. Klicke auf **Importieren**
4. Prüfe erstellte/aktualisierte Schichten

### Automatische Updates

Fahrpläne können neu importiert werden um Änderungen zu übernehmen. Beim Neu-Import:

- Neue Events erstellen neue Schichten
- Geänderte Events aktualisieren bestehende Schichten
- Entfernte Events behalten ihre Schichten (manuelles Löschen erforderlich)

## Schicht-Eigenschaften aus Import

Importierte Schichten erben Eigenschaften vom Fahrplan-Event:

| Schicht-Eigenschaft | Quelle |
|--------------------|--------|
| Titel | Event-Titel |
| Beschreibung | Event-Beschreibung/Abstract |
| Start/Ende | Event-Zeit ± konfigurierte Minuten |
| Ort | Erfordert manuelle Zuordnung oder Ort-Matching |
| URL | Link zu Event-Details im Fahrplan |

## Ort-Zuordnung

Frab/Pretalx-Räume müssen auf Orte im Engelsystem gemappt werden. Optionen:

**Automatisches Matching.** Wenn Ortnamen exakt übereinstimmen, werden sie automatisch verknüpft.

**Manuelle Konfiguration.** Erstelle Orte im Engelsystem, die zu den Raumnamen des Fahrplans passen.

**Orte ignorieren.** Weise alle Schichten einem einzelnen Ort zu.

## Importierte Schichten verwalten

Importierte Schichten sind mit ihrem Fahrplan verknüpft. Du kannst:

- Schichtdetails bearbeiten (Änderungen bleiben bei Neu-Imports erhalten)
- Engeltyp-Anforderungen hinzufügen oder entfernen
- Einzelne Schichten löschen

Das Löschen eines Fahrplans entfernt die Verknüpfung, löscht aber nicht die Schichten.

## Häufige Workflows

### Initiales Event-Setup

1. Erstelle Orte passend zu deinem Veranstaltungsort
2. Erstelle Schichttypen für verschiedene Arbeiten
3. Füge die Fahrplan-URL hinzu
4. Konfiguriere Timing (Minuten vorher/nachher)
5. Führe initialen Import durch
6. Prüfe und passe Schichten nach Bedarf an

### Laufende Updates

1. Importiere neu wenn sich der externe Fahrplan ändert
2. Prüfe auf neue Schichten
3. Verifiziere Engeltyp-Anforderungen
4. Benachrichtige Engel bei signifikanten Änderungen

{{% notice note %}}
Fahrplan-URLs müssen von deinem Server erreichbar sein. Wenn der Fahrplan hinter einer Authentifizierung liegt, musst du möglicherweise eine öffentliche URL verwenden oder Zugang konfigurieren.
{{% /notice %}}

## Fehlerbehebung

**Import findet keine Events.** Prüfe ob die URL korrekt und erreichbar ist. Verifiziere dass das XML-Format der Frab/Pretalx-Spezifikation entspricht.

**Orte stimmen nicht überein.** Raumnamen im Fahrplan müssen exakt mit Ortnamen im Engelsystem übereinstimmen (oder manuell gemappt werden).

**Schichten haben falsche Zeiten.** Passe die Minuten vorher/nachher-Einstellungen des Fahrplans an.

