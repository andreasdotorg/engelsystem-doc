---
title: "Gutscheine verteilen"
weight: 10
---

Diese Anleitung behandelt den Prozess der Berechtigungsprüfung und Erfassung der Verteilung.

## Gutscheinberechtigung verstehen

Freiwillige verdienen Gutscheine basierend auf konfigurierten Regeln. Häufige Konfigurationen:

- **Stundenbasiert** - 1 Gutschein pro X gearbeitete Stunden verdienen
- **Ankunftsgutschein** - Gutschein allein für die Ankunft erhalten
- **Maximallimit** - Begrenzung der Gesamtgutscheine pro Person

Das System berechnet automatisch verdiente Gutscheine basierend auf:
- Gearbeitete Schichten (abgeschlossen, nicht nur angemeldet)
- Manuelle Worklog-Einträge
- Erzwungen vergebene Gutscheine von Koordinatoren

## Status eines Freiwilligen prüfen

Wenn jemand nach Gutscheinen fragt:

1. **In der Benutzerliste finden** - Nach Name oder Nickname suchen
2. **Gutscheinstatus ansehen** - Sieh:
   - Verdiente Gutscheine (basierend auf Stunden)
   - Bereits erhaltene Gutscheine
   - Verfügbare Gutscheine zum Abholen

{{% notice note %}}
Wenn du ein Hinweis-Symbol neben Benutzerinformationen siehst, sind einige ihrer Details eingeschränkt. Dies beeinflusst die Gutscheinverteilung nicht.
{{% /notice %}}

## Gutscheinverteilung erfassen

Beim Ausgeben von Gutscheinen:

1. Verifiziere, dass die Person zum Konto passt
2. Prüfe, wie viele Gutscheine sie erhalten kann
3. Übergib die physischen Gutscheine
4. Aktualisiere die "Gutschein erhalten"-Anzahl im System

Das System erfasst:
- Wie viele Gutscheine ihnen zustehen
- Wie viele sie bereits erhalten haben
- Den verbleibenden Saldo

## Sonderfälle behandeln

### "Ich sollte mehr Gutscheine haben"

Wenn jemand glaubt, mehr Gutscheine zu verdienen:

1. Prüfe ihre gearbeiteten Stunden im Profil
2. Verifiziere, dass Schichten als gearbeitet markiert sind (nicht nur angemeldet)
3. Prüfe, ob Worklogs hinzugefügt werden müssen
4. Verweise an einen Shift Coordinator, wenn es Unstimmigkeiten gibt

### Bereits erhalten

Wenn das System zeigt, dass sie ihre Gutscheine bereits erhalten haben:
- Ein anderer Voucher Angel könnte sie bereits ausgegeben haben
- Sie könnten sie an einer anderen Ausgabestelle erhalten haben
- Frage deinen Koordinator, wenn sie behaupten, das sei ein Fehler

### Noch nicht angekommen

Wenn jemand nicht als angekommen markiert ist:
- Sie müssen möglicherweise zuerst am Welcome Angel-Schalter einchecken
- Manche Events erfordern Ankunftsmarkierung vor der Gutscheinverteilung

## Best Practices

- **Identität verifizieren** vor dem Verteilen von Gutscheinen
- **Sofort aktualisieren** wenn du Gutscheine ausgibst (nicht sammeln)
- **Bestand zählen** um nicht leer zu werden
- **Koordinatoren kontaktieren** wenn du Muster von Problemen bemerkst

## Verwandte Themen

- [Rollenverwaltung]({{% relref "/admin/role_management" %}}) - Voucher Angel-Privilegien verstehen
