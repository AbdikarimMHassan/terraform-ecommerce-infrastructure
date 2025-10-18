# create application load balancer
# terraform aws create application load balancer
resource "aws_lb" "application_load_balancer" {
  name               = var.name
  internal           = false
  load_balancer_type = var.alb_type
  security_groups    = var.alb_sg_id
  subnets = var.alb_subnet_ids

  enable_deletion_protection = false

  tags   = {
    Name = "dev-alb"
  }
}

# create target group
# terraform aws create target group
resource "aws_lb_target_group" "alb_target_group" {
  name        = var.alb_tg
  target_type = var.alb_target_type
  port        = var.alb_port
  protocol    = var.alb_protocol
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = var.healthy_threshold
    interval            = var.interval
    matcher             = var.matcher
    path                = var.path
    port                = var.port_name
    protocol            = var.alb_protocol
    timeout             = var.timeout
    unhealthy_threshold = var.unhealthy_threshold
  }
}

# create a listener on port 80 with redirect action
# terraform aws create listener
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = var.alb_port
  protocol          = var.alb_protocol

  default_action {
    type = "redirect"

    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = var.listener_redirect_port
      protocol    = var.listener_redirect_protocol
      status_code = "HTTP_301"
    }
  }
}

# create a listener on port 443 with forward action
# terraform aws create listener
resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn  = aws_lb.application_load_balancer.arn
  port               = var.listener_forward_port
  protocol           = var.listener_forward_protocol
  ssl_policy         = "ELBSecurityPolicy-2016-08"
  certificate_arn    = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

