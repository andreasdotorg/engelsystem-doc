---
title: "Goodie Manager-Handbuch"
weight: 27
---

Goodie Manager kümmern sich um die Verteilung von T-Shirts, Merchandise und anderen physischen Belohnungen an Freiwillige. Du verifizierst, dass Freiwillige genug Stunden gearbeitet haben, um sich zu qualifizieren, und erfasst, wer seine Goodies erhalten hat.

## Was Goodie Manager tun

Deine Rolle kombiniert mehrere Verantwortlichkeiten:
- **Berechtigung prüfen** - Verifizieren, dass Freiwillige die erforderlichen Stunden gearbeitet haben
- **Aktiv-Status markieren** - Freiwillige als "aktiv" für Goodie-Berechtigung kennzeichnen
- **Verteilung erfassen** - Aufzeichnen, wann Goodies ausgegeben wurden
- **Ankünfte verwalten** - Du kannst auch Freiwillige als angekommen markieren

## Erforderliche Berechtigungen

Um als Goodie Manager zu arbeiten, musst du Mitglied der **Goodie Manager**-Gruppe sein. Diese Gruppe gewährt:

| Privileg | Was es ermöglicht |
|----------|-------------------|
| `admin_active` | Benutzer als aktiv für Goodie-Berechtigung markieren |
| `admin_arrive` | Benutzer als angekommen markieren |
| `user.goodie.edit` | Benutzer als Goodie erhalten markieren |
| `user.info.view` | Sensible Benutzerinformationen anzeigen (Name, Kontakt) |
| `user.info.hint` | Indikatoren sehen, wenn Benutzerinfo eingeschränkt ist |
| `users.arrive.list` | Zugriff auf die Ankunftsliste |
| `angeltype.goodie.list` | Goodie-Listen pro Engeltyp anzeigen |

Du solltest auch in der **Angel**-Gruppe für grundlegenden Systemzugang sein.

## Berechtigung verstehen

Das Goodie-System funktioniert typischerweise so:

1. **Stundenschwelle** - Freiwillige müssen eine Mindestanzahl Stunden arbeiten
2. **Aktiv-Status** - Jemand markiert sie als "aktiv" (berechtigt für Goodies)
3. **Verteilung** - Goodie Manager erfasst, dass sie ihr Goodie erhalten haben

Die genauen Anforderungen hängen von der Konfiguration deines Events ab.

## Erste Schritte

1. **Benutzerliste aufrufen** - Navigiere zum Ankunfts- oder Benutzerverwaltungsbereich
2. **Berechtigung prüfen** - Arbeitsstunden der Freiwilligen prüfen
3. **Als aktiv markieren** - Aktiv-Status für berechtigte Freiwillige setzen
4. **Verteilung erfassen** - Markieren, wenn Goodies ausgegeben werden

## Dokumentation

- [Goodies verteilen](goodies/) - Schritt-für-Schritt-Anleitung zur Goodie-Verteilung

{{% notice tip %}}
Hab ein System zur Erfassung von T-Shirt-Größen. Du willst wissen, was angefragt wurde, bevor Freiwillige an deiner Ausgabestelle ankommen.
{{% /notice %}}
