# 🚀 Crewmeister Kubernetes Deployment

This repository contains a fully automated CI/CD pipeline to deploy the Crewmeister challenge application to a **Kubernetes** cluster using **GitHub Actions, Terraform, and Helm**. The deployment includes **monitoring, auto-scaling, and ingress configuration**.

---

## 📑 Table of Contents

- [📌 Features](#-features)
- [📦 Project Structure](#-project-structure)
- [⚙️ Prerequisites](#️-prerequisites)
- [🚀 Deployment Steps](#-deployment-steps)
- [📜 GitHub Actions Workflow](#-github-actions-workflow)
- [🏗️ Infrastructure with Terraform](#️-infrastructure-with-terraform)
- [📜 Helm Chart](#-helm-chart)
- [📊 Monitoring & Auto-Scaling](#-monitoring--auto-scaling)
- [🔄 Deploy Updates](#-deploy-updates)
- [🎯 Useful Commands](#-useful-commands)
- [📌 Conclusion](#-conclusion)

---

## 📌 Features

✅ **Automated CI/CD Pipeline** – Build, push, and deploy using GitHub Actions  
✅ **Infrastructure as Code** – Uses Terraform to manage Kubernetes resources  
✅ **Helm Chart** – Simplifies Kubernetes deployments  
✅ **Monitoring with Prometheus & Grafana** – Includes dashboards & service monitoring  
✅ **Auto-scaling** – HPA for dynamic scaling based on CPU usage  
✅ **Ingress with TLS** – Configured with Nginx and Let's Encrypt

---

## ⚙️ Prerequisites

Before deploying, ensure you have the following installed:

- **Docker** 🐳 → [Install](https://docs.docker.com/get-docker/)
- **Kubernetes (kubectl)** ☸️ → [Install](https://kubernetes.io/docs/tasks/tools/)
- **Helm** ⛵ → [Install](https://helm.sh/docs/intro/install/)
- **Terraform** ⛰️ → [Install](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- **GitHub CLI (Optional)** → [Install](https://cli.github.com/)

---

## 🚀 Deployment Steps

### 1️⃣ Clone the Repository

Clone the repository to your local machine:

```sh
git clone https://github.com/RichieTheDev/crewmeister_package.git
cd crewmeister_package
```

### 2️⃣ Set Up Your Kubernetes Cluster

#### For Local Development (Minikube)

Start Minikube:

```sh
minikube start
kubectl config use-context minikube
```

#### For Cloud Kubernetes Providers (AWS EKS, GKE, AKS)

Ensure your `KUBECONFIG` is set up:

```sh
kubectl config current-context
```

### 3️⃣ Configure Secrets in GitHub

Go to **Settings** → **Secrets and variables** → **Actions** in your repository and add:

| Secret Name       | Description                    |
| ----------------- | ------------------------------ |
| DOCKER_USERNAME   | Docker Hub username            |
| DOCKER_PASSWORD   | Docker Hub password            |
| KUBE_CONFIG       | Base64 encoded kubeconfig file |
| TF_VAR_dbUser     | Database username              |
| TF_VAR_dbPassword | Database password              |

### 4️⃣ Build & Push the Docker Image

Build the Docker image:

```sh
docker build -t docker.io/YOUR_DOCKER_USERNAME/crewmeister-challenge:latest .
```

Push the image to Docker Hub:

```sh
docker login
docker push docker.io/YOUR_DOCKER_USERNAME/crewmeister-challenge:latest
```

Run the container:

```sh
docker run -p 8080:8080 crewmeister-challenge:latest
```

**Note**: Replace `YOUR_DOCKER_USERNAME` with your actual Docker Hub username.

### 5️⃣ Deploy Using GitHub Actions

Push to the main branch to trigger deployment:

```sh
git push origin main
```

GitHub Actions will:

- Run tests
- Build & push Docker image
- Deploy to Kubernetes using Terraform & Helm

---

## 📜 GitHub Actions Workflow

Located in `.github/workflows/deploy.yml`, this workflow automates:

- Build & Test
- Docker Build & Push
- Kubernetes Deployment
- Monitoring Setup

---

## 🏗️ Infrastructure with Terraform

Terraform manages:

- Helm Deployment
- Kubernetes Secrets
- Horizontal Pod Autoscaler
- Ingress

### Deploy with Terraform Manually:

```sh
cd terraform
terraform init
terraform apply -auto-approve
```

---

## 📜 Helm Chart

Located in `challenge/`, it contains:

- `deployment.yaml`
- `service.yaml`
- `ingress.yaml`
- `hpa.yaml`

### Deploy with Helm Manually:

```sh
helm install crewmeister ./challenge/helmchart
```

---

## 📊 Monitoring & Auto-Scaling

### Prometheus & Grafana Setup:

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack
```

---

## 🔄 Deploy Updates

If you make code changes, follow these steps to redeploy:

1. Rebuild & push the Docker image:

   ```sh
   docker build -t docker.io/YOUR_DOCKER_USERNAME/crewmeister-challenge:latest .
   docker push docker.io/YOUR_DOCKER_USERNAME/crewmeister-challenge:latest
   ```

2. Upgrade the Helm deployment:
   ```sh
   helm upgrade --install crewmeister ./challenge/helmchart
   ```

---

## 🎯 Useful Commands

### Check Deployments

```sh
kubectl get pods
kubectl get deployments
kubectl get services
kubectl get ingress
```

### View Logs

```sh
kubectl logs -f deployment/crewmeister
```

### Scale Manually

```sh
kubectl scale deployment crewmeister --replicas=5
```

### Access Prometheus/Grafana (Port Forwarding)

```sh
kubectl port-forward svc/prometheus-grafana 3000:80
```

Access Grafana at: [http://localhost:3000](http://localhost:3000)

---

## 📌 Conclusion

This setup provides a robust, automated pipeline for deploying applications to Kubernetes. 🚀

Feel free to contribute, raise issues, or enhance monitoring! 🎯

---

### Key Notes:

1. Replace placeholders like `YOUR_DOCKER_USERNAME` with actual values.
2. Ensure the paths (e.g., `./challenge`) match your project structure.
3. Update the repository URL (`https://github.com/RichieTheDev/crewmeister_package.git`) with your actual repository URL.

---
