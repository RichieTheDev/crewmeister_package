terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_ingress_v1" "crewmeister" {
  metadata {
    name = "crewmeister-ingress"
    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
    }
  }

  spec {
    rule {
      host = "crewmeister.${var.environment}.com"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "crewmeister-service"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
