# TrackerApp — Vue 3 + Vite

A Vue 3 task tracker application with a full DevSecOps pipeline using Docker and GitHub Actions.

## Project Setup

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

### Compile and Minify for Production

```sh
npm run build
```

---

## Docker

The app is containerised using a **multi-stage Dockerfile**:

| Stage     | Base image            | Purpose                                                            |
| --------- | --------------------- | ------------------------------------------------------------------ |
| `builder` | `node:23.11.1-alpine` | Installs dependencies and runs `npm run build`                     |
| `runner`  | `nginx:alpine`        | Serves the compiled `dist/` folder — no Node.js in the final image |

Alpine packages are upgraded at build time to pull in the latest security patches.

### Run with Docker Compose

```sh
docker compose up -d
```

The app will be available at `http://localhost:4173`.

---

## CI/CD — GitHub Actions

All workflows live in [.github/workflows/](.github/workflows/).

### DevSecOps Pipeline (`devsecops-pipeline.yml`)

The main end-to-end pipeline, triggered manually via `workflow_dispatch`. It runs every CI job in parallel first, then chains the CD steps once they all pass:

```
code-quality ─┐
secret-scan   ├─► build (Docker Build & Push) ─► trivy (Image Scan) ─► deploy
dependency-scan┘
docker-lint  ─┘
```

### Individual Workflows

| Workflow                 | File                    | Trigger             | What it does                                                                                                            |
| ------------------------ | ----------------------- | ------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Code Quality**         | `code-quality.yml`      | `workflow_call`     | Runs ESLint and Prettier checks; runs GitHub CodeQL SAST analysis on the JavaScript source                              |
| **Secrets Scan**         | `secrets-scan.yml`      | `workflow_call`     | Scans the full git history with **GitLeaks** to detect any accidentally committed secrets or API keys                   |
| **Dependency Scan**      | `dependency-scan.yml`   | `workflow_call`     | Runs `npm audit` at `moderate` severity level and lists outdated packages                                               |
| **Docker Lint**          | `docker-lint.yml`       | `workflow_call`     | Lints the `Dockerfile` with **Hadolint** to catch best-practice violations                                              |
| **Docker Build & Push**  | `docker-build-push.yml` | `workflow_call`     | Builds the Docker image and pushes it to Docker Hub tagged with both the branch name and the commit SHA                 |
| **Image Scan**           | `image-scan.yml`        | `workflow_call`     | Scans the pushed image with **Trivy** and fails the pipeline on any `CRITICAL` vulnerabilities                          |
| **Deploy to Server**     | `deploy-to-server.yml`  | `workflow_call`     | SSHes into an EC2 instance, copies `docker-compose.yml`, installs Docker, and runs `docker compose up` to start the app |
| **Deploy (self-hosted)** | `deploy.yml`            | `workflow_dispatch` | Runs `docker compose up -d --build` directly on a self-hosted runner                                                    |
| **CI/CD**                | `main.yml`              | `workflow_dispatch` | Lightweight sequential pipeline: checkout → build → test → deploy (each step is a stub for extending)                   |
