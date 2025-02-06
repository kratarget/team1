output "alb_dns_name" {
  description = "DNS name of the ALB from the Ingress"
  value       = kubernetes_ingress_v1.app_ingress.status[0].load_balancer[0].ingress[0].hostname
}
