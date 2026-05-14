terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_deployment" "petclinic" {
  metadata {
    name = "petclinic"
    labels = {
      app = "petclinic"
    }
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        app = "petclinic"
      }
    }
    template {
      metadata {
        labels = {
          app = "petclinic"
        }
      }
      spec {
        container {
          name  = "petclinic"
          image = "springio/petclinic:latest"
          port {
            container_port = 8080
          }
          resources {
            requests = {
              memory = "512Mi"
              cpu    = "250m"
            }
            limits = {
              memory = "1Gi"
              cpu    = "500m"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "petclinic_svc" {
  metadata {
    name = "petclinic-svc"
  }
  spec {
    selector = {
      app = "petclinic"
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "NodePort"
  }
}