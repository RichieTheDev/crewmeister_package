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

### 1️⃣ Clone the repository

````sh
git clone https://github.com/RichieTheDev/crewmeister_package.git


# Kubernetes Deployment with GitHub Actions, Terraform & Helm

## 2️⃣ Set up Kubernetes Cluster (if not already done)
If you don't have a Kubernetes cluster, you can use Minikube:

```sh
minikube start
kubectl config use-context minikube
````

Or create a managed Kubernetes cluster (e.g., AWS EKS, Google GKE, Azure AKS).

## 3️⃣ Configure Secrets in GitHub

Go to **Settings** → **Secrets and variables** → **Actions** in your repository and add:

| Secret Name       | Description                    |
| ----------------- | ------------------------------ |
| DOCKER_USERNAME   | Docker Hub username            |
| DOCKER_PASSWORD   | Docker Hub password            |
| KUBE_CONFIG       | Base64 encoded kubeconfig file |
| TF_VAR_dbUser     | Database username              |
| TF_VAR_dbPassword | Database password              |

## 4️⃣ Deploy Using GitHub Actions

Push to the main branch to trigger deployment:

```sh
git push origin main
```

GitHub Actions will:

- Run tests
- Build & push Docker image
- Deploy to Kubernetes using Terraform & Helm

## 📜 GitHub Actions Workflow

Located in `.github/workflows/deploy.yml`, this workflow automates:

- Build & Test
- Docker Build & Push
- Kubernetes Deployment
- Monitoring Setup

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

## 📜 Helm Chart

Located in `helm-chart/`, it contains:

- `deployment.yaml`
- `service.yaml`
- `ingress.yaml`
- `hpa.yaml`

### Deploy with Helm Manually:

```sh
helm install crewmeister ./helm-chart
```

## 📊 Monitoring & Auto-Scaling

### Prometheus & Grafana Setup:

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack
```

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

## 📌 Conclusion

This setup provides a robust, automated pipeline for deploying applications to Kubernetes. 🚀

Feel free to contribute, raise issues, or enhance monitoring! 🎯
