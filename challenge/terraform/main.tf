terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "crewmeister" {
  metadata {
    name = "crewmeister"
  }
}

resource "kubernetes_secret" "crewmeister_secrets" {
  metadata {
    name      = "crewmeister-secrets"
    namespace = kubernetes_namespace.crewmeister.metadata[0].name
  }

  data = {
    DB_USERNAME = "crew_user"
    DB_PASSWORD = "securepassword"
  }

  type = "Opaque"
}

resource "helm_release" "crewmeister" {
  name      = "crewmeister"
  chart     = "./challenge/helm-chart"
  namespace = kubernetes_namespace.crewmeister.metadata[0].name

  set {
    name  = "replicaCount"
    value = var.replica_count
  }

  set {
    name  = "image.repository"
    value = split(":", var.image)[0]
  }

  set {
    name  = "image.tag"
    value = split(":", var.image)[1]
  }
}
