
# Setting Up `transcripto.dev` with IONOS VPS and Nginx

## 1. Prerequisites

* IONOS VPS with public IP (e.g., `xx.154.x.230`)
* Domain `transcripto.dev` managed in IONOS
* Nginx installed on VPS
* SSL certificates available at `/etc/ssl/transcripto/`

## 2. Point Domain to VPS

1. Log into [IONOS Domain Management](https://my.ionos.co.uk/domains).
2. Go to **DNS Settings** for `transcripto.dev`.
3. Add or update DNS records:

   * **A Record**

     * Hostname: `@`
     * Value: `<VPS IP>` (e.g., `yyy.x.bb.vv`)
   * Optional **CNAME Record** for `www`

     * Hostname: `www`
     * Value: `transcripto.dev`
4. Wait for DNS propagation (usually a few minutes; max 24 hours).

Check DNS resolution:

```bash
dig +short transcripto.dev
```

---

## 3. Configure Nginx

Create a new Nginx server block:

```bash
sudo nano /etc/nginx/sites-available/transcripto.dev
```

Minimal configuration using existing SSL certs:

```nginx
server {
    listen 80;
    server_name transcripto.dev www.transcripto.dev;

    # Redirect HTTP → HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name transcripto.dev www.transcripto.dev;

    ssl_certificate /etc/ssl/transcripto/fullchain.crt;
    ssl_certificate_key /etc/ssl/transcripto/private.key;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    # Serve Nginx default page for now
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

Enable site and reload Nginx:

```bash
sudo ln -s /etc/nginx/sites-available/transcripto.dev /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

---

## 4. Verify

* Visit `https://transcripto.dev` → should show default Nginx page
* Visit `http://transcripto.dev` → auto-redirects to HTTPS

> Note: `.dev` domains enforce HTTPS (HSTS), so HTTP will always redirect.

---

## 5. Deploying Custom Static Projects Later

1. Place your project in a folder, e.g., `/var/www/transcripto`.
2. Update the Nginx `root` directive:

```nginx
root /var/www/transcripto;
index index.html;
```

3. Reload Nginx:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

Now your custom project is live at `https://transcripto.dev`.



> This setup allows your domain to work over HTTPS mmediately and makes it easy to switch projects in the uture by just updating the `root` path.

----
> # Setting Up **Docker + Nginx + subdomain (`api.transcripto.dev`)** on IONOZ VPS.

## 🚀 Step 1: DNS (already done)

* You created the `api.transcripto.dev` subdomain and pointed it to your VPS IP.
* Confirmed with:

  ```bash
  dig +short api.transcripto.dev
  ```
  ✅ So DNS is good.

## 🚀 Step 2: Run Your FastAPI Project with Docker Compose

From your project folder (where `docker-compose.yml` lives):

```bash
docker-compose up -d --build
```
* This starts **3 containers**:

  * `fastapi-yt-transcript-extractor` → FastAPI app (port 8000 inside container, mapped to 8000 on VPS)
  * `fastapi-postgres` → PostgreSQL DB
  * `fastapi-redis` → Redis cache

⚠️ Your API will now be accessible at:
`http://<VPS-IP>:8000`

(but we don’t expose it directly, we’ll use **Nginx** + `https://api.transcripto.dev` instead).

## 🚀 Step 3: Nginx Config for `api.transcripto.dev`

Create new config file:

```bash
sudo nano /etc/nginx/sites-available/api.transcripto.dev
```

Paste this config (adapted for Docker):

```nginx
server {
    listen 80;
    server_name api.transcripto.dev;

    # Redirect HTTP → HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name api.transcripto.dev;

    ssl_certificate /etc/ssl/transcripto/fullchain.crt;
    ssl_certificate_key /etc/ssl/transcripto/private.key;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    location / {
        proxy_pass http://127.0.0.1:8000;   # container is mapped to host:8000
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
Save + exit (`CTRL+O`, Enter, `CTRL+X`).

## 🚀 Step 4: Enable Config + Reload Nginx

```bash
sudo ln -s /etc/nginx/sites-available/api.transcripto.dev /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```
## 🚀 Step 5: Test Subdomain

Now open browser and visit:

* `https://api.transcripto.dev/docs` → FastAPI Swagger UI should load
* `https://api.transcripto.dev?videoId=abcd1234` → should hit your transcript endpoint

✅ At this point:
* `transcripto.dev` → serves your static site (from `/usr/share/nginx/html`)
* `api.transcripto.dev` → proxies to your FastAPI running inside Docker
---
