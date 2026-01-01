---
title: "Installation"
date: 2019-02-13T19:35:37+01:00
weight: 10
---

Diese Anleitung behandelt das Deployment von Engelsystem mit Docker, Kubernetes, NixOS oder einem traditionellen PHP-Webserver. Wähle die Methode, die am besten zu deiner Infrastruktur passt.

## Anforderungen

Alle Deployment-Methoden benötigen:

- **Datenbank**: MySQL 5.7+ oder MariaDB 10.2+
- **PHP**: 8.2 oder neuer (für traditionelles Deployment)
- **Speicher**: Mindestens 256MB, 512MB+ empfohlen für größere Events

Für traditionelle Deployments benötigst du außerdem:
- Composer (PHP-Paketmanager)
- Node.js 20+ und Yarn (zum Bauen der Frontend-Assets)
- Webserver (nginx oder Apache)

Die vollständige Anforderungsliste findest du in der [Projekt-README](https://github.com/engelsystem/engelsystem?tab=readme-ov-file#requirements).

---

## Docker-Deployment

Docker ist der empfohlene Ansatz für die meisten Deployments. Es bietet konsistente Umgebungen und vereinfacht Updates.

### Schnellstart

Erstelle eine `docker-compose.yml`:

```yaml
services:
  engelsystem:
    image: engelsystem/engelsystem:latest
    ports:
      - "8080:80"
    environment:
      MYSQL_HOST: db
      MYSQL_DATABASE: engelsystem
      MYSQL_USER: engelsystem
      MYSQL_PASSWORD: aendern
      APP_NAME: "Mein Event Angels"
      TIMEZONE: "Europe/Berlin"
    depends_on:
      db:
        condition: service_healthy
    restart: unless-stopped

  db:
    image: mariadb:10.11
    environment:
      MYSQL_DATABASE: engelsystem
      MYSQL_USER: engelsystem
      MYSQL_PASSWORD: aendern
      MYSQL_ROOT_PASSWORD: rootaendern
    volumes:
      - db_data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "healthcheck.sh", "--connect", "--innodb_initialized"]
      interval: 10s
      timeout: 5s
      retries: 3
    restart: unless-stopped

volumes:
  db_data:
```

Starte den Stack:

```bash
docker compose up -d
```

Greife auf Engelsystem unter `http://localhost:8080` zu. Der erste Start führt automatisch Datenbank-Migrationen aus.

### Produktionskonfiguration

Für Produktions-Deployments berücksichtige diese Punkte:

**Persistente Konfiguration:**

Erstelle eine `config/config.php`-Datei und mounte sie:

```yaml
services:
  engelsystem:
    volumes:
      - ./config/config.php:/var/www/config/config.php:ro
```

**HTTPS mit Reverse-Proxy:**

Betreibe Engelsystem hinter einem Reverse-Proxy wie Traefik oder nginx-proxy:

```yaml
services:
  engelsystem:
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.engelsystem.rule=Host(`angels.example.com`)"
      - "traefik.http.routers.engelsystem.tls.certresolver=letsencrypt"
    networks:
      - traefik
      - default

networks:
  traefik:
    external: true
```

**Log-Persistenz:**

Mounte das Storage-Verzeichnis um Logs zu erhalten:

```yaml
volumes:
  - ./storage:/var/www/storage
```

**Datenbank-Backups:**

Füge einen Backup-Service hinzu oder plane `mysqldump` vom Host:

```bash
docker compose exec db mysqldump -u engelsystem -paendern engelsystem > backup.sql
```

### Eigene Images bauen

Wenn du das Image anpassen musst (eigene Themes, Patches):

```bash
git clone https://github.com/engelsystem/engelsystem.git
cd engelsystem
docker build -t mein-engelsystem .
```

Verwende dann `mein-engelsystem` statt `engelsystem/engelsystem:latest` in deiner Compose-Datei.

---

## Kubernetes-Deployment

Kubernetes-Deployments sind ideal für größere Events, die Hochverfügbarkeit, automatische Skalierung oder Integration mit bestehender Cluster-Infrastruktur erfordern.

### Voraussetzungen

- Kubernetes-Cluster (1.20+)
- kubectl konfiguriert
- Ingress-Controller (nginx-ingress, Traefik usw.)
- Persistent-Storage-Provisioner
- Externe Datenbank oder In-Cluster MySQL/MariaDB

### Deployment-Manifeste

Erstelle einen Namespace:

```yaml
# namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: engelsystem
```

Erstelle Secrets für sensible Daten:

```yaml
# secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: engelsystem-secrets
  namespace: engelsystem
type: Opaque
stringData:
  mysql-password: "dein-sicheres-passwort"
  mysql-root-password: "dein-root-passwort"
```

Deploye MariaDB (oder verwende eine externe Datenbank):

```yaml
# mariadb.yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mariadb
  namespace: engelsystem
spec:
  serviceName: mariadb
  replicas: 1
  selector:
    matchLabels:
      app: mariadb
  template:
    metadata:
      labels:
        app: mariadb
    spec:
      containers:
        - name: mariadb
          image: mariadb:10.11
          env:
            - name: MYSQL_DATABASE
              value: engelsystem
            - name: MYSQL_USER
              value: engelsystem
            - name: MYSQL_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: engelsystem-secrets
                  key: mysql-password
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: engelsystem-secrets
                  key: mysql-root-password
          ports:
            - containerPort: 3306
          volumeMounts:
            - name: data
              mountPath: /var/lib/mysql
          resources:
            requests:
              memory: "256Mi"
              cpu: "100m"
            limits:
              memory: "1Gi"
              cpu: "500m"
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 10Gi
---
apiVersion: v1
kind: Service
metadata:
  name: mariadb
  namespace: engelsystem
spec:
  selector:
    app: mariadb
  ports:
    - port: 3306
  clusterIP: None
```

Erstelle ConfigMap für Anwendungskonfiguration:

```yaml
# configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: engelsystem-config
  namespace: engelsystem
data:
  config.php: |
    <?php
    return [
        'app_name' => 'Event Angels',
        'timezone' => 'Europe/Berlin',
        'environment' => 'production',
    ];
```

Deploye Engelsystem:

```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: engelsystem
  namespace: engelsystem
spec:
  replicas: 2
  selector:
    matchLabels:
      app: engelsystem
  template:
    metadata:
      labels:
        app: engelsystem
    spec:
      containers:
        - name: engelsystem
          image: engelsystem/engelsystem:latest
          ports:
            - containerPort: 80
          env:
            - name: MYSQL_HOST
              value: mariadb
            - name: MYSQL_DATABASE
              value: engelsystem
            - name: MYSQL_USER
              value: engelsystem
            - name: MYSQL_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: engelsystem-secrets
                  key: mysql-password
          volumeMounts:
            - name: config
              mountPath: /var/www/config/config.php
              subPath: config.php
          resources:
            requests:
              memory: "128Mi"
              cpu: "50m"
            limits:
              memory: "512Mi"
              cpu: "500m"
          readinessProbe:
            httpGet:
              path: /health
              port: 80
            initialDelaySeconds: 10
            periodSeconds: 5
          livenessProbe:
            httpGet:
              path: /health
              port: 80
            initialDelaySeconds: 30
            periodSeconds: 10
      volumes:
        - name: config
          configMap:
            name: engelsystem-config
---
apiVersion: v1
kind: Service
metadata:
  name: engelsystem
  namespace: engelsystem
spec:
  selector:
    app: engelsystem
  ports:
    - port: 80
      targetPort: 80
```

Erstelle Ingress für externen Zugriff:

```yaml
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: engelsystem
  namespace: engelsystem
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - angels.example.com
      secretName: engelsystem-tls
  rules:
    - host: angels.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: engelsystem
                port:
                  number: 80
```

Wende alle Manifeste an:

```bash
kubectl apply -f namespace.yaml
kubectl apply -f secrets.yaml
kubectl apply -f mariadb.yaml
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl apply -f ingress.yaml
```

### Skalierung

Erhöhe Replikate für höhere Verfügbarkeit:

```bash
kubectl scale deployment engelsystem -n engelsystem --replicas=4
```

Für automatische Skalierung basierend auf Last:

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: engelsystem
  namespace: engelsystem
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: engelsystem
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
```

### Externe Datenbank verwenden

Für Produktion erwäge einen verwalteten Datenbankdienst. Aktualisiere die Deployment-Umgebungsvariablen:

```yaml
env:
  - name: MYSQL_HOST
    value: "deine-rds-instanz.region.rds.amazonaws.com"
```

---

## NixOS-Deployment

NixOS bietet reproduzierbare Deployments mit deklarativer Konfiguration. Engelsystem ist in nixpkgs verfügbar.

### Das NixOS-Modul verwenden

Füge zu deiner NixOS-Konfiguration hinzu:

```nix
{ config, pkgs, ... }:

{
  services.engelsystem = {
    enable = true;
    domain = "angels.example.com";

    # Datenbankkonfiguration
    database = {
      host = "localhost";
      name = "engelsystem";
      user = "engelsystem";
      passwordFile = "/run/secrets/engelsystem-db-password";
    };
  };

  # Datenbank erstellen
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureDatabases = [ "engelsystem" ];
    ensureUsers = [
      {
        name = "engelsystem";
        ensurePermissions = {
          "engelsystem.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  # HTTPS mit ACME
  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@example.com";
  };

  services.nginx.virtualHosts."angels.example.com" = {
    enableACME = true;
    forceSSL = true;
  };
}
```

### Konfigurationsoptionen

Das NixOS-Modul unterstützt diese Optionen:

| Option | Beschreibung |
|--------|--------------|
| `services.engelsystem.enable` | Service aktivieren |
| `services.engelsystem.domain` | Domainname für die Instanz |
| `services.engelsystem.database.host` | Datenbank-Hostname |
| `services.engelsystem.database.name` | Datenbankname |
| `services.engelsystem.database.user` | Datenbank-Benutzername |
| `services.engelsystem.database.passwordFile` | Pfad zur Datei mit Datenbankpasswort |

Für zusätzliche Konfiguration erstelle eine Config-Datei:

```nix
{
  services.engelsystem.settings = {
    app_name = "Mein Event Angels";
    timezone = "Europe/Berlin";
    goodie_type = "tshirt";
  };
}
```

### Secrets-Verwaltung

Verwende agenix oder sops-nix für sichere Passwortverwaltung:

```nix
{
  age.secrets.engelsystem-db-password = {
    file = ./secrets/engelsystem-db-password.age;
    owner = "engelsystem";
  };

  services.engelsystem.database.passwordFile =
    config.age.secrets.engelsystem-db-password.path;
}
```

---

## Traditionelles Deployment

Deploye auf einem Standard-Linux-Server mit nginx oder Apache. Dieser Ansatz gibt dir die meiste Kontrolle, erfordert aber manuelle Abhängigkeitsverwaltung.

### Installationsschritte

Klone das Repository:

```bash
cd /var/www
git clone https://github.com/engelsystem/engelsystem.git
cd engelsystem
```

Installiere PHP-Abhängigkeiten:

```bash
composer install --no-dev --optimize-autoloader
```

Baue Frontend-Assets:

```bash
yarn install
yarn build
```

Setze Berechtigungen:

```bash
chown -R www-data:www-data storage/
chmod -R 775 storage/
```

Erstelle Konfiguration:

```bash
cp config/config.default.php config/config.php
```

Bearbeite `config/config.php` mit deinen Datenbank-Zugangsdaten und Einstellungen.

### Datenbank-Setup

Erstelle die Datenbank:

```sql
CREATE DATABASE engelsystem CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'engelsystem'@'localhost' IDENTIFIED BY 'dein-sicheres-passwort';
GRANT ALL PRIVILEGES ON engelsystem.* TO 'engelsystem'@'localhost';
FLUSH PRIVILEGES;
```

Führe Migrationen aus:

```bash
./bin/migrate
```

### nginx-Konfiguration

```nginx
server {
    listen 80;
    server_name angels.example.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name angels.example.com;
    root /var/www/engelsystem/public;
    index index.php;

    ssl_certificate /etc/letsencrypt/live/angels.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/angels.example.com/privkey.pem;

    # Security-Header
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    # Zugriff auf versteckte Dateien blockieren
    location ~ /\.(?!well-known).* {
        deny all;
    }

    # Statische Assets cachen
    location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
}
```

### Apache-Konfiguration

Aktiviere erforderliche Module:

```bash
a2enmod rewrite ssl
```

Erstelle Virtual Host:

```apache
<VirtualHost *:80>
    ServerName angels.example.com
    Redirect permanent / https://angels.example.com/
</VirtualHost>

<VirtualHost *:443>
    ServerName angels.example.com
    DocumentRoot /var/www/engelsystem/public

    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/angels.example.com/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/angels.example.com/privkey.pem

    <Directory /var/www/engelsystem/public>
        AllowOverride All
        Require all granted
    </Directory>

    Header always set X-Frame-Options "SAMEORIGIN"
    Header always set X-Content-Type-Options "nosniff"
</VirtualHost>
```

---

## Schritte nach der Installation

Unabhängig von der Deployment-Methode führe diese Schritte nach der Installation durch.

### Standard-Zugangsdaten ändern

{{% notice warning %}}
Die Standardinstallation enthält ein Admin-Konto mit Benutzername `admin` und Passwort `asdfasdf`. **Ändere dieses Passwort sofort.** Standard-Zugangsdaten zu belassen ist eine kritische Sicherheitslücke.
{{% /notice %}}

1. Navigiere zu deiner Engelsystem-URL
2. Melde dich mit `admin` / `asdfasdf` an
3. Gehe zu Einstellungen und ändere dein Passwort
4. Erwäge, persönliche Admin-Konten zu erstellen und das Standardkonto zu deaktivieren

### Dein Event konfigurieren

1. Setze den Anwendungsnamen in der Konfiguration
2. Konfiguriere Engeltypen für deine Freiwilligenkategorien
3. Richte Orte ein, an denen Schichten stattfinden
4. Konfiguriere Schichttypen
5. Setze Gutschein- und Goodie-Einstellungen

### E-Mail-Zustellung testen

Sende eine Testnachricht um zu verifizieren, dass die E-Mail-Konfiguration funktioniert. Defekte E-Mail bedeutet, dass Freiwillige keine wichtigen Benachrichtigungen erhalten.

---

## Updates

### Docker

```bash
docker compose pull
docker compose up -d
```

Migrationen laufen automatisch beim Start.

### Kubernetes

```bash
kubectl set image deployment/engelsystem \
  engelsystem=engelsystem/engelsystem:latest \
  -n engelsystem
```

### NixOS

Aktualisiere deinen nixpkgs-Channel und baue neu:

```bash
nixos-rebuild switch
```

### Traditionell

```bash
cd /var/www/engelsystem
git pull origin main
composer install --no-dev --optimize-autoloader
yarn install
yarn build
./bin/migrate
sudo systemctl restart php8.2-fpm
```

---

## Backup und Wiederherstellung

### Datenbank-Backup

**Docker:**
```bash
docker compose exec db mysqldump -u engelsystem -p engelsystem > backup-$(date +%Y%m%d).sql
```

**Traditionell:**
```bash
mysqldump -u engelsystem -p engelsystem > backup-$(date +%Y%m%d).sql
```

### Konfigurations-Backup

Sichere diese Dateien:
- `config/config.php` - Deine Konfiguration
- Datenbank-Dump
- `storage/` - Logs (optional)

### Wiederherstellung

1. Deploye eine frische Engelsystem-Instanz
2. Stelle die Konfigurationsdatei wieder her
3. Importiere den Datenbank-Dump: `mysql engelsystem < backup.sql`
4. Führe Migrationen bei Upgrades aus: `./bin/migrate`

---

## Fehlerbehebung

### Anwendung startet nicht

Prüfe Logs:
- **Docker**: `docker compose logs engelsystem`
- **Kubernetes**: `kubectl logs -n engelsystem deployment/engelsystem`
- **Traditionell**: Prüfe `storage/logs/` und Webserver-Fehlerlogs

### Datenbankverbindungsfehler

Verifiziere:
- Datenbankserver läuft
- Zugangsdaten sind korrekt
- Datenbankbenutzer hat erforderliche Berechtigungen
- Netzwerk/Firewall erlaubt Verbindung

### Berechtigungsfehler

Stelle sicher, dass der Webserver-Benutzer in `storage/` schreiben kann:

```bash
chown -R www-data:www-data storage/
chmod -R 775 storage/
```

### Migrationen schlagen fehl

Prüfe, ob der Datenbankbenutzer CREATE-, ALTER-, DROP- und INDEX-Berechtigungen hat. Für Updates musst du möglicherweise Migrationen manuell ausführen:

```bash
./bin/migrate
```

