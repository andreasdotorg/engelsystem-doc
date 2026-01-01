---
title: "Installation"
date: 2019-02-13T19:35:37+01:00
weight: 10
---

This guide covers deploying Engelsystem using Docker, Kubernetes, NixOS, or a traditional PHP web server. Choose the method that best fits your infrastructure.

## Requirements

All deployment methods require:

- **Database**: MySQL 5.7+ or MariaDB 10.2+
- **PHP**: 8.2 or newer (for traditional deployment)
- **Memory**: 256MB minimum, 512MB+ recommended for larger events

For traditional deployments, you also need:
- Composer (PHP dependency manager)
- Node.js 20+ and Yarn (for building frontend assets)
- Web server (nginx or Apache)

The complete requirements list is in the [project README](https://github.com/engelsystem/engelsystem?tab=readme-ov-file#requirements).

---

## Docker Deployment

Docker is the recommended approach for most deployments. It provides consistent environments and simplifies updates.

### Quick Start

Create a `docker-compose.yml`:

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
      MYSQL_PASSWORD: changeme
      APP_NAME: "My Event Angels"
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
      MYSQL_PASSWORD: changeme
      MYSQL_ROOT_PASSWORD: rootchangeme
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

Start the stack:

```bash
docker compose up -d
```

Access Engelsystem at `http://localhost:8080`. The first startup runs database migrations automatically.

### Production Configuration

For production deployments, add these considerations:

**Persistent configuration:**

Create a `config/config.php` file and mount it:

```yaml
services:
  engelsystem:
    volumes:
      - ./config/config.php:/var/www/config/config.php:ro
```

**HTTPS with reverse proxy:**

Run Engelsystem behind a reverse proxy like Traefik or nginx-proxy:

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

**Log persistence:**

Mount the storage directory to preserve logs:

```yaml
volumes:
  - ./storage:/var/www/storage
```

**Database backups:**

Add a backup service or schedule `mysqldump` from the host:

```bash
docker compose exec db mysqldump -u engelsystem -pchangeme engelsystem > backup.sql
```

### Building Custom Images

If you need to customize the image (custom themes, patches):

```bash
git clone https://github.com/engelsystem/engelsystem.git
cd engelsystem
docker build -t my-engelsystem .
```

Then use `my-engelsystem` instead of `engelsystem/engelsystem:latest` in your compose file.

---

## Kubernetes Deployment

Kubernetes deployments are ideal for larger events requiring high availability, automatic scaling, or integration with existing cluster infrastructure.

### Prerequisites

- Kubernetes cluster (1.20+)
- kubectl configured
- Ingress controller (nginx-ingress, Traefik, etc.)
- Persistent storage provisioner
- External database or in-cluster MySQL/MariaDB

### Deployment Manifests

Create a namespace:

```yaml
# namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: engelsystem
```

Create secrets for sensitive data:

```yaml
# secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: engelsystem-secrets
  namespace: engelsystem
type: Opaque
stringData:
  mysql-password: "your-secure-password"
  mysql-root-password: "your-root-password"
```

Deploy MariaDB (or use an external database):

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

Create ConfigMap for application configuration:

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

Deploy Engelsystem:

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

Create Ingress for external access:

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

Apply all manifests:

```bash
kubectl apply -f namespace.yaml
kubectl apply -f secrets.yaml
kubectl apply -f mariadb.yaml
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl apply -f ingress.yaml
```

### Scaling

Increase replicas for higher availability:

```bash
kubectl scale deployment engelsystem -n engelsystem --replicas=4
```

For automatic scaling based on load:

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

### Using External Database

For production, consider using a managed database service. Update the deployment environment variables:

```yaml
env:
  - name: MYSQL_HOST
    value: "your-rds-instance.region.rds.amazonaws.com"
```

---

## NixOS Deployment

NixOS provides reproducible deployments with declarative configuration. Engelsystem is available in nixpkgs.

### Using the NixOS Module

Add to your NixOS configuration:

```nix
{ config, pkgs, ... }:

{
  services.engelsystem = {
    enable = true;
    domain = "angels.example.com";

    # Database configuration
    database = {
      host = "localhost";
      name = "engelsystem";
      user = "engelsystem";
      passwordFile = "/run/secrets/engelsystem-db-password";
    };
  };

  # Create the database
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

  # HTTPS with ACME
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

### Configuration Options

The NixOS module supports these options:

| Option | Description |
|--------|-------------|
| `services.engelsystem.enable` | Enable the service |
| `services.engelsystem.domain` | Domain name for the instance |
| `services.engelsystem.database.host` | Database hostname |
| `services.engelsystem.database.name` | Database name |
| `services.engelsystem.database.user` | Database username |
| `services.engelsystem.database.passwordFile` | Path to file containing database password |

For additional configuration, create a config file:

```nix
{
  services.engelsystem.settings = {
    app_name = "My Event Angels";
    timezone = "Europe/Berlin";
    goodie_type = "tshirt";
  };
}
```

### Secrets Management

Use agenix or sops-nix for secure password management:

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

## Traditional Deployment

Deploy on a standard Linux server with nginx or Apache. This approach gives you the most control but requires manual dependency management.

### Installation Steps

Clone the repository:

```bash
cd /var/www
git clone https://github.com/engelsystem/engelsystem.git
cd engelsystem
```

Install PHP dependencies:

```bash
composer install --no-dev --optimize-autoloader
```

Build frontend assets:

```bash
yarn install
yarn build
```

Set permissions:

```bash
chown -R www-data:www-data storage/
chmod -R 775 storage/
```

Create configuration:

```bash
cp config/config.default.php config/config.php
```

Edit `config/config.php` with your database credentials and settings.

### Database Setup

Create the database:

```sql
CREATE DATABASE engelsystem CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'engelsystem'@'localhost' IDENTIFIED BY 'your-secure-password';
GRANT ALL PRIVILEGES ON engelsystem.* TO 'engelsystem'@'localhost';
FLUSH PRIVILEGES;
```

Run migrations:

```bash
./bin/migrate
```

### nginx Configuration

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

    # Security headers
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

    # Block access to hidden files
    location ~ /\.(?!well-known).* {
        deny all;
    }

    # Cache static assets
    location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
}
```

### Apache Configuration

Enable required modules:

```bash
a2enmod rewrite ssl
```

Create virtual host:

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

## Post-Installation Steps

Regardless of deployment method, complete these steps after installation.

### Change Default Credentials

{{% notice warning %}}
The default installation includes an admin account with username `admin` and password `asdfasdf`. **Change this password immediately.** Leaving default credentials is a critical security vulnerability.
{{% /notice %}}

1. Navigate to your Engelsystem URL
2. Log in with `admin` / `asdfasdf`
3. Go to Settings and change your password
4. Consider creating personal admin accounts and disabling the default one

### Configure Your Event

1. Set the application name in configuration
2. Configure angel types for your volunteer categories
3. Set up locations where shifts will take place
4. Configure shift types
5. Set voucher and goodie settings

### Test Email Delivery

Send a test message to verify email configuration works. Broken email means volunteers won't receive important notifications.

---

## Updating

### Docker

```bash
docker compose pull
docker compose up -d
```

Migrations run automatically on startup.

### Kubernetes

```bash
kubectl set image deployment/engelsystem \
  engelsystem=engelsystem/engelsystem:latest \
  -n engelsystem
```

### NixOS

Update your nixpkgs channel and rebuild:

```bash
nixos-rebuild switch
```

### Traditional

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

## Backup and Recovery

### Database Backup

**Docker:**
```bash
docker compose exec db mysqldump -u engelsystem -p engelsystem > backup-$(date +%Y%m%d).sql
```

**Traditional:**
```bash
mysqldump -u engelsystem -p engelsystem > backup-$(date +%Y%m%d).sql
```

### Configuration Backup

Back up these files:
- `config/config.php` - Your configuration
- Database dump
- `storage/` - Logs (optional)

### Recovery

1. Deploy fresh Engelsystem instance
2. Restore configuration file
3. Import database dump: `mysql engelsystem < backup.sql`
4. Run migrations if upgrading: `./bin/migrate`

---

## Troubleshooting

### Application won't start

Check logs:
- **Docker**: `docker compose logs engelsystem`
- **Kubernetes**: `kubectl logs -n engelsystem deployment/engelsystem`
- **Traditional**: Check `storage/logs/` and web server error logs

### Database connection errors

Verify:
- Database server is running
- Credentials are correct
- Database user has required privileges
- Network/firewall allows connection

### Permission errors

Ensure the web server user can write to `storage/`:

```bash
chown -R www-data:www-data storage/
chmod -R 775 storage/
```

### Migrations fail

Check database user has CREATE, ALTER, DROP, and INDEX privileges. For updates, you may need to run migrations manually:

```bash
./bin/migrate
```
