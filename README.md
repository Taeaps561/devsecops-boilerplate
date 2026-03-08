# 🛡️ DevSecOps-as-a-Service Boilerplate

This repository demonstrates a **hardened CI/CD pipeline** designed for modern cloud native applications. It shifts security to the "left" by integrating automated vulnerability scanning directly into the development workflow.

## ✨ Key Features

- **Hardened Docker Image**: Multi-stage build using a non-root user to minimize attack surface.
- **Automated Scanning (Trivy)**: Scans every push for OS and library-level vulnerabilities.
- **Fail-Fast Policy**: Automatically blocks deployments if "Critical" or "High" vulnerabilities are detected.
- **Infrastructure as Code (IaC) Ready**: Designed to be deployed with Terraform-hardened modules.

## 🚀 The Pipeline

1. **Commit**: Developer pushes code.
2. **Build**: Docker image is built in a sterile GitHub environment.
3. **Scan**: [Trivy](https://github.com/aquasecurity/trivy) performs a deep scan of the container filesystem.
4. **Enforce**: Build fails if security requirements aren't met.
5. **Ready**: Verified image is tagged for secure deployment.

## 🛠️ Tech Stack

- **CI/CD**: GitHub Actions
- **Containerization**: Docker
- **Security**: Trivy
- **App**: Python Flask + Gunicorn

---
*Created as part of the DevSecOps-as-a-Service portfolio.*
