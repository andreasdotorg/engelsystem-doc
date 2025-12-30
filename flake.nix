{
  description = "Engelsystem documentation - Hugo static site with hardened Docker container";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    hugo-relearn-theme = {
      url = "github:McShelby/hugo-theme-relearn";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, hugo-relearn-theme }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Linux pkgs for Docker images (containers always run Linux)
        linuxSystem = if system == "aarch64-darwin" then "aarch64-linux"
                      else if system == "x86_64-darwin" then "x86_64-linux"
                      else system;
        linuxPkgs = nixpkgs.legacyPackages.${linuxSystem};

        # Build the static site with Hugo (platform-independent output)
        staticSite = pkgs.stdenv.mkDerivation {
          pname = "engelsystem-doc";
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = [ pkgs.hugo ];

          buildPhase = ''
            # Link the theme from the flake input
            mkdir -p themes
            ln -s ${hugo-relearn-theme} themes/relearn

            hugo --minify
          '';

          installPhase = ''
            mkdir -p $out
            cp -r public/* $out/
          '';
        };

        # Minimal nginx configuration for static file serving (Linux paths for container)
        nginxConf = linuxPkgs.writeText "nginx.conf" ''
          worker_processes auto;
          error_log /dev/stderr warn;
          pid /tmp/nginx.pid;

          events {
            worker_connections 1024;
            use epoll;
            multi_accept on;
          }

          http {
            include ${linuxPkgs.nginx}/conf/mime.types;
            default_type application/octet-stream;

            log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                            '$status $body_bytes_sent "$http_referer" '
                            '"$http_user_agent"';

            access_log /dev/stdout main;

            sendfile on;
            tcp_nopush on;
            tcp_nodelay on;
            keepalive_timeout 65;
            types_hash_max_size 2048;

            # Security headers
            add_header X-Frame-Options "SAMEORIGIN" always;
            add_header X-Content-Type-Options "nosniff" always;
            add_header X-XSS-Protection "1; mode=block" always;
            add_header Referrer-Policy "strict-origin-when-cross-origin" always;
            add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; font-src 'self';" always;

            # Temp paths for non-root operation
            client_body_temp_path /tmp/client_body;
            proxy_temp_path /tmp/proxy;
            fastcgi_temp_path /tmp/fastcgi;
            uwsgi_temp_path /tmp/uwsgi;
            scgi_temp_path /tmp/scgi;

            # Gzip compression
            gzip on;
            gzip_vary on;
            gzip_proxied any;
            gzip_comp_level 6;
            gzip_types text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml;

            server {
              listen 8080;
              server_name _;
              index index.html;

              # Disable server tokens
              server_tokens off;

              # Redirect root to /doc/
              location = / {
                return 301 /doc/;
              }

              # Serve content under /doc/ path (matching baseURL)
              location /doc/ {
                alias /var/www/html/;
                try_files $uri $uri/ =404;

                # Cache static assets
                location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
                  expires 1y;
                  add_header Cache-Control "public, immutable";
                }
              }

              # Health check endpoint
              location /health {
                access_log off;
                return 200 "healthy\n";
                add_header Content-Type text/plain;
              }

              # Deny access to hidden files
              location ~ /\. {
                deny all;
                access_log off;
                log_not_found off;
              }
            }
          }
        '';

        # Kubernetes manifest for deployment
        k8sManifest = pkgs.writeText "engelsystem-doc.yaml" ''
          apiVersion: v1
          kind: Namespace
          metadata:
            name: engelsystem-doc
          ---
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: engelsystem-doc
            namespace: engelsystem-doc
            labels:
              app: engelsystem-doc
          spec:
            replicas: 1
            selector:
              matchLabels:
                app: engelsystem-doc
            template:
              metadata:
                labels:
                  app: engelsystem-doc
              spec:
                securityContext:
                  runAsNonRoot: true
                  runAsUser: 65534
                  runAsGroup: 65534
                  fsGroup: 65534
                containers:
                - name: nginx
                  image: engelsystem-doc:latest
                  imagePullPolicy: Never
                  ports:
                  - containerPort: 8080
                    name: http
                  resources:
                    limits:
                      memory: "128Mi"
                      cpu: "100m"
                    requests:
                      memory: "64Mi"
                      cpu: "50m"
                  securityContext:
                    allowPrivilegeEscalation: false
                    readOnlyRootFilesystem: false
                    capabilities:
                      drop:
                        - ALL
                  livenessProbe:
                    httpGet:
                      path: /health
                      port: 8080
                    initialDelaySeconds: 5
                    periodSeconds: 10
                  readinessProbe:
                    httpGet:
                      path: /health
                      port: 8080
                    initialDelaySeconds: 2
                    periodSeconds: 5
          ---
          apiVersion: v1
          kind: Service
          metadata:
            name: engelsystem-doc
            namespace: engelsystem-doc
          spec:
            type: NodePort
            selector:
              app: engelsystem-doc
            ports:
            - port: 80
              targetPort: 8080
              nodePort: 30080
        '';

        # Hardened Docker image (always Linux)
        dockerImage = linuxPkgs.dockerTools.buildLayeredImage {
          name = "engelsystem-doc";
          tag = "latest";

          contents = [
            linuxPkgs.nginx
            linuxPkgs.dockerTools.fakeNss
          ];

          extraCommands = ''
            # Create required directories
            mkdir -p var/www/html tmp var/log/nginx var/cache/nginx
            chmod 1777 tmp

            # Copy static site to web root
            cp -r ${staticSite}/* var/www/html/

            # Copy nginx config
            mkdir -p etc/nginx
            cp ${nginxConf} etc/nginx/nginx.conf
          '';

          config = {
            Cmd = [ "${linuxPkgs.nginx}/bin/nginx" "-c" "/etc/nginx/nginx.conf" "-g" "daemon off;" ];
            ExposedPorts = {
              "8080/tcp" = {};
            };
            User = "nobody:nobody";
            WorkingDir = "/var/www/html";

            # Hardening labels
            Labels = {
              "org.opencontainers.image.title" = "Engelsystem Documentation";
              "org.opencontainers.image.description" = "Hardened static site container for Engelsystem docs";
              "org.opencontainers.image.source" = "https://github.com/engelsystem/engelsystem-doc";
            };

            # Environment
            Env = [
              "NGINX_ENTRYPOINT_QUIET_LOGS=1"
            ];
          };
        };

      in {
        packages = {
          default = staticSite;
          site = staticSite;
          docker = dockerImage;
          k8s-manifest = k8sManifest;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.hugo
            pkgs.git
          ];

          shellHook = ''
            echo "Engelsystem Documentation Development Environment"
            echo ""
            echo "Available commands:"
            echo "  hugo server    - Start local development server"
            echo "  hugo           - Build static site"
            echo ""
            echo "Nix commands:"
            echo "  nix build              - Build static site to ./result"
            echo "  nix build .#docker     - Build Docker image"
            echo ""
            echo "Docker:"
            echo "  docker load < result"
            echo "  docker run -p 8080:8080 engelsystem-doc:latest"
            echo ""
            echo "Minikube:"
            echo "  nix run .#minikube-deploy   - Deploy to minikube"
            echo "  nix run .#minikube-stop     - Stop and clean up"
          '';
        };

        # Apps for easy running
        apps = {
          serve = {
            type = "app";
            program = toString (pkgs.writeShellScript "serve" ''
              cd ${staticSite}
              ${pkgs.python3}/bin/python -m http.server 8080
            '');
          };

          minikube-deploy = {
            type = "app";
            program = toString (pkgs.writeShellScript "minikube-deploy" ''
              set -e

              # Check for required commands
              command -v minikube >/dev/null 2>&1 || { echo "Error: minikube is not installed"; exit 1; }
              command -v kubectl >/dev/null 2>&1 || { echo "Error: kubectl is not installed"; exit 1; }

              echo "==> Checking minikube status..."
              if ! minikube status > /dev/null 2>&1; then
                echo "==> Starting minikube..."
                minikube start
              else
                echo "==> Minikube is already running"
              fi

              echo ""
              echo "==> Building Docker image..."
              nix build .#docker

              echo ""
              echo "==> Loading image into minikube..."
              minikube image load ${dockerImage}

              echo ""
              echo "==> Deploying to Kubernetes..."
              kubectl apply -f ${k8sManifest}

              echo ""
              echo "==> Waiting for deployment to be ready..."
              kubectl -n engelsystem-doc rollout status deployment/engelsystem-doc --timeout=60s

              echo ""
              echo "==> Deployment successful!"
              echo ""
              echo "Access the documentation at:"
              minikube service engelsystem-doc -n engelsystem-doc --url
              echo ""
              echo "Or open in browser with:"
              echo "  minikube service engelsystem-doc -n engelsystem-doc"
            '');
          };

          minikube-stop = {
            type = "app";
            program = toString (pkgs.writeShellScript "minikube-stop" ''
              set -e

              # Check for required commands
              command -v minikube >/dev/null 2>&1 || { echo "Error: minikube is not installed"; exit 1; }
              command -v kubectl >/dev/null 2>&1 || { echo "Error: kubectl is not installed"; exit 1; }

              echo "==> Deleting deployment..."
              kubectl delete -f ${k8sManifest} --ignore-not-found

              echo ""
              echo "==> Removing image from minikube..."
              minikube image rm engelsystem-doc:latest 2>/dev/null || true

              echo ""
              echo "==> Cleanup complete!"
              echo ""
              echo "To stop minikube entirely, run:"
              echo "  minikube stop"
            '');
          };
        };
      }
    );
}
