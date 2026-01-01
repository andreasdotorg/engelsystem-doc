---
title: "Engelsystem Dokumentation"
---

Das Engelsystem ist ein Freiwilligen-Management- und Schichtplanungssystem für Veranstaltungen. Es hilft dem Organisationsteam bei der Koordination von Freiwilligen durch Verwaltung von Schichtplänen, Nachverfolgung von Qualifikationen, Erfassung von Arbeitsstunden und Verteilung von Belohnungen.

## Kernkonzepte

**Freiwillige** registrieren Accounts, treten Engeltypen bei die zu ihren Fähigkeiten passen, und melden sich für Schichten an. Das System erfasst ihre Stunden und verwaltet die Berechtigung für Belohnungen.

**Engeltypen** repräsentieren Kategorien von Freiwilligenarbeit. Einige stehen jedem offen, andere erfordern Genehmigung oder bestimmte Qualifikationen.

**Schichten** sind zeitlich begrenzte Arbeitseinsätze an bestimmten Orten. Freiwillige melden sich für Schichten an, die zu ihren Engeltypen passen.

**Orte** definieren, wo Schichten stattfinden - Räume, Eingänge, Stationen oder beliebige Bereiche bei deiner Veranstaltung.

## Berechtigungsgruppen

Engelsystem verwendet Gruppen um zu steuern, was Benutzer*innen tun können. Benutzer*innen werden einer oder mehreren Gruppen zugewiesen:

| Gruppe | Zweck |
|--------|-------|
| Angel | Basis-Freiwillige - für Schichten anmelden, Stunden erfassen, Belohnungen verdienen |
| Welcome Angel | Anmeldeschalter - Ankunft von Freiwilligen markieren |
| Voucher Angel | Essens- und Getränkegutscheine verteilen |
| Goodie Manager | T-Shirt- und Merchandise-Verteilung |
| Shift Coordinator | Schichten erstellen, Benutzer verwalten, Fragen beantworten |
| Bureaucrat | Event-Struktur konfigurieren (Engeltypen, Orte, Schichttypen) |
| API | Zugriff auf die programmatische API für Integrationen |
| Developer | Vollständige Systemadministration und -konfiguration |

Die meisten Freiwilligen brauchen nur die **Angel**-Gruppe. Spezialisierte Rollen erhalten bei Bedarf zusätzliche Gruppen.

### Supporter-Fähigkeit

**Supporter** unterscheidet sich von den obigen Gruppen - es ist eine engeltyp-spezifische Fähigkeit, keine systemweite Rolle. Jeder Angel kann zum Supporter für bestimmte Engeltypen ernannt werden, denen er angehört. Supporter können Mitgliedschaftsanfragen genehmigen und Schichten für ihr Team verwalten. Siehe das [Supporter-Handbuch](supporter/) für Details.

## Erste Schritte

1. **Registriere** einen Account in der Engelsystem-Instanz deiner Veranstaltung
2. **Vervollständige dein Profil** mit Kontaktinformationen
3. **Tritt Engeltypen bei**, die zu deinen Fähigkeiten oder Interessen passen
4. **Durchsuche Schichten** und melde dich für verfügbare Plätze an
5. **Arbeite deine Schichten** und sammle Stunden für Belohnungen

## Dokumentationsbereiche

### Benutzerhandbücher

- **[Benutzerhandbuch](user/)** - Für alle Freiwilligen: Registrierung, Schichten, Profil und Nachrichten
- **[Supporter-Handbuch](supporter/)** - Für Teamleiter: Engeltyp-Mitgliedschaft und Team-Schichten verwalten
- **[Welcome Angel-Handbuch](welcome-angel/)** - Für den Anmeldeschalter: Ankünfte markieren
- **[Voucher Angel-Handbuch](voucher-angel/)** - Für die Gutscheinverteilung
- **[Goodie Manager-Handbuch](goodie-manager/)** - Für T-Shirt- und Merchandise-Verteilung
- **[Schichtkoordinator-Handbuch](shift-coordinator/)** - Für Koordinatoren: Schichten, Benutzer, FAQ und Arbeitsprotokolle
- **[Bürokraten-Handbuch](bureaucrat/)** - Für Organisatoren: Engeltypen, Orte und Event-Struktur

### Technische Dokumentation

- **[Administration](admin/)** - Servereinrichtung, Konfiguration und Rollenverwaltung
- **[Entwicklung](developer/)** - Technische Architektur und Beitragsrichtlinien
- **[API-Referenz](api/)** - REST-API für Integrationen
