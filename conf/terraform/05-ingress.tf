resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name      = "private-app-ingress"
    namespace = "default"
    annotations = {
      "kubernetes.io/ingress.class"                   = "alb"
      "alb.ingress.kubernetes.io/scheme"              = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"         = "ip"

      # Expose on port 80:
      "alb.ingress.kubernetes.io/listen-ports"        = jsonencode([
        {
          "HTTP" = 80
        }
      ])
    }
  }

  spec {
    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.app_service.metadata[0].name
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
