---
title: "Goodies verteilen"
weight: 10
---

Diese Anleitung behandelt den Prozess der Berechtigungsprüfung, Markierung des Aktiv-Status und Erfassung der Goodie-Verteilung.

## Das Goodie-System verstehen

Die meisten Events verwenden einen zweistufigen Prozess:

1. **Aktiv-Status** - Freiwilliger wird als qualifiziert durch ausreichende Arbeitsstunden markiert
2. **Goodie erhalten** - Freiwilliger wird als physisches Goodie erhalten markiert

Diese Trennung erlaubt Flexibilität - jemand könnte berechtigt (aktiv) sein, aber sein Goodie noch nicht abgeholt haben.

## Berechtigung prüfen

Wenn ein Freiwilliger sein Goodie anfordert:

1. **Im System finden** - Nach Name oder Nickname suchen
2. **Status prüfen**:
   - Gearbeitete Stunden (aus Schichten und Worklogs)
   - Aktueller Aktiv-Status
   - Ob bereits ein Goodie erhalten wurde

{{% notice note %}}
Das `user.info.view`-Privileg lässt dich persönliche Details wie echte Namen sehen. Das hilft bei der Identitätsprüfung vor der Verteilung.
{{% /notice %}}

## Aktiv-Status setzen

Wenn ein Freiwilliger genug Stunden gearbeitet hat, aber nicht als aktiv markiert ist:

1. Verifiziere, dass die gearbeiteten Stunden die Schwelle erreichen
2. Markiere sie als "aktiv"
3. Das macht sie berechtigt für Goodies

{{% notice info %}}
"Aktiv"-Status kann auch andere Dinge bei deinem Event beeinflussen, wie auf bestimmten Listen zu erscheinen oder Privilegien zu verdienen. Kläre mit deinen Koordinatoren, was Aktiv-Status bei deinem Event bedeutet.
{{% /notice %}}

## Verteilung erfassen

Beim Ausgeben eines Goodies:

1. Verifiziere, dass die Person zum Konto passt
2. Prüfe ihre T-Shirt-Größenpräferenz (falls zutreffend)
3. Übergib den physischen Artikel
4. Markiere "Goodie erhalten" im System

## Goodie-Listen pro Engeltyp

Das `angeltype.goodie.list`-Privileg gibt dir Zugang zu Goodie-Listen, organisiert nach Engeltyp. Das ist nützlich für:

- Verteilung nach Team planen
- Benötigte Größen pro Team erfassen
- Verteilung während Team-Meetings organisieren

## Sonderfälle behandeln

### Nicht genug Stunden

Wenn jemand noch nicht genug Stunden gearbeitet hat:
- Erkläre die Stundenschwelle
- Zeige ihren aktuellen Stand
- Schlage vor, sich für mehr Schichten anzumelden

### Bereits erhalten

Wenn das System zeigt, dass sie ihr Goodie bereits bekommen haben:
- Jemand anders könnte es erfasst haben
- Sie könnten es an einer anderen Ausgabestelle abgeholt haben
- Frage Koordinatoren, wenn sie behaupten, das sei ein Fehler

### Falsche Größe

Wenn die registrierte Größe von der gewünschten abweicht:
- Prüfe deine Bestandsverfügbarkeit
- Aktualisiere ihre Präferenz wenn möglich
- Dokumentiere jeden Umtausch

### Nicht angekommen

Wenn jemand nicht als angekommen markiert ist:
- Sie sollten zuerst am Welcome Angel-Schalter einchecken
- Manche Events erfordern Ankunft vor der Goodie-Verteilung

## Tipps für Verteilungs-Events

Bei Verteilung während einer konzentrierten Phase (wie Event-Abschluss):

- **Nach Größe vorsortieren** - Stapel organisiert haben
- **Listen drucken** - Backup-Listen bei Verbindungsproblemen haben
- **Zwei-Personen-Teams** - Eine prüft Berechtigung, eine holt Artikel
- **Sofort markieren** - System aktualisieren beim Ausgeben, nicht danach

## Verwandte Themen

- [Rollenverwaltung]({{% relref "/admin/role_management" %}}) - Goodie Manager-Privilegien verstehen
