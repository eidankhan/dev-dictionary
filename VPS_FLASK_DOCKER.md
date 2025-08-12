# 🚀 Deploying a Dockerized Flask App on IONOS VPS

This guide documents the full process of connecting to your IONOS VPS and deploying a Flask app using Docker and Docker Compose.

---

## 🖥️ 1. Connect to Your VPS

Once your IONOS VPS is created, log in using SSH with the initial root password:

```bash
ssh root@your_vps_ip
```

---

## 🛠️ 2. Install Essentials

Update the system and install required packages:

```bash
apt update && apt upgrade -y
apt install curl git wget unzip -y
```

---

## 🐳 3. Install Docker

Install Docker from the default repository:

```bash
apt install docker.io -y
systemctl start docker
systemctl enable docker
docker --version
```

---

## 🐙 4. Install Docker Compose

Download and install Docker Compose:

```bash
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

---

## 📁 5. Set Up Your Flask App

Assume your project structure:

```
yt-transcript-api/
├── app.py
├── requirements.txt
├── Dockerfile
└── docker-compose.yml
```

### Example Dockerfile

```Dockerfile
FROM python:3.10-slim

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
```

### Example requirements.txt

```txt
Flask
```

### Example docker-compose.yml

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "5000:5000"
    restart: always
```

---

## 🏗️ 6. Build and Run the App

Navigate into your app folder and run:

```bash
docker-compose up --build -d
```

Check container status:

```bash
docker ps
```

---

## 🌐 7. Test App Locally on VPS

```bash
curl http://localhost:5000
curl http://your_vps_ip:5000
```

---

## 🔐 8. Configure Ubuntu Firewall (UFW)

Enable and allow necessary ports:

```bash
ufw allow 5000
ufw enable
ufw status
```

---

## 🛡️ 9. IONOS Cloud Firewall Settings

In the IONOS Cloud Panel:

1. Go to **Servers & Cloud** > Your VPS
2. Open **Network > Firewall Policies**
3. Ensure an **inbound rule** exists:

| Direction | Protocol | Port | Source IP | Action |
|-----------|----------|------|-----------|--------|
| Inbound   | TCP      | 5000 | 0.0.0.0/0 | Allow  |

---

## ✅ 10. Verify in Your Browser

Visit:
```
http://your_vps_ip:5000
```

---

## 🧼 (Optional) Run on Port 80

Update `docker-compose.yml`:

```yaml
ports:
  - "80:5000"
```

Then:

```bash
ufw allow 80
docker-compose down
docker-compose up --build -d
```

Access via:
```
http://your_vps_ip
```

---

## 🏁 Done!

Your Dockerized Flask app is now live on your VPS 🎉
