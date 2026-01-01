---
title: "Privilegien-Referenz"
date: 2025-01-01T12:00:00+01:00
weight: 10
---

Diese Seite bietet umfassende Dokumentation für jedes Privileg in Engelsystem. Jeder Eintrag beschreibt, was das Privileg steuert, welche spezifischen Operationen es ermöglicht und welche Gruppen es standardmäßig haben.

## Wie diese Referenz zu verwenden ist

- **Privilegname** - Der Bezeichner in der Datenbank und im Code
- **Ermöglichte Operationen** - Spezifische Seiten, Buttons oder Aktionen, die durch dieses Privileg freigeschaltet werden
- **Standardgruppen** - Gruppen, die dieses Privileg in einer Standardinstallation haben
- **Verwandte Privilegien** - Andere Privilegien, die häufig zusammen benötigt werden
- **Sicherheitshinweise** - Warnungen für sensible Privilegien

---

## Authentifizierung & Navigation

### `start`

**Beschreibung:** Zugriff auf die Start-/Landingpage von Engelsystem.

**Ermöglichte Operationen:**
- Die Haupt-Landingpage anzeigen (`/`)
- Event-Informationen und Statistiken sehen
- Auf Login-/Registrierungslinks zugreifen (wenn nicht eingeloggt)

**Standardgruppen:** Guest

---

### `login`

**Beschreibung:** Das Anmeldeformular anzeigen.

**Ermöglichte Operationen:**
- Die Login-Seite anzeigen (`/login`)
- Anmeldedaten übermitteln
- Auf Passwort-Wiederherstellung zugreifen (falls aktiviert)

**Standardgruppen:** Guest

---

### `logout`

**Beschreibung:** Die aktuelle Sitzung beenden.

**Ermöglichte Operationen:**
- Den Logout-Button/Link in der Navigation klicken
- Die Sitzung beenden und Authentifizierung löschen

**Standardgruppen:** Angel

---

### `register`

**Beschreibung:** Zugriff auf das Selbstregistrierungsformular für neue Benutzer.

**Ermöglichte Operationen:**
- Die Registrierungsseite anzeigen (`/register`)
- Registrierungsformular absenden um ein neues Konto zu erstellen
- Andere Benutzer manuell registrieren (für Koordinatoren)

**Standardgruppen:** Guest, Shift Coordinator

**Verwandte Privilegien:**
- In Kombination mit `admin_user` ermöglicht es die direkte Registrierung von Benutzern in bestimmten Gruppen

{{% notice note %}}
Die Registrierung kann systemweit in der Konfiguration deaktiviert werden. Wenn deaktiviert, hat dieses Privileg keine Auswirkung auf die Selbstregistrierung.
{{% /notice %}}

---

## News & Kommunikation

### `news`

**Beschreibung:** Den News-Feed anzeigen.

**Ermöglichte Operationen:**
- Auf die News-Seite zugreifen (`/news`)
- Alle veröffentlichten News-Posts lesen
- News-Post-Details einschließlich Kommentare sehen

**Standardgruppen:** Angel

**Verwandte Privilegien:**
- `news_comments` - Benötigt um Kommentare zu News zu schreiben
- `admin_news` - Benötigt um News-Posts zu erstellen/bearbeiten

---

### `news_comments`

**Beschreibung:** Kommentare zu News-Beiträgen schreiben.

**Ermöglichte Operationen:**
- Das Kommentarformular bei News-Posts sehen
- Neue Kommentare absenden
- Bestehende Kommentare von anderen Benutzern anzeigen

**Standardgruppen:** Angel

**Verwandte Privilegien:**
- `news` - Erforderlich um News-Posts zuerst anzuzeigen

---

### `admin_news`

**Beschreibung:** News-Posts erstellen, bearbeiten und löschen.

**Ermöglichte Operationen:**
- "News erstellen"-Button auf der News-Seite
- Bearbeiten-Button bei bestehenden News-Posts
- Löschen-Button bei News-Posts
- Sichtbarkeit von News-Posts setzen (öffentlich/privat)
- News-Posts für zukünftige Veröffentlichung planen

**Standardgruppen:** Shift Coordinator

**Verwandte Privilegien:**
- `news.highlight` - Benötigt um Posts als hervorgehoben zu markieren

---

### `news.highlight`

**Beschreibung:** News-Posts als hervorgehoben/wichtig markieren.

**Ermöglichte Operationen:**
- "Hervorheben"-Checkbox beim Erstellen/Bearbeiten von News
- Hervorgehobene Posts erscheinen oben im News-Feed
- Hervorgehobene Posts haben visuelle Betonung

**Standardgruppen:** Bureaucrat

**Verwandte Privilegien:**
- `admin_news` - Erforderlich um News-Posts zu bearbeiten

---

### `user_messages`

**Beschreibung:** Direktnachrichten zwischen Benutzern senden und empfangen.

**Ermöglichte Operationen:**
- Auf die Nachrichten-Seite zugreifen (`/messages`)
- Neue Nachrichten an andere Benutzer senden
- Empfangene Nachrichten lesen
- Nachrichtenverlauf anzeigen
- "Nachricht senden"-Button auf Benutzerprofilen

**Standardgruppen:** Angel

---

### `user_meetings`

**Beschreibung:** Meeting-Termine anzeigen.

**Ermöglichte Operationen:**
- Auf die Meetings-Seite zugreifen (`/meetings`)
- Geplante Meetings und deren Details anzeigen
- Meeting-Orte und -Zeiten sehen

**Standardgruppen:** Angel

---

## Schichten & Planung

### `user_shifts`

**Beschreibung:** Den Schichtkalender anzeigen und sich für Schichten anmelden.

**Ermöglichte Operationen:**
- Auf die Schichten-Seite zugreifen (`/user-shifts`)
- Den Schichtkalender/-plan anzeigen
- Verfügbare Schichten und deren Details sehen
- Sich für Schichten anmelden (abhängig von Engeltyp-Anforderungen)
- Schichten nach Ort, Zeit, Engeltyp filtern

**Standardgruppen:** Angel

**Verwandte Privilegien:**
- `user_myshifts` - Eigene Anmeldungen anzeigen
- `user_shifts_admin` - Admin-Operationen für Schichteinträge

---

### `user_myshifts`

**Beschreibung:** Eigene Schichtanmeldungen anzeigen.

**Ermöglichte Operationen:**
- Auf persönliche Schichtliste zugreifen (`/user-myshifts`)
- Schichten anzeigen, für die man angemeldet ist
- Schichtdetails und Ortsinformationen sehen
- Eigene Anmeldungen absagen (falls per Konfiguration erlaubt)

**Standardgruppen:** Angel

---

### `user_shifts_admin`

**Beschreibung:** Administrative Operationen für Schichteinträge.

**Ermöglichte Operationen:**
- Andere Benutzer für Schichten anmelden
- Benutzer von Schichten abmelden
- Besetzte Schichten im Kalender anzeigen (normalerweise versteckt)
- Engeltyp-Anforderungen beim Anmelden von Benutzern überschreiben
- Schichteintrag-Kommentare bearbeiten

**Standardgruppen:** Shift Coordinator

**Verwandte Privilegien:**
- `admin_shifts` - Die Schichten selbst erstellen/bearbeiten
- `admin_user_angeltypes` - Engeltyp-Mitgliedschaft überschreiben

---

### `admin_shifts`

**Beschreibung:** Schichten erstellen, bearbeiten und löschen.

**Ermöglichte Operationen:**
- Auf "Schichten erstellen"-Seite zugreifen (`/admin-shifts`)
- Neue Schichten erstellen mit Titel, Zeit, Ort, benötigten Engeln
- Bestehende Schichtdetails bearbeiten
- Schichten löschen
- Schichten kopieren um ähnliche zu erstellen
- Massenhafte Schichterstellung
- Zeitplan-Übersicht anzeigen

**Standardgruppen:** Shift Coordinator

**Verwandte Privilegien:**
- `user_shifts_admin` - Verwalten wer angemeldet ist
- `schedule.import` - Schichten aus externen Zeitplänen importieren
- `shifttypes.view` - Verfügbare Schichttypen anzeigen
- `locations.edit` - Neue Orte für Schichten erstellen

---

### `schedule.import`

**Beschreibung:** Schichten aus externen Zeitplanquellen importieren (Frab/Pretalx).

**Ermöglichte Operationen:**
- Auf die Zeitplan-Import-Seite zugreifen (`/admin/schedule`)
- Zeitplan-Import-URLs konfigurieren
- Schichten aus Frab XML oder Pretalx-Feeds importieren
- Import-Status und Konflikte anzeigen
- Importierte Sessions auf Engeltypen mappen

**Standardgruppen:** (Nicht standardmäßig zugewiesen)

**Verwandte Privilegien:**
- `admin_shifts` - Wird normalerweise zusammen für volle Schichtverwaltung benötigt

{{% notice info %}}
Zeitplan-Import wird typischerweise für Konferenzen verwendet, bei denen Talks/Sessions aus einem Zeitplansystem als Schichten erscheinen sollen, für die sich Freiwillige anmelden können.
{{% /notice %}}

---

### `shifttypes.view`

**Beschreibung:** Schichttyp-Definitionen anzeigen.

**Ermöglichte Operationen:**
- Auf die Schichttypen-Seite zugreifen (`/admin/shifttypes`)
- Liste aller Schichttypen anzeigen
- Schichttyp-Details sehen (Name, Beschreibung)

**Standardgruppen:** Shift Coordinator

**Verwandte Privilegien:**
- `shifttypes.edit` - Benötigt um Schichttypen zu erstellen/ändern

---

### `shifttypes.edit`

**Beschreibung:** Schichttypen erstellen und bearbeiten.

**Ermöglichte Operationen:**
- "Schichttyp erstellen"-Button
- Bestehenden Schichttyp-Namen und Beschreibung bearbeiten
- Schichttypen löschen (wenn nicht in Verwendung)
- Standard-Engeltyp-Anforderungen pro Schichttyp setzen

**Standardgruppen:** Bureaucrat

**Verwandte Privilegien:**
- `shifttypes.view` - Bestehende Schichttypen anzeigen

---

### `ical`

**Beschreibung:** Persönlichen Schichtkalender im iCal-Format exportieren.

**Ermöglichte Operationen:**
- Auf die iCal-Feed-URL für persönliche Schichten zugreifen
- Schichten in externe Kalenderanwendungen importieren (Google Calendar, Apple Calendar usw.)
- Die Feed-URL wird auf dem Benutzerprofil angezeigt

**Standardgruppen:** Angel

{{% notice note %}}
Die iCal-URL enthält einen Authentifizierungstoken. Benutzer sollten diese URL privat halten.
{{% /notice %}}

---

### `atom`

**Beschreibung:** Auf den News-Atom-Feed zugreifen.

**Ermöglichte Operationen:**
- Auf die Atom-Feed-URL zugreifen (`/atom`)
- News-Updates in RSS/Atom-Readern abonnieren
- Programmatischer Zugriff auf News-Inhalte

**Standardgruppen:** Angel

---

### `shifts_json_export`

**Beschreibung:** Schichtdaten als JSON exportieren.

**Ermöglichte Operationen:**
- Auf den JSON-Export-Endpunkt zugreifen
- Schichtdaten für externe Tools oder Analyse herunterladen
- Die Export-URL wird auf dem Benutzerprofil angezeigt

**Standardgruppen:** Angel

---

## Engeltypen

### `angeltypes`

**Beschreibung:** Die Liste der Engeltypen anzeigen.

**Ermöglichte Operationen:**
- Auf die Engeltypen-Seite zugreifen (`/angeltypes`)
- Alle Engeltypen und ihre Beschreibungen anzeigen
- Anforderungen und Einschränkungen für jeden Typ sehen
- Sehen, welchen Engeltypen man angehört

**Standardgruppen:** Angel

---

### `user_angeltypes`

**Beschreibung:** Eigene Engeltyp-Mitgliedschaften verwalten.

**Ermöglichte Operationen:**
- Mitgliedschaft in Engeltypen beantragen
- Engeltypen verlassen
- Ausstehende Mitgliedschaftsanfragen anzeigen
- Sehen, welche Engeltypen Bestätigung erfordern

**Standardgruppen:** Angel

**Verwandte Privilegien:**
- `admin_user_angeltypes` - Mitgliedschaften anderer Benutzer verwalten

---

### `admin_angel_types`

**Beschreibung:** Engeltypen erstellen, bearbeiten und löschen.

**Ermöglichte Operationen:**
- "Engeltyp erstellen"-Button auf der Engeltypen-Seite
- Engeltyp-Name, Beschreibung und Anforderungen bearbeiten
- Engeltypen löschen (wenn keine Mitglieder)
- Selbstanmeldungs-Einstellungen konfigurieren
- Setzen, ob der Typ Bestätigung erfordert
- Kontaktinformationen konfigurieren (DECT, E-Mail)
- Schicht-Selbstanmeldungs-Optionen setzen

**Standardgruppen:** Bureaucrat

**Verwandte Privilegien:**
- `admin_user_angeltypes` - Mitgliedschaften in den erstellten Typen verwalten

---

### `admin_user_angeltypes`

**Beschreibung:** Engeltyp-Mitgliedschaften anderer Benutzer verwalten.

**Ermöglichte Operationen:**
- Ausstehende Engeltyp-Mitgliedschaftsanfragen bestätigen
- Benutzer direkt zu Engeltypen hinzufügen
- Benutzer aus Engeltypen entfernen
- Benutzer als Supporter für einen Engeltyp setzen
- Das Bestätigungserfordernis überschreiben
- "Mitglieder verwalten"-Button auf Engeltyp-Seiten

**Standardgruppen:** Shift Coordinator

**Verwandte Privilegien:**
- `admin_angel_types` - Die Typen selbst erstellen/bearbeiten

{{% notice note %}}
Supporter eines Engeltyps können auch Mitglieder für ihren Typ bestätigen, auch ohne dieses Privileg.
{{% /notice %}}

---

### `angeltype.goodie.list`

**Beschreibung:** Goodie-Berechtigungslisten pro Engeltyp anzeigen.

**Ermöglichte Operationen:**
- Auf Goodie-Listen-Ansicht auf Engeltyp-Seiten zugreifen
- Sehen, welche Mitglieder Goodies verdient haben
- Gearbeitete Stunden pro Mitglied anzeigen
- Nach Goodie-Status filtern (erhalten/nicht erhalten)

**Standardgruppen:** Goodie Manager

**Verwandte Privilegien:**
- `user.goodie.edit` - Benutzer als Goodies erhalten markieren

---

## Orte

### `locations.view`

**Beschreibung:** Die Liste der Orte anzeigen.

**Ermöglichte Operationen:**
- Auf die Orte-Seite zugreifen (`/locations`)
- Ortsnamen und Beschreibungen anzeigen
- Ortsdetails sehen (Kartenlinks, Kapazität usw.)
- Sehen, welche Schichten an jedem Ort geplant sind

**Standardgruppen:** Angel

---

### `locations.edit`

**Beschreibung:** Orte erstellen, bearbeiten und löschen.

**Ermöglichte Operationen:**
- "Ort erstellen"-Button auf der Orte-Seite
- Ortsname, Beschreibung und Details bearbeiten
- Orts-Karten-URL setzen
- Orte löschen (wenn keine Schichten geplant)
- Standard-Engeltyp-Anforderungen pro Ort konfigurieren

**Standardgruppen:** Bureaucrat

---

## Benutzerverwaltung

### `admin_user`

**Beschreibung:** Voller Zugriff auf Benutzerverwaltung.

**Ermöglichte Operationen:**
- Auf die vollständige Benutzerliste zugreifen (`/users`)
- Benutzer suchen und filtern
- Das vollständige Profil jedes Benutzers anzeigen
- Benutzerprofil-Informationen bearbeiten (Name, E-Mail, DECT usw.)
- Benutzerpasswörter ändern
- Benutzerkonten löschen
- Schichtverlauf des Benutzers anzeigen
- Arbeitsprotokoll des Benutzers anzeigen
- Gruppenzugehörigkeiten des Benutzers bearbeiten
- Benutzer zwangsweise für Goodies aktivieren
- Gutschein-Status anzeigen

**Standardgruppen:** Shift Coordinator

**Verwandte Privilegien:**
- `admin_groups` - Benötigt um zu ändern, welche Gruppen existieren
- `user.info.view` - Teilmenge nur zum Anzeigen
- `admin_active` - Teilmenge nur für Goodie-Aktivierung

{{% notice warning %}}
Benutzer mit `admin_user` können sich selbst zu jeder Gruppe hinzufügen, indem sie ihr eigenes Profil bearbeiten. Dies gewährt ihnen effektiv alle Privilegien. Nur an hochvertrauenswürdige Mitarbeiter vergeben.
{{% /notice %}}

---

### `user_settings`

**Beschreibung:** Eigene Profileinstellungen bearbeiten.

**Ermöglichte Operationen:**
- Auf persönliche Einstellungsseite zugreifen (`/settings`)
- Eigenes Passwort ändern
- E-Mail-Adresse aktualisieren
- Benachrichtigungs-Präferenzen konfigurieren
- Sprachpräferenz setzen
- Theme-Präferenz setzen
- Kontaktinformationen aktualisieren (DECT, Mobil)
- API-Schlüssel generieren/regenerieren

**Standardgruppen:** Angel

---

### `user.nick.edit`

**Beschreibung:** Benutzernamen ändern.

**Ermöglichte Operationen:**
- Das Benutzername/Nickname-Feld auf Benutzerprofilen bearbeiten
- Benutzer umbenennen (als Admin)

**Standardgruppen:** (Nicht standardmäßig zugewiesen - in `admin_user` integriert)

---

### `user.info.view`

**Beschreibung:** Sensible Benutzerinformationsfelder anzeigen.

**Ermöglichte Operationen:**
- Vollständigen Namen des Benutzers sehen (Vor- und Nachname)
- Pronomen-Informationen anzeigen
- Geplante Ankunfts-/Abreisedaten anzeigen
- Persönliche Kontaktdaten anzeigen
- Benutzer-Notizen-Feld sehen

**Standardgruppen:** Goodie Manager, Shift Coordinator

**Verwandte Privilegien:**
- `user.info.edit` - Diese Felder auch bearbeiten
- `user.info.hint` - Indikatoren sehen, dass Felder existieren aber verborgen sind

---

### `user.info.edit`

**Beschreibung:** Sensible Benutzerinformationsfelder bearbeiten.

**Ermöglichte Operationen:**
- Vollständigen Namen des Benutzers bearbeiten
- Pronomen-Informationen bearbeiten
- Geplante Daten bearbeiten
- Persönliches Notizen-Feld bearbeiten
- Alle Operationen von `user.info.view`

**Standardgruppen:** Bureaucrat

---

### `user.info.hint`

**Beschreibung:** Hinweise/Indikatoren sehen, wenn Benutzerinfo-Felder eingeschränkt sind.

**Ermöglichte Operationen:**
- "(eingeschränkt)"-Indikatoren bei Profilfeldern sehen, die man nicht anzeigen kann
- Wissen, dass zusätzliche Informationen existieren ohne sie zu sehen
- Nützlich um zu wissen, wann an jemanden mit mehr Zugang eskaliert werden sollte

**Standardgruppen:** Welcome Angel, Voucher Angel, Goodie Manager, Shift Coordinator

---

### `user.goodie.edit`

**Beschreibung:** Benutzer als Goodies erhalten markieren (T-Shirts usw.).

**Ermöglichte Operationen:**
- "Goodie erhalten"-Checkbox auf Benutzerprofilen
- Benutzer als T-Shirt/Merchandise erhalten markieren
- Goodie-Status auf Benutzerprofilen anzeigen
- Button auf Benutzerprofil zum Umschalten des Goodie-Status

**Standardgruppen:** Goodie Manager, Shift Coordinator

**Verwandte Privilegien:**
- `admin_active` - Benutzer als für Goodies berechtigt markieren

---

### `user.drive.edit`

**Beschreibung:** Führerschein-Informationen bearbeiten.

**Ermöglichte Operationen:**
- Führerschein-Felder auf Benutzerprofilen bearbeiten
- Benutzer als PKW-/LKW-/Gabelstapler-Führerschein haben markieren
- Führerschein-Status anzeigen
- Führerschein-Details bearbeiten (Führerscheinnummer, Ablaufdatum)

**Standardgruppen:** Shift Coordinator

{{% notice info %}}
Benutzer, die Supporter von Engeltypen sind, die Fahren erfordern, können auch Führerscheine für ihre Mitglieder bearbeiten.
{{% /notice %}}

---

### `user.ifsg.edit`

**Beschreibung:** IFSG (Infektionsschutzgesetz) Zertifikatsstatus bearbeiten.

**Ermöglichte Operationen:**
- IFSG-Zertifikatsfelder auf Benutzerprofilen bearbeiten
- Benutzer als gültiges IFSG-Zertifikat habend markieren
- Zertifikatsdatum setzen

**Standardgruppen:** Shift Coordinator

{{% notice info %}}
IFSG-Zertifikate werden in Deutschland für den Umgang mit Lebensmitteln benötigt. Benutzer, die Supporter von Engeltypen sind, die IFSG erfordern, können dies auch für ihre Mitglieder bearbeiten.
{{% /notice %}}

---

### `user.fa.edit`

**Beschreibung:** Erste-Hilfe-Zertifizierungsstatus bearbeiten.

**Ermöglichte Operationen:**
- Erste-Hilfe-Zertifizierung auf Benutzerprofilen bearbeiten
- Benutzer als Erste-Hilfe-Ausbildung habend markieren
- Zertifizierungs-Ablaufdatum setzen

**Standardgruppen:** Bureaucrat

---

### `user.ff.edit`

**Beschreibung:** "Frei-von"-Status bearbeiten (Diät-/Allergie-Informationen).

**Ermöglichte Operationen:**
- Frei-von-Felder auf Benutzerprofilen bearbeiten
- Ernährungseinschränkungen und Allergien erfassen
- Spezifische Frei-von-Kategorien markieren

**Standardgruppen:** Shift Coordinator

---

### `admin_active`

**Beschreibung:** Benutzer als "aktiv" für Goodie-Berechtigung markieren.

**Ermöglichte Operationen:**
- Auf die "Aktive Engel"-Seite zugreifen (`/admin-active`)
- Sehen, welche Benutzer genug Stunden gearbeitet haben
- Benutzer zwangsweise als aktiv markieren (Stundenanforderungen überschreiben)
- Benutzer als inaktiv markieren
- Massenhafte Aktivierungs-Operationen

**Standardgruppen:** Goodie Manager, Shift Coordinator

**Verwandte Privilegien:**
- `user.goodie.edit` - Goodies als tatsächlich erhalten markieren

---

### `admin_arrive`

**Beschreibung:** Benutzer als beim Event angekommen markieren.

**Ermöglichte Operationen:**
- "Als angekommen markieren"-Button auf Benutzerprofilen
- Ankunfts-Zeitstempel setzen
- Auf ankunftsbezogene Funktionen auf der Ankunftsseite zugreifen

**Standardgruppen:** Welcome Angel, Goodie Manager, Shift Coordinator

**Verwandte Privilegien:**
- `users.arrive.list` - Die Liste der anzukommenden Benutzer anzeigen

{{% notice note %}}
Wenn `autoarrive` in der Konfiguration aktiviert ist, werden Benutzer beim ersten Login automatisch als angekommen markiert, was dieses Privileg weniger relevant macht.
{{% /notice %}}

---

### `users.arrive.list`

**Beschreibung:** Die Ankunftslisten-Seite anzeigen.

**Ermöglichte Operationen:**
- Auf die Ankunftsseite zugreifen (`/admin-arrive`)
- Liste der Benutzer anzeigen, die noch nicht angekommen sind
- Liste der Benutzer anzeigen, die angekommen sind
- Nach Benutzern nach Namen suchen
- Nach Ankunftsstatus filtern

**Standardgruppen:** Welcome Angel, Voucher Angel, Goodie Manager, Shift Coordinator

---

### `admin_free`

**Beschreibung:** Freie/verfügbare Engel anzeigen und verwalten.

**Ermöglichte Operationen:**
- Auf die "Freie Engel"-Seite zugreifen (`/admin-free`)
- Sehen, welche Benutzer gerade nicht in einer Schicht sind
- Benutzer sehen, die für sofortige Zuweisung verfügbar sind
- Nach Engeltyp filtern

**Standardgruppen:** Shift Coordinator

---

### `admin_user_worklog`

**Beschreibung:** Arbeitsstunden-Logs bearbeiten.

**Ermöglichte Operationen:**
- Auf Worklog-Bereich in Benutzerprofilen zugreifen
- Manuelle Worklog-Einträge erstellen
- Bestehende Worklog-Einträge bearbeiten
- Worklog-Einträge löschen
- Stunden für Arbeit hinzufügen, die nicht über Schichten erfasst wurde

**Standardgruppen:** Shift Coordinator, Bureaucrat

---

### `voucher.edit`

**Beschreibung:** Gutscheinverteilung für Benutzer bearbeiten.

**Ermöglichte Operationen:**
- Gutscheinanzahl auf Benutzerprofilen bearbeiten
- An Benutzer gegebene Gutscheine erfassen
- Gutschein-Status anzeigen
- Button zum Geben/Nehmen von Gutscheinen

**Standardgruppen:** Voucher Angel, Shift Coordinator

---

## Systemadministration

### `admin_groups`

**Beschreibung:** Benutzergruppen verwalten und Privilegien zu Gruppen zuweisen.

**Ermöglichte Operationen:**
- Auf die "Gruppenrechte"-Seite zugreifen (`/admin-groups`)
- Alle Gruppen und ihre Privilegien anzeigen
- Neue Gruppen erstellen
- Gruppen löschen (mit Vorsicht)
- Privilegien zu Gruppen hinzufügen/entfernen
- Gruppennamen ändern

**Standardgruppen:** Developer

{{% notice warning %}}
Dies ist das mächtigste Privileg. Benutzer mit `admin_groups` können sich selbst jedes andere Privileg gewähren, indem sie Gruppenzuweisungen ändern. Auf Systemadministratoren beschränken.
{{% /notice %}}

---

### `admin_log`

**Beschreibung:** Audit-Logs anzeigen.

**Ermöglichte Operationen:**
- Auf die Logs-Seite zugreifen (`/admin/logs`)
- System-Aktivitätslog anzeigen
- Sehen, wer welche Aktionen durchgeführt hat
- Logs nach Benutzer oder Aktionstyp filtern
- Log-Einträge durchsuchen

**Standardgruppen:** Shift Coordinator, Bureaucrat

**Verwandte Privilegien:**
- `logs.all` - Sensible Log-Einträge anzeigen

---

### `logs.all`

**Beschreibung:** Alle Log-Einträge einschließlich sensibler anzeigen.

**Ermöglichte Operationen:**
- Log-Einträge sehen, die normalerweise versteckt sind
- Sicherheitsrelevante Log-Einträge anzeigen
- Auf vollständigen Audit-Trail zugreifen

**Standardgruppen:** Bureaucrat

**Verwandte Privilegien:**
- `admin_log` - Grundlegende Log-Ansicht

---

### `config.edit`

**Beschreibung:** Event-Konfiguration bearbeiten.

**Ermöglichte Operationen:**
- Auf die Konfigurationsseite zugreifen (`/admin/config`)
- Event-Name und -Daten bearbeiten
- Registrierungseinstellungen konfigurieren
- Goodie-/T-Shirt-Optionen setzen
- Gutschein-Einstellungen konfigurieren
- Features aktivieren/deaktivieren
- Theme und Erscheinungsbild setzen
- Kontaktinformationen konfigurieren

**Standardgruppen:** Shift Coordinator, Developer

{{% notice note %}}
Einige Konfigurationsoptionen erfordern zusätzliche Privilegien. Die Config-Seite zeigt nur Optionen, die der Benutzer bearbeiten kann.
{{% /notice %}}

---

### `faq.view`

**Beschreibung:** FAQ-Einträge anzeigen.

**Ermöglichte Operationen:**
- Auf die FAQ-Seite zugreifen (`/faq`)
- Alle veröffentlichten FAQ-Einträge lesen
- FAQ-Inhalt durchsuchen

**Standardgruppen:** Guest, Angel

---

### `faq.edit`

**Beschreibung:** FAQ-Einträge erstellen und bearbeiten.

**Ermöglichte Operationen:**
- "FAQ erstellen"-Button
- Bestehende FAQ-Einträge bearbeiten
- FAQ-Einträge löschen
- FAQ-Einträge neu ordnen

**Standardgruppen:** Shift Coordinator

---

### `question.add`

**Beschreibung:** Fragen an Organisatoren stellen.

**Ermöglichte Operationen:**
- Auf die Fragen-Seite zugreifen (`/questions`)
- Neue Fragen stellen
- Eigene gestellte Fragen anzeigen
- Antworten auf eigene Fragen sehen

**Standardgruppen:** Angel

---

### `question.edit`

**Beschreibung:** Gestellte Fragen beantworten und bearbeiten.

**Ermöglichte Operationen:**
- Auf "Fragen beantworten"-Seite zugreifen (`/admin/questions`)
- Alle gestellten Fragen anzeigen
- Antworten auf Fragen schreiben
- Bestehende Antworten bearbeiten
- Fragen löschen
- Benachrichtigung wenn neue Fragen ankommen

**Standardgruppen:** Shift Coordinator

---

### `api`

**Beschreibung:** Auf die programmatische API zugreifen.

**Ermöglichte Operationen:**
- API-Endpunkte mit API-Schlüssel-Authentifizierung nutzen
- Daten programmatisch lesen (Benutzer, Schichten usw.)
- Daten über API schreiben (abhängig von anderen Privilegien)
- Der API-Schlüssel wird in den Benutzereinstellungen angezeigt

**Standardgruppen:** API

{{% notice info %}}
API-Zugriff respektiert andere Privilegien. Die API erlaubt nur Operationen, die die anderen Gruppenzugehörigkeiten des Benutzers erlauben.
{{% /notice %}}

---

### `tag.edit`

**Beschreibung:** Tags für Kategorisierung bearbeiten.

**Ermöglichte Operationen:**
- Auf die Tags-Seite zugreifen (`/admin/tags`)
- Neue Tags erstellen
- Tag-Namen und -Farben bearbeiten
- Unbenutzte Tags löschen

**Standardgruppen:** Shift Coordinator

---

## Privilegien-Schnellreferenz

### Nach Funktion

| Funktion | Anzeigen | Bearbeiten | Admin |
|----------|----------|------------|-------|
| News | `news` | `news_comments` | `admin_news`, `news.highlight` |
| Schichten | `user_shifts`, `user_myshifts` | - | `admin_shifts`, `user_shifts_admin` |
| Schichttypen | `shifttypes.view` | `shifttypes.edit` | - |
| Engeltypen | `angeltypes` | `user_angeltypes` | `admin_angel_types`, `admin_user_angeltypes` |
| Orte | `locations.view` | - | `locations.edit` |
| Benutzer | - | `user_settings` | `admin_user` |
| Benutzerinfo | `user.info.view`, `user.info.hint` | `user.info.edit` | - |
| Benutzerzertifikate | - | `user.drive.edit`, `user.ifsg.edit`, `user.fa.edit` | - |
| Goodies | - | `user.goodie.edit` | `admin_active` |
| Ankünfte | `users.arrive.list` | `admin_arrive` | - |
| Worklogs | - | `admin_user_worklog` | - |
| Gutscheine | - | `voucher.edit` | - |
| FAQ | `faq.view` | `faq.edit` | - |
| Fragen | `question.add` | `question.edit` | - |
| Logs | `admin_log` | - | `logs.all` |
| Konfiguration | - | `config.edit` | - |
| Gruppen | - | - | `admin_groups` |

### Nach Risikostufe

**Niedriges Risiko** - Nur Informationszugriff:
- `start`, `login`, `logout`, `register`
- `news`, `news_comments`, `atom`
- `user_shifts`, `user_myshifts`, `ical`, `shifts_json_export`
- `angeltypes`, `user_angeltypes`
- `locations.view`
- `user_settings`, `user_messages`, `user_meetings`
- `faq.view`, `question.add`

**Mittleres Risiko** - Kann Daten ändern:
- `admin_news`, `news.highlight`
- `admin_shifts`, `user_shifts_admin`, `schedule.import`
- `shifttypes.view`, `shifttypes.edit`
- `admin_angel_types`, `admin_user_angeltypes`
- `locations.edit`
- `user.info.view`, `user.info.edit`, `user.info.hint`
- `user.goodie.edit`, `user.drive.edit`, `user.ifsg.edit`, `user.fa.edit`, `user.ff.edit`
- `admin_active`, `admin_arrive`, `users.arrive.list`, `admin_free`
- `admin_user_worklog`, `voucher.edit`
- `faq.edit`, `question.edit`, `tag.edit`
- `api`, `angeltype.goodie.list`

**Hohes Risiko** - Breiter Systemzugriff:
- `admin_user` - Kann jeden Benutzer einschließlich Gruppenzugehörigkeiten bearbeiten
- `admin_log`, `logs.all` - Kann sensible Aktivitäten sehen
- `config.edit` - Kann Systemverhalten ändern

**Kritisches Risiko** - Volle Systemkontrolle:
- `admin_groups` - Kann jedes Privileg vergeben
