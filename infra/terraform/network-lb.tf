resource "aws_lb" "simplr-nlb" {
  name               = "simplr-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnets

  enable_deletion_protection = false

  
}

resource "aws_lb_target_group" "simplr-nlb-tg" {
  name        = "simplr-nlb-tg"
  port        = 80
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = var.vpcid
    health_check {
    interval            = 30
    protocol            = "TCP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}


resource "aws_lb_listener" "simple-nlb-listener" {
 
  load_balancer_arn = aws_lb.simplr-nlb.arn

  port     = 80
  protocol = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.simplr-nlb-tg.arn
    type             = "forward"
  }
}


