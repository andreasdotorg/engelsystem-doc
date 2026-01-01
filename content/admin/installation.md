---
title: "Installation"
date: 2019-02-13T19:35:37+01:00
weight: 10
---

# Installation

This guide covers different methods to deploy Engelsystem.

## Requirements

- PHP 8.2+ with required extensions
- MySQL 5.7+ or MariaDB 10.2+
- Web server (nginx or Apache) or PHP built-in server
- Composer (for traditional deployment)
- Node.js 20+ and Yarn (for building frontend assets)

The full list of requirements is in the [readme](https://github.com/engelsystem/engelsystem?tab=readme-ov-file#requirements).

## Deployment Methods

### Traditional Deployment

For hosting on a standard web server:

```bash
# Clone repository
git clone https://github.com/engelsystem/engelsystem.git
cd engelsystem

# Install dependencies
composer install --no-dev --optimize-autoloader
yarn install
yarn build

# Configure
cp config/config.default.php config/config.php
# Edit config/config.php with your database settings

# Set permissions
chmod -R 777 storage/

# Run migrations
./bin/migrate
```

### Docker Deployment

Build and run with Docker:

```bash
# Build image
docker build -t engelsystem .

# Run with docker-compose
docker-compose up -d
```

Example `docker-compose.yml`:

```yaml
version: '3'
services:
  app:
    image: engelsystem
    ports:
      - "5080:80"
    environment:
      - MYSQL_HOST=db
      - MYSQL_DATABASE=engelsystem
      - MYSQL_USER=engelsystem
      - MYSQL_PASSWORD=secret
    depends_on:
      - db

  db:
    image: mariadb:10.7
    environment:
      - MYSQL_DATABASE=engelsystem
      - MYSQL_USER=engelsystem
      - MYSQL_PASSWORD=secret
      - MYSQL_ROOT_PASSWORD=rootsecret
    volumes:
      - db_data:/var/lib/mysql

volumes:
  db_data:
```

### Nix Deployment

Using the Nix flake:

```bash
# Build package
nix build .#engelsystem

# Run with configuration
nix run .#engelsystem-serve
```

For NixOS, use the module:

```nix
{
  imports = [ engelsystem.nixosModules.default ];

  services.engelsystem = {
    enable = true;
    domain = "engelsystem.example.com";
    database = {
      host = "localhost";
      name = "engelsystem";
      user = "engelsystem";
      passwordFile = "/run/secrets/engelsystem-db";
    };
  };
}
```

### Kubernetes Deployment

The CI/CD pipeline includes Kubernetes support. Key resources:

- Deployment for application pods
- Service for internal networking
- Ingress for external access
- ConfigMap for configuration
- Secret for sensitive data

## Database Setup

Create the database and user:

```sql
CREATE DATABASE engelsystem CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'engelsystem'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON engelsystem.* TO 'engelsystem'@'localhost';
FLUSH PRIVILEGES;
```

Then run migrations:

```bash
./bin/migrate
```

For release archives, import the provided `install.sql` instead.

## Configuration

Create a minimal configuration file:

```bash
echo '<?php
return [
  // Your configuration here
];' > config/config.php
```

Or copy the defaults:

```bash
cp config/config.default.php config/config.php
```

The first approach is recommended - only override settings you need to change. See [Configuration]({{% ref "configuration" %}}) for all options.

At minimum, configure:

- Database connection (`database` array)
- Application URL
- Email settings if sending notifications

## Web Server Configuration

### nginx

```nginx
server {
    listen 80;
    server_name engelsystem.example.com;
    root /var/www/engelsystem/public;
    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
```

### Apache

```apache
<VirtualHost *:80>
    ServerName engelsystem.example.com
    DocumentRoot /var/www/engelsystem/public

    <Directory /var/www/engelsystem/public>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

## HTTPS Requirements

The application should be served over HTTPS. The default configuration includes:

- HSTS (HTTP Strict Transport Security) with 1-year max-age
- Security headers for XSS protection, content type sniffing, etc.

Ensure a valid TLS certificate is installed before enabling HSTS.

## First Login

{{% notice warning %}}
The default installation includes an admin account with credentials `admin` / `asdfasdf`. **Change this password immediately after your first login.** Leaving default credentials is a serious security risk.
{{% /notice %}}

After installation:

1. Navigate to your Engelsystem URL
2. Log in with the default admin account
3. Go to Settings and change your password
4. Configure the event through Admin settings

## Environment Variables

Configuration can also be set via environment variables:

| Variable | Description |
|----------|-------------|
| `MYSQL_HOST` | Database host |
| `MYSQL_DATABASE` | Database name |
| `MYSQL_USER` | Database username |
| `MYSQL_PASSWORD` | Database password |
| `APP_ENV` | Environment (production/development) |
| `APP_URL` | Application base URL |

## Updating

```bash
# Fetch updates
git pull origin main

# Update dependencies
composer install --no-dev --optimize-autoloader
yarn install
yarn build

# Run migrations
./bin/migrate

# Restart PHP-FPM if needed
sudo systemctl restart php8.2-fpm
```

## Backup

### Database

```bash
mysqldump -u engelsystem -p engelsystem > backup.sql
```

### Files

Back up:
- `config/config.php` - Your configuration
- Database dump
- `storage/` - Logs (optional)
