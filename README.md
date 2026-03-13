# 🛡️ DevSecOps-as-a-Service Boilerplate

> A production-ready, security-hardened CI/CD pipeline template — shifting security left from day one.

[![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?logo=githubactions&logoColor=white)](https://github.com/features/actions)
[![Docker](https://img.shields.io/badge/Docker-Hardened%20Build-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Security](https://img.shields.io/badge/Scanner-Trivy-1904DA?logo=aquasecurity&logoColor=white)](https://github.com/aquasecurity/trivy)
[![Python](https://img.shields.io/badge/App-Python%20Flask-3776AB?logo=python&logoColor=white)](https://flask.palletsprojects.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Pipeline](#pipeline)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Local Development](#local-development)
  - [Running the Pipeline](#running-the-pipeline)
- [Security Policy](#security-policy)
- [Project Structure](#project-structure)
- [References / Useful Resources](#references--useful-resources)
- [My Notes](#my-notes)

---

## Overview

**DevSecOps-as-a-Service Boilerplate** is a ready-to-fork template that demonstrates how to embed security into every stage of a modern software delivery pipeline — not as an afterthought, but as a first-class citizen.

It provides a **hardened Docker image**, **automated vulnerability scanning with Trivy**, and a **fail-fast enforcement policy** — all wired into a GitHub Actions workflow that runs on every push. No separate security tooling setup required.

> 📦 Open-source | `devsecops-boilerplate`
> 🔗 Created as part of the **DevSecOps-as-a-Service** portfolio.

---

## Key Features

| Feature | Description |
|---|---|
| 🐳 Hardened Docker Image | Multi-stage build with a non-root user to minimize attack surface |
| 🔍 Automated Scanning (Trivy) | Scans every push for OS-level and library-level vulnerabilities |
| 🚫 Fail-Fast Policy | Automatically blocks deployments if Critical or High CVEs are detected |
| ⚙️ IaC Ready | Designed to be paired with Terraform-hardened infrastructure modules |
| 🤖 GitHub Actions Native | Zero external CI tool dependencies — runs entirely on GitHub |
| 🐍 Flask + Gunicorn | Lightweight Python application stack for easy customization |

---

## Pipeline

Every push triggers the following automated security gate:

```
Developer Push
      │
      ▼
┌─────────────────────┐
│   1. BUILD          │  Docker image built in sterile GitHub-hosted runner
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│   2. SCAN           │  Trivy scans container filesystem for CVEs
│   (Trivy)           │  OS packages + Python library dependencies
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│   3. ENFORCE        │  Build FAILS if Critical / High vulnerabilities found
│   (Fail-Fast)       │  Zero tolerance policy — no exceptions
└──────────┬──────────┘
           │
      Pass │ Fail
      ┌────┴────┐
      ▼         ▼
  ✅ Ready   ❌ Blocked
  for deploy  Fix required
```

---

## Architecture

```
Repository
├── app.py                   ← Flask application
├── requirements.txt         ← Python dependencies (scanned by Trivy)
├── Dockerfile               ← Hardened multi-stage build
└── .github/
    └── workflows/
        └── devsecops.yml    ← CI/CD + Security pipeline definition
```

### Dockerfile Design Principles

- **Multi-stage build** — separates build dependencies from the final runtime image
- **Non-root user** — container runs as an unprivileged user by default
- **Minimal base image** — reduces the number of packages exposed to CVEs

---

## Tech Stack

| Layer | Technology |
|---|---|
| CI/CD | [GitHub Actions](https://github.com/features/actions) |
| Containerization | [Docker](https://www.docker.com/) |
| Vulnerability Scanner | [Trivy](https://github.com/aquasecurity/trivy) by Aqua Security |
| Application Runtime | [Python Flask](https://flask.palletsprojects.com/) + [Gunicorn](https://gunicorn.org/) |
| IaC (optional) | Terraform-compatible hardened modules |

---

## Getting Started

### Prerequisites

- ✅ **Docker** installed locally
- ✅ **Python 3.10+** (for local development)
- ✅ **Trivy** (optional — for running scans locally before pushing)

```bash
# Install Trivy locally (macOS)
brew install trivy

# Install Trivy locally (Linux)
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh
```

---

### Local Development

```bash
# 1. Clone the repository
git clone https://github.com/Taeaps561/devsecops-boilerplate.git
cd devsecops-boilerplate

# 2. Install Python dependencies
pip install -r requirements.txt

# 3. Run the application locally
python app.py
```

---

### Running the Pipeline

The pipeline triggers automatically on every push to any branch. To run a scan manually:

```bash
# Build the Docker image locally
docker build -t devsecops-boilerplate .

# Run a Trivy scan locally (mirrors the CI behavior)
trivy image --severity HIGH,CRITICAL devsecops-boilerplate
```

> ✅ **Tip:** Run the Trivy scan locally before pushing to catch vulnerabilities early and avoid CI failures.

---

## Security Policy

This boilerplate enforces the following security gates:

| Severity | Policy |
|---|---|
| 🔴 CRITICAL | ❌ Build blocked — must fix before merge |
| 🟠 HIGH | ❌ Build blocked — must fix before merge |
| 🟡 MEDIUM | ⚠️ Warning only — does not block |
| 🟢 LOW | ✅ Allowed — informational only |

Customize thresholds in `.github/workflows/devsecops.yml` to match your organization's risk appetite.

---

## Project Structure

```
devsecops-boilerplate/
│
├── app.py                    # Python Flask application
├── requirements.txt          # Python dependencies
├── Dockerfile                # Hardened multi-stage Docker build
│
└── .github/
    └── workflows/
        └── devsecops.yml     # GitHub Actions pipeline definition
```

---

## References / Useful Resources

- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Security Best Practices](https://docs.docker.com/build/building/best-practices/)
- [OWASP DevSecOps Guideline](https://owasp.org/www-project-devsecops-guideline/)
- [NIST Secure Software Development Framework](https://csrc.nist.gov/Projects/ssdf)
- [CIS Docker Benchmark](https://www.cisecurity.org/benchmark/docker)

---

## My Notes

> 📝 This boilerplate was built to demonstrate a practical "shift-left" security approach — integrating vulnerability scanning directly into the CI/CD loop rather than treating it as a post-deployment concern. Fork it, adapt the scan thresholds, and layer in your own IaC modules to build a full DevSecOps platform.

---

## License

MIT License. Created as part of the **DevSecOps-as-a-Service** portfolio.

---

*Secure by default. Automated by design. Built for defenders.*
