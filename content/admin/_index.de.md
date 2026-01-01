---
title: "Administration"
date: 2019-02-12T20:35:11+01:00
weight: 40
---

Dieser Abschnitt behandelt alles, was du brauchst, um eine Engelsystem-Instanz für dein Event zu deployen, zu konfigurieren und zu warten. Egal ob du einen kleinen Hackathon organisierst oder Tausende von Freiwilligen auf einer großen Konferenz koordinierst - diese Anleitung hilft dir, Engelsystem reibungslos zum Laufen zu bringen.

## Was du hier findest

**[Installation](installation/)** behandelt das Deployment von Engelsystem mit Docker, Kubernetes, NixOS oder einem traditionellen PHP-Webserver-Setup. Jede Methode enthält Schritt-für-Schritt-Anleitungen und produktionsreife Konfigurationen.

**[Konfiguration](configuration/)** erklärt alle verfügbaren Einstellungen, von Datenbankverbindungen und E-Mail-Versand bis hin zu Schichtplanungsregeln und Belohnungsberechnungen. Lerne, wie du Engelsystem an die spezifischen Anforderungen deines Events anpasst.

**[Rollenverwaltung](role_management/)** beschreibt das Berechtigungssystem. Verstehe, wie Gruppen, Privilegien und Benutzerrollen zusammenwirken, um den Zugriff auf verschiedene Funktionen zu steuern.

**[Zeitplan-Import](schedule-import/)** zeigt, wie du automatisch Schichten aus externen Event-Zeitplänen wie Frab oder Pretalx erstellen kannst. Dies ist besonders nützlich für Konferenzen, bei denen Freiwilligenschichten mit Vorträgen und Sessions übereinstimmen sollen.

**[OAuth-Konfiguration](oauth/)** behandelt die Integration externer Authentifizierungsanbieter, sodass sich Benutzer mit bestehenden Konten von Diensten wie GitHub, Google oder dem Identitätsanbieter deiner Organisation anmelden können.

**[Übersetzung](translation/)** erklärt, wie du die Standard-Oberflächentexte anpassen oder überschreiben kannst. Nützlich, um die Terminologie an die Kultur deines Events anzupassen oder Unterstützung für zusätzliche Sprachen hinzuzufügen.

## Bevor du beginnst

Um Engelsystem erfolgreich zu deployen, solltest du vertraut sein mit:

- Grundlegender Serveradministration (Linux-Kommandozeile, Dateiberechtigungen)
- Datenbankverwaltung (MySQL/MariaDB-Grundlagen)
- Webserver-Konfiguration (nginx oder Apache), wenn du nicht Docker verwendest
- Deiner gewählten Deployment-Methode (Docker, Kubernetes oder NixOS)

Du benötigst Zugang zu:

- Einem Server oder einer Container-Plattform zum Ausführen der Anwendung
- Einem MySQL 5.7+ oder MariaDB 10.2+ Datenbankserver
- SMTP-Server oder E-Mail-Dienst zum Versenden von Benachrichtigungen (optional, aber empfohlen)

## Deployment-Übersicht

Engelsystem ist eine PHP-Anwendung, die folgendes benötigt:

1. **Webserver** - nginx oder Apache zur Verarbeitung von HTTP-Anfragen
2. **PHP-Runtime** - PHP 8.2 oder neuer mit erforderlichen Erweiterungen
3. **Datenbank** - MySQL oder MariaDB für persistente Speicherung
4. **Hintergrundjobs** - Optional, für geplante Aufgaben

Für Produktions-Deployments empfehlen wir:

- **Docker oder Kubernetes** für reproduzierbare Deployments und einfache Updates
- **HTTPS** mit gültigen Zertifikaten (erforderlich für Security-Header)
- **Regelmäßige Backups** der Datenbank und Konfiguration

## Schnellstart

Wenn du Engelsystem zum ersten Mal einrichtest:

1. Wähle deine [Deployment-Methode](installation/) basierend auf deiner Infrastruktur
2. Folge der Installationsanleitung, um die Anwendung zum Laufen zu bringen
3. Melde dich mit den Standard-Admin-Zugangsdaten an (ändere diese sofort!)
4. Konfiguriere [grundlegende Einstellungen](configuration/) wie deinen Event-Namen und die Zeitzone
5. Richte [Benutzerrollen](role_management/) ein, die zu deiner Teamstruktur passen
6. Konfiguriere optional [OAuth](oauth/) für einfachere Benutzerauthentifizierung

## Hilfe bekommen

- **GitHub Issues**: Melde Fehler oder fordere Features an unter [engelsystem/engelsystem](https://github.com/engelsystem/engelsystem/issues)
- **Quellcode**: Durchsuche die Implementierung auf [github.com/engelsystem/engelsystem](https://github.com/engelsystem/engelsystem)

{{% notice tip %}}
Führe vor deinem Event ein Test-Deployment durch und lass die Teamleiter überprüfen, ob sie ihre Aufgaben erledigen können. Es ist viel einfacher, Konfigurationsprobleme zu beheben, bevor Hunderte von Freiwilligen versuchen, sich für Schichten anzumelden.
{{% /notice %}}
