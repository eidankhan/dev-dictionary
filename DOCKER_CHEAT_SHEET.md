# 🐳 Docker Command Guide for Dev Containers

## 🔧 Container Management

| Task                  | Command                                            |
|-----------------------|----------------------------------------------------|
| List running containers | `docker ps`                                      |
| List all containers     | `docker ps -a`                                   |
| Stop a container        | `docker stop <container_name>`                  |
| Remove a container      | `docker rm <container_name>`                    |
| Restart a container     | `docker restart <container_name>`              |
| View logs               | `docker logs -f <container_name>`              |
| Open shell in container | `docker exec -it <container_name> bash`        |

---

## 🧱 Image Management

| Task                | Command                                |
|---------------------|----------------------------------------|
| List all images     | `docker images`                        |
| Remove image        | `docker rmi <image_id>`                |
| Remove all images   | `docker rmi $(docker images -q)`       |
| Build image         | `docker build -t <image_name> .`       |

---

## 🧼 System Cleanup

| Task                         | Command                                  |
|------------------------------|------------------------------------------|
| Remove all containers        | `docker rm $(docker ps -aq)`            |
| Remove all images            | `docker rmi $(docker images -q)`        |
| Prune system (safe cleanup)  | `docker system prune -af --volumes`     |

---

## 🧰 Docker Compose

| Task                | Command               |
|---------------------|------------------------|
| Start services      | `docker-compose up -d` |
| Stop services       | `docker-compose down`  |
| Rebuild             | `docker-compose build` |

---

## 🐬 Example: Start MySQL Container

```bash
docker run --name mysql-casino \
  -e MYSQL_ROOT_PASSWORD=12@67 \
  -e MYSQL_DATABASE=dream_v4_casino \
  -p 3307:3306 \
  -d mysql:8.0
