---
title: "Schichten verwalten"
weight: 10
---

Diese Seite behandelt das Erstellen, Bearbeiten und Organisieren von Schichten im Engelsystem.

## Schichten erstellen

### Manuelle Erstellung

Um einzelne Schichten zu erstellen:

1. Navigiere zu **Admin > Schichten**
2. Wähle Datum und Zeitraum für die Schicht
3. Wähle den Ort, an dem die Schicht stattfindet
4. Wähle einen Schichttyp, der zur Arbeit passt
5. Gib einen Titel und optional eine Beschreibung ein
6. Definiere, welche Engeltypen benötigt werden und wie viele von jedem
7. Speichere die Schicht

Die Schicht wird sofort verfügbar, damit sich Engel anmelden können (vorausgesetzt, sie haben die erforderlichen Engeltypen).

### Massenerstellung

Wenn du viele ähnliche Schichten brauchst, spart die Massenerstellung Zeit:

1. Navigiere zu **Admin > Schichten > Masse**
2. Definiere das Schichtmuster - Startzeiten, Dauer und welche Tage
3. Wähle einen oder mehrere Orte
4. Lege die Engeltyp-Anforderungen fest
5. Generiere alle Schichten auf einmal

Das ist nützlich für wiederkehrende Schichten wie Eingangsabdeckung, die jeden Tag dem gleichen Muster folgt.

### Zeitplan-Import

Für Veranstaltungen, die Frab oder Pretalx nutzen, kannst du Talks und Sessions automatisch als Schichten importieren. Das erstellt Schichten, die dem Veranstaltungsprogramm entsprechen, sodass sich Engel anmelden können, um bei bestimmten Talks zu helfen.

Siehe [Zeitplan-Import]({{% ref "/admin/schedule-import" %}}) im Administrations-Handbuch für Setup-Details.

## Schichteigenschaften

Jede Schicht hat diese Eigenschaften:

| Eigenschaft | Beschreibung |
|-------------|--------------|
| Titel | Anzeigename der Schicht |
| Beschreibung | Optionale Details zur Arbeit |
| Start/Ende | Wann die Schicht läuft |
| Ort | Wo die Schicht stattfindet |
| Schichttyp | Kategorie der Arbeit |
| URL | Optionaler Link zu mehr Informationen |

## Engeltyp-Anforderungen festlegen

Eine Schicht muss angeben, welche Engeltypen sie bearbeiten können und wie viele:

**Direkte Anforderungen.** Direkt auf der Schicht gesetzt. Am flexibelsten, erfordert aber das Setzen für jede Schicht einzeln.

**Orts-Standardwerte.** Auf dem Ort gesetzt. Alle Schichten an diesem Ort erben diese Anforderungen, sofern nicht überschrieben.

**Schichttyp-Standardwerte.** Auf dem Schichttyp gesetzt. Alle Schichten dieses Typs erben diese Anforderungen.

**Zeitplan-Import.** Importierte Schichten können Anforderungen von ihrer Zeitplan-Konfiguration erben.

Das System prüft Anforderungen in dieser Reihenfolge: schichtspezifisch zuerst, dann Ort, dann Schichttyp, dann Zeitplan.

## Nachtschichten

Schichten während der Nachtstunden erhalten Bonus-Multiplikatoren als Anerkennung für die Schwierigkeit, spät zu arbeiten. Standardmäßig sind Nachtstunden von 2:00 bis 6:00, und der Multiplikator ist 2x.

Eine Schicht zählt als Nachtschicht, wenn irgendein Teil davon in die Nachtstunden fällt.

Die Nachtschicht-Konfiguration wird von der Administration in der Systemkonfiguration festgelegt.

## Schichten bearbeiten

Um eine bestehende Schicht zu ändern:

1. Navigiere zur Detailseite der Schicht (klicke darauf in der Planansicht)
2. Klicke auf **Bearbeiten**
3. Nimm deine Änderungen vor
4. Speichere

Du kannst Engel-Anzahlen nicht unter die Anzahl bereits Angemeldeter reduzieren. Wenn du weniger Engel brauchst, musst du zuerst Anmeldungen entfernen.

## Schichten löschen

Bevor du eine Schicht löschst, bedenke die Auswirkungen auf Engel, die sich angemeldet haben. Wenn du eine Schicht löschst:

- Alle angemeldeten Engel werden aus der Schicht entfernt
- Engel erhalten eine Benachrichtigung, dass die Schicht abgesagt wurde
- Arbeitsstunden werden nicht gutgeschrieben (die Schicht fand nicht statt)

Zum Löschen:

1. Navigiere zur Detailseite der Schicht
2. Klicke auf **Löschen**
3. Bestätige das Löschen

## Mit Schichtstatus arbeiten

Schichten durchlaufen Status automatisch basierend auf der Zeit:

1. **Erstellt** - Schicht existiert, ist aber möglicherweise nicht sichtbar
2. **Offen** - Engel können sich anmelden
3. **Besetzt** - Alle Plätze sind belegt (Engel können sich noch auf Wartelisten setzen, falls aktiviert)
4. **In Bearbeitung** - Schicht läuft gerade
5. **Abgeschlossen** - Schicht ist beendet

Du änderst diese Status nicht manuell - sie aktualisieren sich basierend auf Zeit und Anmeldestatus.

{{% notice tip %}}
Wenn du Schichten für eine neue Veranstaltung erstellst, beginne mit Orts-Standardwerten für häufige Anforderungen. Das spart Zeit und gewährleistet Konsistenz. Überschreibe nur bei einzelnen Schichten, wenn nötig.
{{% /notice %}}
