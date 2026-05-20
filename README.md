# DevSecOps CI/CD Pipeline

This repository is a fork of the original project and has been enhanced with a complete DevSecOps CI/CD pipeline implementation using GitHub Actions, Docker, and security scanning tools.

## 🚀 Pipeline Overview

The pipeline automates:

- Code quality checks
- Static Application Security Testing (SAST)
- Secret scanning
- Dependency vulnerability scanning
- Docker linting
- Docker image build & push
- Container image vulnerability scanning
- Deployment workflow

---

## 🔄 CI/CD Workflow Stages

### ✅ Code Quality & Security Checks

The pipeline performs multiple validation and security stages before deployment:

- **Lint** → Ensures code quality and formatting
- **SAST - CodeQL** → Static security analysis using GitHub CodeQL
- **Secret Scan** → Detects exposed secrets or credentials
- **Dependency Scan** → Checks vulnerable dependencies
- **Docker Lint** → Validates Dockerfile best practices

---

### 🐳 Build & Push

- Builds the Docker image
- Pushes the image to the configured container registry

---

### 🔍 Trivy Image Scan

- Scans Docker images for vulnerabilities using Trivy
- Helps ensure secure container deployments

---

### 🚀 Deployment

- Automated deployment stage integrated into the pipeline

---

## 🛠️ Technologies Used

- GitHub Actions
- Docker
- Docker Compose
- Trivy
- CodeQL
- DevSecOps Practices

---

## 📂 Pipeline File

```bash
.github/workflows/devsecops-pipeline.yml
