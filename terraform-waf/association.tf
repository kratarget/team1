# Optional: Associate WAF with an ALB or API Gateway
resource "aws_wafv2_web_acl_association" "team1-waf-seahorse" {
  resource_arn = "arn:aws:elasticloadbalancing:eu-west-1:419387516581:loadbalancer/app/k8s-argocd-ingressa-12aff5db28/5693baa3104c1383"
  web_acl_arn  = aws_wafv2_web_acl.team1-waf-seahorse.arn
}