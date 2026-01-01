---
title: "Rollenverwaltung"
date: 2019-02-13T19:37:52+01:00
lastmod: 2025-01-01T12:00:00+01:00
weight: 40
---

Engelsystem verwendet ein gruppenbasiertes Berechtigungssystem. Benutzer gehören zu Gruppen, und Gruppen haben Privilegien, die steuern, welche Aktionen Benutzer durchführen können. Diese Seite dokumentiert alle Gruppen, ihren vorgesehenen Zweck und ihre zugewiesenen Privilegien.

## Wie Berechtigungen funktionieren

### Flaches Gruppenmodell

Engelsystem verwendet ein flaches Berechtigungsmodell ohne Hierarchie zwischen Gruppen. Wenn ein Benutzer zu mehreren Gruppen gehört, sind seine effektiven Berechtigungen die Vereinigung aller Privilegien aus allen seinen Gruppen.

Zum Beispiel, wenn ein Benutzer sowohl **Welcome Angel** (kann Ankünfte markieren) als auch **Voucher Angel** (kann Gutscheine bearbeiten) ist, kann er beide Operationen durchführen.

### Gruppenzugehörigkeit

Benutzer werden auf verschiedene Arten Gruppen zugewiesen:

1. **Registrierung** - Neue Benutzer treten automatisch der konfigurierten Standardgruppe bei (typischerweise "Angel")
2. **OAuth/SSO** - Externe Authentifizierungsanbieter können angeben, welche Gruppen zugewiesen werden
3. **Manuelle Zuweisung** - Administratoren fügen Benutzer über das Benutzerprofil zu Gruppen hinzu
4. **Self-Service** - Für Engeltypen mit `no_self_signup = false` können Benutzer Mitgliedschaft beantragen

### Berechtigungsprüfungen

Das System prüft Privilegien auf mehreren Ebenen:

- **Seitenzugriff** - Das Navigationsmenü zeigt nur Seiten, auf die der Benutzer zugreifen kann
- **Controller-Aktionen** - Jede Aktion überprüft das erforderliche Privileg vor der Ausführung
- **UI-Elemente** - Buttons und Formulare werden bedingt basierend auf Berechtigungen gerendert

## Gruppen

Engelsystem enthält acht vordefinierte Gruppen. Jedes Event kann diese anpassen oder zusätzliche Gruppen erstellen.

### Guest

**ID:** 10

**Zweck:** Bietet Zugang für nicht authentifizierte Besucher, bevor sie sich anmelden oder registrieren.

**Typische Benutzer:** Jeder, der die Seite besucht und nicht eingeloggt ist.

**Fähigkeiten:**
- Startseite anzeigen
- Auf das Anmeldeformular zugreifen
- Neues Konto registrieren (falls Registrierung aktiviert ist)
- FAQ anzeigen

**Privilegien:**
| Privileg | Beschreibung |
|----------|--------------|
| `start` | Zugriff auf die Startseite |
| `login` | Anmeldeformular anzeigen |
| `register` | Selbstregistrierungsformular |
| `faq.view` | FAQ-Einträge anzeigen |

---

### Angel

**ID:** 20

**Zweck:** Basisrolle für alle registrierten Freiwilligen. Jeder eingeloggte Benutzer sollte mindestens diese Gruppe haben.

**Typische Benutzer:** Alle registrierten Freiwilligen beim Event.

**Fähigkeiten:**
- Schichten anzeigen und sich anmelden
- Eigenen Schichtplan anzeigen
- Profileinstellungen verwalten
- News lesen und kommentieren
- Nachrichten senden und empfangen
- Engeltypen anzeigen und Mitgliedschaften beantragen
- Ortsinformationen anzeigen
- Persönlichen Kalender exportieren (iCal)
- Fragen über das Q&A-System stellen

**Privilegien:**
| Privileg | Beschreibung |
|----------|--------------|
| `angeltypes` | Engeltypen-Liste anzeigen |
| `atom` | Auf News-Atom-Feed zugreifen |
| `faq.view` | FAQ-Einträge anzeigen |
| `ical` | Persönlichen Schichtkalender exportieren |
| `locations.view` | Ortsliste und Details anzeigen |
| `logout` | Aktuelle Sitzung beenden |
| `news` | News-Feed anzeigen |
| `news_comments` | Kommentare zu News schreiben |
| `question.add` | Fragen an Organisatoren stellen |
| `shifts_json_export` | Schichtdaten als JSON exportieren |
| `user_angeltypes` | Eigene Engeltyp-Mitgliedschaften verwalten |
| `user_meetings` | Meeting-Termine anzeigen |
| `user_messages` | Direktnachrichten senden und empfangen |
| `user_myshifts` | Eigene Schichtanmeldungen anzeigen |
| `user_settings` | Eigene Profileinstellungen bearbeiten |
| `user_shifts` | Schichtkalender anzeigen und anmelden |

---

### Welcome Angel

**ID:** 30

**Zweck:** Personal am Ankunfts-/Registrierungsschalter, das Freiwillige eincheckt, wenn sie beim Event ankommen.

**Typische Benutzer:** Freiwillige am Info-Desk oder an der Ankunftsstation.

**Fähigkeiten:**
- Liste der erwarteten Ankünfte anzeigen
- Benutzer als beim Event angekommen markieren
- Hinweise zu Benutzern mit eingeschränkten Informationen sehen

**Privilegien:**
| Privileg | Beschreibung |
|----------|--------------|
| `admin_arrive` | Benutzer als angekommen markieren |
| `user.info.hint` | Indikatoren sehen, wenn Benutzerinfo-Felder eingeschränkt sind |
| `users.arrive.list` | Ankunftsliste anzeigen |

{{% notice note %}}
Welcome Angels erben Angel-Privilegien durch Gruppenzugehörigkeit. Benutzer in dieser Gruppe sollten auch in der Angel-Gruppe sein.
{{% /notice %}}

---

### Voucher Angel

**ID:** 35

**Zweck:** Verteilt Gutscheine (z.B. Essensgutscheine, Getränke-Tokens) an Freiwillige, die sie verdient haben.

**Typische Benutzer:** Freiwillige an Gutschein-Ausgabestellen.

**Fähigkeiten:**
- Sehen, wer für Gutscheine berechtigt ist
- Gutscheinverteilung an Benutzer erfassen
- Hinweise zu Benutzern mit eingeschränkten Informationen sehen

**Privilegien:**
| Privileg | Beschreibung |
|----------|--------------|
| `user.info.hint` | Indikatoren sehen, wenn Benutzerinfo-Felder eingeschränkt sind |
| `users.arrive.list` | Benutzerlisten für Gutscheinverteilung anzeigen |
| `voucher.edit` | Gutscheinanzahl für Benutzer bearbeiten |

---

### API

**ID:** 40

**Zweck:** Gewährt Zugriff auf die programmatische API für externe Integrationen.

**Typische Benutzer:** Service-Accounts für externe Systeme, Automatisierungsskripte oder Drittanbieter-Tools.

**Fähigkeiten:**
- Auf API-Endpunkte für programmatisches Lesen und Schreiben von Daten zugreifen

**Privilegien:**
| Privileg | Beschreibung |
|----------|--------------|
| `api` | Auf die API zugreifen |

{{% notice note %}}
API-Zugriff verwendet den API-Schlüssel des Benutzers zur Authentifizierung. Der API-Schlüssel ist in den Benutzereinstellungen zu finden.
{{% /notice %}}

---

### Goodie Manager

**ID:** 50

**Zweck:** Handhabt T-Shirt- und Goodie-Verteilung. Verfolgt, wer genug Stunden gearbeitet hat, um Goodies zu erhalten, und markiert sie als verteilt.

**Typische Benutzer:** Freiwillige an der T-Shirt-/Merchandise-Ausgabe.

**Fähigkeiten:**
- Ankunftsstatus von Freiwilligen anzeigen
- Benutzer als angekommen markieren
- Benutzerinformationen für Goodie-Verteilung anzeigen
- Benutzer als "aktiv" markieren (berechtigt für Goodies basierend auf gearbeiteten Stunden)
- Erfassen, wenn Benutzer ihre Goodies erhalten haben
- Goodie-Berechtigungslisten pro Engeltyp anzeigen

**Privilegien:**
| Privileg | Beschreibung |
|----------|--------------|
| `admin_active` | Benutzer als aktiv für Goodie-Berechtigung markieren |
| `admin_arrive` | Benutzer als angekommen markieren |
| `angeltype.goodie.list` | Goodie-Listen pro Engeltyp anzeigen |
| `user.goodie.edit` | Benutzer als Goodie erhalten markieren |
| `user.info.hint` | Indikatoren sehen, wenn Benutzerinfo-Felder eingeschränkt sind |
| `user.info.view` | Sensible Benutzerinformationen anzeigen (Name, Kontakt) |
| `users.arrive.list` | Ankunftsliste anzeigen |

---

### Shift Coordinator

**ID:** 60

**Zweck:** Kernrolle für Event-Betrieb. Verwaltet Schichten, Benutzer und den täglichen Betrieb während des Events.

**Typische Benutzer:** Teamleiter, Schichtleiter, Betriebskoordinatoren.

**Fähigkeiten:**
- Volle Benutzerverwaltung (anzeigen, bearbeiten, löschen)
- Schichten erstellen, bearbeiten und löschen
- Schichteinträge verwalten (Benutzer an-/abmelden)
- Arbeitsprotokoll und Gutscheine bearbeiten
- News-Ankündigungen posten
- Fragen von Freiwilligen beantworten
- FAQ-Einträge bearbeiten
- Benutzerzertifikate anzeigen und bearbeiten (IFSG, Führerschein, Erste Hilfe)
- Event-Einstellungen konfigurieren
- Audit-Logs anzeigen
- Neue Benutzer manuell registrieren

**Privilegien:**
| Privileg | Beschreibung |
|----------|--------------|
| `admin_active` | Benutzer als aktiv für Goodies markieren |
| `admin_arrive` | Benutzer als angekommen markieren |
| `admin_free` | Freie/verfügbare Engel anzeigen und verwalten |
| `admin_log` | Audit-Logs anzeigen |
| `admin_news` | News-Posts erstellen, bearbeiten und löschen |
| `admin_shifts` | Schichten erstellen, bearbeiten und löschen |
| `admin_user` | Volle Benutzerverwaltung |
| `admin_user_angeltypes` | Engeltyp-Mitgliedschaften von Benutzern verwalten |
| `admin_user_worklog` | Arbeitsstunden-Logs bearbeiten |
| `config.edit` | Event-Konfiguration bearbeiten |
| `faq.edit` | FAQ-Einträge erstellen und bearbeiten |
| `question.edit` | Fragen beantworten und bearbeiten |
| `register` | Neue Benutzer registrieren |
| `shifttypes.view` | Schichttyp-Definitionen anzeigen |
| `tag.edit` | Tags bearbeiten |
| `user.drive.edit` | Führerschein-Informationen bearbeiten |
| `user.ff.edit` | Frei-von-Status bearbeiten |
| `user.goodie.edit` | Goodies als erhalten markieren |
| `user.ifsg.edit` | IFSG-Zertifikatsstatus bearbeiten |
| `user.info.hint` | Benutzerinfo-Einschränkungs-Hinweise sehen |
| `user.info.view` | Sensible Benutzerfelder anzeigen |
| `user_shifts_admin` | Admin-Schichteintrag-Operationen |
| `users.arrive.list` | Ankunftsliste anzeigen |
| `voucher.edit` | Gutscheinverteilung bearbeiten |

{{% notice warning %}}
Das `admin_user`-Privileg erlaubt das Bearbeiten von Gruppenzugehörigkeiten. Benutzer mit diesem Privileg könnten sich selbst zu höher-privilegierten Gruppen hinzufügen. Nur an vertrauenswürdige Mitarbeiter vergeben.
{{% /notice %}}

---

### Bureaucrat

**ID:** 80

**Zweck:** Übergeordnete administrative Aufgaben, die die Struktur des Events betreffen (Engeltypen, Orte, Schichttypen).

**Typische Benutzer:** Senior-Organisatoren, Abteilungsleiter, Event-Architekten.

**Fähigkeiten:**
- Engeltypen erstellen und ändern
- Orte erstellen und ändern
- Schichttypen erstellen und ändern
- Sensible Benutzerinformationen bearbeiten
- Wichtige News-Posts hervorheben
- Vollständige Audit-Logs anzeigen (einschließlich sensibler Einträge)
- Erste-Hilfe-Zertifizierungsstatus bearbeiten

**Privilegien:**
| Privileg | Beschreibung |
|----------|--------------|
| `admin_angel_types` | Engeltypen erstellen, bearbeiten und löschen |
| `admin_log` | Audit-Logs anzeigen |
| `admin_user_worklog` | Arbeitsstunden-Logs bearbeiten |
| `locations.edit` | Orte erstellen, bearbeiten und löschen |
| `logs.all` | Alle Log-Einträge einschließlich sensibler anzeigen |
| `news.highlight` | News als hervorgehoben/wichtig markieren |
| `shifttypes.edit` | Schichttypen erstellen und bearbeiten |
| `user.fa.edit` | Erste-Hilfe-Zertifizierungsstatus bearbeiten |
| `user.info.edit` | Sensible Benutzerfelder bearbeiten |

---

### Developer

**ID:** 90

**Zweck:** Vollständiger Systemzugriff für technische Administratoren. Dies ist die höchste Privilegstufe.

**Typische Benutzer:** Systemadministratoren, technische Leiter.

**Fähigkeiten:**
- Benutzergruppen und Privilegien verwalten
- Vollständiger Zugriff auf Event-Konfiguration

**Privilegien:**
| Privileg | Beschreibung |
|----------|--------------|
| `admin_groups` | Benutzergruppen verwalten und Privilegien zuweisen |
| `config.edit` | Event-Konfiguration bearbeiten |

{{% notice warning %}}
Benutzer mit `admin_groups` können die Privilegien jeder Gruppe ändern, einschließlich der Vergabe von vollem Zugriff an sich selbst. Dies sollte auf Systemadministratoren beschränkt werden.
{{% /notice %}}

---

## Gruppen verwalten

### Gruppen anzeigen

Navigiere zu **Admin > Gruppenrechte**, um alle Gruppen und ihre Privilegien zu sehen.

### Benutzer zu Gruppen hinzufügen

1. Navigiere zum Benutzerprofil (suche in **Admin > Alle Engel**)
2. Klicke auf **Bearbeiten**
3. Im Gruppen-Bereich die zuzuweisenden Gruppen ankreuzen
4. Änderungen speichern

Änderungen werden beim nächsten Seitenladen des Benutzers wirksam.

### Eigene Gruppen erstellen

Du kannst eigene Gruppen für die spezifischen Bedürfnisse deines Events erstellen:

1. Navigiere zu **Admin > Gruppenrechte**
2. Erstelle eine neue Gruppe mit einem beschreibenden Namen
3. Weise die benötigten Privilegien zu
4. Füge Benutzer zur Gruppe hinzu

Häufige eigene Gruppen:
- **Pressekontakt** - Eingeschränkter Zugang für Medienvertreter
- **Sponsor** - Zugang für Event-Sponsoren
- **Abteilungsleiter** - Eigene Kombination aus Schicht- und Engeltyp-Verwaltung

### OAuth Auto-Zuweisung

Bei Verwendung von OAuth/SSO kannst du automatische Gruppenzuweisung basierend auf der Antwort des Identitätsanbieters konfigurieren. Siehe die [Konfiguration]({{% relref "/admin/configuration" %}}) Seite für Details.

## Privilegien-Referenz

Für detaillierte Dokumentation jedes Privilegs einschließlich aller Operationen, die es ermöglicht, siehe die [Privilegien-Referenz]({{% relref "privileges" %}}).

## Best Practices

### Minimale Rechte

Gib Benutzern nur die Berechtigungen, die sie für ihre Rolle benötigen. Beginne mit der Basis-Angel-Gruppe und füge bei Bedarf spezifische Gruppen hinzu.

### Gruppen statt direkter Privilegien verwenden

Verwalte Berechtigungen immer über Gruppen anstatt Privilegien direkt an Benutzer zu vergeben. Das macht die Berechtigungsverwaltung klarer und einfacher zu auditieren.

### Vor-Event-Überprüfung

Vor größeren Events die Gruppenzugehörigkeiten überprüfen:

1. Verifiziere, dass alle Koordinatoren angemessenen Zugang haben
2. Entferne Zugang von Benutzern, die ihn nicht mehr benötigen
3. Teste, dass neue Freiwillige sich registrieren und für Schichten anmelden können

### Sicherheitserwägungen

| Privileg | Risiko | Empfehlung |
|----------|--------|------------|
| `admin_groups` | Kann jede Berechtigung vergeben | Nur auf Systemadmins beschränken |
| `admin_user` | Kann Gruppenzugehörigkeiten bearbeiten | Auf vertrauenswürdige Koordinatoren beschränken |
| `config.edit` | Kann Systemverhalten ändern | Auf Senior-Organisatoren beschränken |
| `logs.all` | Kann sensible Daten einsehen | Nur für Sicherheits-/Audit-Rollen |

### Eigene Gruppen dokumentieren

Wenn du Event-spezifische Gruppen erstellst, dokumentiere:
- Den Zweck der Gruppe
- Wer ihr zugewiesen werden sollte
- Welche Privilegien sie enthält
- Wann Benutzer daraus entfernt werden sollten
