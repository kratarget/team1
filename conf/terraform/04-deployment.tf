resource "kubernetes_secret" "ghcr_dockerconfig" {
  metadata {
    name      = "ghcr-docker-config"
    namespace = "default"
  }

  data = {
    ".dockerconfigjson" = base64encode(
      jsonencode({
        auths = {
          "ghcr.io" = {
            username = var.ghcr_username
            password = var.ghcr_token
            auth     = base64encode("${var.ghcr_username}:${var.ghcr_token}")
          }
        }
      })
    )
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_deployment" "app" {
  metadata {
    name      = "private-app-deployment"
    namespace = "default"
    labels = {
      app = "private-app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "private-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "private-app"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret.ghcr_dockerconfig.metadata[0].name
        }

        container {
          name  = "private-app"
          image = var.github_container_registry

          ports {
            container_port = 80
            name           = "http"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_service" {
  metadata {
    name      = "private-app-service"
    namespace = "default"
    labels = {
      app = "private-app"
    }
  }

  spec {
    selector = {
      app = "private-app"
    }

    port {
      name        = "http"
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
