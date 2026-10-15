# Automated Web Build & Deployment Guide

This guide explains how the end-to-end automated system builds, pushes, and serves your Flutter web app on `192.168.1.64:8264`.

---

## 🚀 1. Local Automated Build & Push

Whenever you want to build and deploy a new web release, simply run this single command in PowerShell from the project root:

```powershell
.\deploy_web.ps1
```

### What `deploy_web.ps1` does automatically:
1. Compiles your Flutter application into an optimized release web build (`flutter build web --release`).
2. Targets the compiled `build/web` directory.
3. Automatically commits the build with a timestamp (`build: deploy flutter web release [YYYY-MM-DD HH:MM:SS]`).
4. Force pushes the updated build to the **`web-dist`** branch on Gitea (`http://192.168.1.64:8087/gitea/Ripal-Design-Flutter.git`).

---

## 🖥️ 2. Server Setup & Automated Deployment on `192.168.1.64`

Follow these instructions once on your server `192.168.1.64` (logged in as `agy`):

### Step A: Initial Web Directory & Git Setup

```bash
# 1. Create target web directory
sudo mkdir -p /var/www/ripal-design-web
sudo chown -R agy:agy /var/www/ripal-design-web

# 2. Clone the web-dist branch
git clone -b web-dist http://192.168.1.64:8087/gitea/Ripal-Design-Flutter.git /var/www/ripal-design-web
```

---

### Step B: Setup Nginx to Serve Port 8264

1. Create Nginx config file `/etc/nginx/sites-available/ripal-design-web.conf`:

```bash
sudo nano /etc/nginx/sites-available/ripal-design-web.conf
```

Paste the following content:

```nginx
server {
    listen 8264;
    server_name _;

    root /var/www/ripal-design-web;
    index index.html;

    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml text/javascript image/svg+xml;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location ~* \.(?:ico|css|js|gif|jpe?g|png|woff2?|eot|ttf|svg|otf|wasm)$ {
        expires 6m;
        add_header Cache-Control "public, max-age=15552000, immutable";
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }
}
```

2. Enable the site and test configuration:

```bash
sudo ln -sf /etc/nginx/sites-available/ripal-design-web.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

---

### Step C: Automate Server Updates (Choose Option 1 or Option 2)

#### 🔹 Option 1: Auto-Sync Cron Job (Every 1 Minute — Easiest)

Create an auto-pull script `/usr/local/bin/update-ripal-web.sh`:

```bash
sudo nano /usr/local/bin/update-ripal-web.sh
```

Paste this content:

```bash
#!/bin/bash
cd /var/www/ripal-design-web || exit
git fetch origin web-dist
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/web-dist)

if [ "$LOCAL" != "$REMOTE" ]; then
    echo "[$(date)] New web build detected. Deploying update..."
    git reset --hard origin/web-dist
    systemctl reload nginx
    echo "[$(date)] Web app updated successfully."
fi
```

Make it executable:

```bash
sudo chmod +x /usr/local/bin/update-ripal-web.sh
```

Add a cron job (`crontab -e`):

```cron
* * * * * /usr/local/bin/update-ripal-web.sh >> /var/log/ripal-web-deploy.log 2>&1
```

---

#### 🔹 Option 2: Instant Gitea Webhook Listener (Zero Delay)

1. Create a lightweight webhook listener script `/opt/web_deploy_listener.py`:

```python
#!/usr/bin/env python3
import http.server
import subprocess

PORT = 9000

class WebhookHandler(http.server.BaseHTTPRequestHandler):
    def do_POST(self):
        print("Webhook received! Syncing web release...")
        subprocess.run(["git", "-C", "/var/www/ripal-design-web", "fetch", "origin", "web-dist"])
        subprocess.run(["git", "-C", "/var/www/ripal-design-web", "reset", "--hard", "origin/web-dist"])
        subprocess.run(["systemctl", "reload", "nginx"])
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Deploy OK\n")

if __name__ == "__main__":
    server = http.server.HTTPServer(("0.0.0.0", PORT), WebhookHandler)
    print(f"Webhook listener running on port {PORT}...")
    server.serve_forever()
```

2. Run it as a systemd service or background process.
3. In Gitea Web UI: Go to **Repository Settings -> Webhooks -> Add Webhook**:
   - **Target URL**: `http://192.168.1.64:9000`
   - **Events**: Push events (`web-dist` branch)

---

## 🎯 Summary Workflow

1. **Developer**: Runs `.\deploy_web.ps1` locally in PowerShell.
2. **Gitea**: Automatically receives the latest `web-dist` release commit.
3. **Server**: Auto-pulls `web-dist` and serves the app instantly at **`http://192.168.1.64:8264`**.
