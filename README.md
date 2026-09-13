# Python + FastAPI - DevOps Practice Target

A tiny, real, runnable FastAPI REST API. Your job isn't to write it - it's to **build it, ship it, run it, and keep it alive.** This is one of the 10 deployment practice targets: take it on the same journey you took TaskBoard (Dockerize -> Compose -> CI/CD -> VM -> Kubernetes -> AWS).

---

## The 7 DevOps Questions

This is the only homework the app gives you. Answer these and the rest of the recipe never changes.

| # | Question | Answer for this app |
|---|----------|---------------------|
| 1 | **Language / runtime?** | Python 3.11 |
| 2 | **How do you build it?** | `pip install -r requirements.txt` |
| 3 | **What's the artifact?** | The source code + its virtual environment (`venv`) of installed dependencies |
| 4 | **Start command?** | `uvicorn main:app --host 0.0.0.0 --port 8000` |
| 5 | **Which port?** | `8000` (override with the `PORT` env var) |
| 6 | **Config / secrets?** | Environment variables - e.g. `PORT`. Never hardcode config! |
| 7 | **Health check URL?** | `/health` -> returns `{"status":"ok"}` with HTTP 200 |

> 🎁 **Bonus:** FastAPI gives you interactive Swagger API docs for free at **`/docs`** (and ReDoc at `/redoc`). Open it in a browser once the app is running - great for a quick "does it work?" sanity check.

---

## Run it locally

You need Python 3.11+ installed. From inside this folder:

```bash
# 1. Create and activate a virtual environment
python -m venv venv

# macOS / Linux:
source venv/bin/activate
# Windows (PowerShell):
venv\Scripts\Activate.ps1

# 2. Install dependencies (the "build" step)
pip install -r requirements.txt

# 3. Start the server
uvicorn main:app --host 0.0.0.0 --port 8000
```

The app is now live at `http://localhost:8000`. Open a **second** terminal and hit all 3 endpoints:

```bash
curl http://localhost:8000/
# {"message":"Welcome! This is a DevOps practice target.","stack":"Python + FastAPI (served by uvicorn)"}

curl http://localhost:8000/health
# {"status":"ok"}

curl http://localhost:8000/api/items
# [{"id":1,"name":"Widget","price":9.99},{"id":2,"name":"Gadget","price":14.5},{"id":3,"name":"Gizmo","price":7.25},{"id":4,"name":"Doohickey","price":21.0}]
```

Want a different port? Set the env var (12-factor style):

```bash
PORT=9000 uvicorn main:app --host 0.0.0.0 --port 9000
```

Then browse to `http://localhost:8000/docs` to see the free Swagger UI.

---

## Your Practice Mission

The app ships **on purpose with no DevOps files** - no `Dockerfile`, no `Jenkinsfile`, no `docker-compose.yml`, no Kubernetes YAML, no Terraform. **Building those is the practice.** You already learned how on TaskBoard; now prove you can do it on a stack you might not have touched before. If you get stuck, open the matching TaskBoard module and adapt its files - the pattern transfers directly.

Work down this checklist:

- [ ] **Dockerize it** - write a `Dockerfile` (base `python:3.11-slim`), build an image, run a container. -> **M14**
- [ ] **Compose it** - wrap it in a `docker-compose.yml` (this app needs no DB, but practice the format). -> **M15**
- [ ] **CI/CD it** - write a `Jenkinsfile`: build -> test -> build image -> deploy. -> **M17**
- [ ] **VM it** - run it on a Vagrant / VirtualBox VM. -> **M13**
- [ ] **Provision it** - configure the server with an Ansible playbook. -> **M16**
- [ ] **Orchestrate it** - Kubernetes Deployment + Service + Ingress, then scale it. -> **M18 / M19**
- [ ] **Go to cloud** - deploy live on AWS (EC2), then make it reproducible with Terraform. -> **M20 / M21**

> 💪 **The goal:** handing you *any* repo in *any* language and saying "ship it" should feel routine. That's a job-ready DevOps engineer.
