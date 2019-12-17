resource "aws_lb" "simplr-nlb" {
  name               = "simplr-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnets

  enable_deletion_protection = false

   target_groups = [
    {
      name_prefix          = "simplr-nlb-tg"
      backend_protocol     = "TCP"
      backend_port         = 80
      target_type          = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 10
      }
    },
  ]
}